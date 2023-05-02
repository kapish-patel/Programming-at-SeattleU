import array
import datetime
import ipaddress

# to serialize ip
def Ip_Port_serializer(Ip, Port) -> bytes:
    bytes_Ip = ipaddress.IPv4Address(Ip).packed # convert string ip to IP format
    print("Serialized IP: ", bytes_Ip)
    bytes_Port = Port.to_bytes(2, 'big')
    Ip_Port_Bytes = bytes_Ip + bytes_Port
    return Ip_Port_Bytes

# to deserialize ip
def deserialize_utcdatetime(data: bytes) -> datetime:
    epoch = datetime.datetime(1970, 1, 1)
    temp_arr = array.array('Q')
    temp_arr.frombytes(data)
    temp_arr.byteswap()
    micros = int(temp_arr[0])
    detime = epoch + datetime.timedelta(microseconds=micros)
    return detime

# to deserialize price
def deserialize_price(data: bytes) -> float:
    temp_arr = array.array('d')
    temp_arr.frombytes(data)
    return temp_arr[0]

# to demarshal message
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

