"""
Forex Provider
(c) all rights reserved

This module contains useful marshalling functions for manipulating Forex Provider packet contents.
"""
import ipaddress
from array import array
from datetime import datetime

MAX_QUOTES_PER_MESSAGE = 50
MICROS_PER_SECOND = 1_000_000


def serialize_price(x: float) -> bytes:
    """
    Convert a float to a byte array used in the price feed messages.

    >>> serialize_price(9006104071832581.0)  # that's 0504030201ff3f43 in hex on a little-endian ieee754 machine
    b'\\x05\\x04\\x03\\x02\\x01\\xff?C'

    :param x: number to be converted
    :return: bytes suitable to to be sent in a Forex Provider message
    """
    a = array('d', [x])  # array of 8-byte floating-point numbers
    return a.tobytes()


def deserialize_address(b: bytes) -> (str, int):
    """
    Get the host, port address that the client wants us to publish to.

    >>> deserialize_address(b'\\x7f\\x00\\x00\\x01\\xff\\xfe')
    ('127.0.0.1', 65534)

    :param b: 6-byte sequence in subscription request
    :return: ip address and port pair
    """
    ip = ipaddress.ip_address(b[0:4])
    p = array('H')
    p.frombytes(b[4:6])
    p.byteswap()  # to big-endian
    return str(ip), p[0]


def serialize_utcdatetime(utc: datetime) -> bytes:
    """
    Convert a UTC datetime into a byte stream for a Forex Provider message.
    A 64-bit integer number of microseconds that have passed since 00:00:00 UTC on 1 January 1970
    (excluding leap seconds). Sent in big-endian network format.

    >>> serialize_utcdatetime(datetime(1971, 12, 10, 1, 2, 3, 64000))
    b'\\x00\\x007\\xa3e\\x8e\\xf2\\xc0'

    :param utc: timestamp to convert to desired byte format
    :return: 8-byte stream
    """
    epoch = datetime(1970, 1, 1)
    micros = (utc - epoch).total_seconds() * MICROS_PER_SECOND
    a = array('Q', [int(micros)])
    a.byteswap()  # convert to big-endian
    return a.tobytes()


def marshal_message(quote_sequence) -> bytes:
    """
    Construct the byte stream for a message with given quote_sequence.

    >>> b = marshal_message([{'timestamp': datetime(2006,1,2), 'cross': 'GBP/USD', 'price': 1.22041}, \
                             {'timestamp': datetime(2006,1,1), 'cross': 'USD/JPY', 'price': 108.2755}])
    >>> len(b)  # each record is 32 bytes, so 2 of those in this test
    64
    >>> b[:32]  # first record is first 32 bytes
    b'\\x00\\x04\\tT\\xdd5@\\x00GBPUSD\\xbba\\xdb\\xa2\\xcc\\x86\\xf3?\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00'
    >>> b[32:]  # second record is next 32 bytes (all sent together in the UDP datagram)
    b'\\x00\\x04\\t@\\xbf]\\xe0\\x00USDJPY\\x12\\x83\\xc0\\xca\\xa1\\x11[@\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00'

    :param quote_sequence: list of quote structures ('cross' and 'price', may also have 'timestamp')
    :return: byte stream to send in UDP message
    """
    if len(quote_sequence) > MAX_QUOTES_PER_MESSAGE:
        raise ValueError('max quotes exceeded for a single message')
    message = bytes()
    default_time = serialize_utcdatetime(datetime.utcnow())
    padding = b'\x00' * 10  # 10 bytes of zeros
    for quote in quote_sequence:
        if 'timestamp' in quote:
            message += serialize_utcdatetime(quote['timestamp'])
        else:
            message += default_time
        message += quote['cross'][0:3].encode('utf-8')
        message += quote['cross'][4:7].encode('utf-8')
        message += serialize_price(quote['price'])
        message += padding
    return message


def deserialize_utcdatetime(data: bytes) -> datetime:
    epoch = datetime(1970, 1, 1)
    temp_arr = array('Q')
    temp_arr.frombytes(data)
    temp_arr.byteswap()
    micros = int(temp_arr[0])
    detime = epoch + timedelta(microseconds=micros)
    return detime


def deserialize_price(data: bytes) -> float:
    temp_arr = array('d')
    temp_arr.frombytes(data)
    return temp_arr[0]


def unmarshal_message(data: bytes):
    """
    Bytes[0:8] == date time
    Bytes[8:14] == currency names
    Bytes[14:22] == exchange rate
    Bytes[22:32] == Reserved.
    """
    data_size = len(data)
    msg = []
    for i in range(0, data_size, 32):   # 32 is the size of msg
        each_packet = data[i:i+32]
        dt = deserialize_utcdatetime(each_packet[0:8])
        from_currency = each_packet[8:11].decode('utf-8')
        to_currency = each_packet[11:14].decode('utf-8')
        price = deserialize_price(each_packet[14:22])
        msg.append({'time': dt, 'from': from_currency, 'to': to_currency, 'price': price})
    return msg

