'''

CPSC 5520 Distributed Systems
Seattle University
This is free and unencumbered software released into the public domain.
:Authors: Kapish Patel

DISCLAIMER:
  This Program is running smooth but sometimes there might be some errors and some messages
  won't be able to send or receive so please re-start the program Thankyou
    I have hard coded the IP address, SUID which was working for me from node_main.txt

USAGE:
  This Program is made to retrieve the bitcoin block which has id = SUID % 10000,
  but I haven't yet completed the whole program, but I have made it till the get block message

NOTE:
    Output at the end of code
EXAMPLE:
  python3 lab5.py

'''

from hashlib import sha256
from enum import Enum
import time
import socket

HDR_SZ = 24 # header size
BUFFER_SIZE = 1024
VERSION = 70015
MAGIC = bytes.fromhex('f9beb4d9')  # char[4]


# Enum class for services
class SERVICES(Enum):
    Unnamed = 0x00
    NODE_NETWORK = 0x01
    NODE_GETUTXO = 0x02
    NODE_BLOOM = 0x04
    NODE_WITNESS = 0x08
    NODE_XTHIN = 0x10
    NODE_NETWORK_LIMITED = 0x0400


# utility class help to manage datatypes
class BitUtils:
    @staticmethod
    def ipv6_from_ipv4(ipv4_str):
        pchIPv4 = bytearray([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0xff, 0xff])
        return pchIPv4 + bytearray((int(x) for x in ipv4_str.split('.')))

    @staticmethod
    def ipv6_to_ipv4(ipv6):
        return '.'.join([str(b) for b in ipv6[12:]])

    @staticmethod
    def uint8_t(n):
        return int(n).to_bytes(1, byteorder='little', signed=False)

    @staticmethod
    def uint16_t(n):
        return int(n).to_bytes(2, byteorder='little', signed=False)

    @staticmethod
    def int32_t(n):
        return int(n).to_bytes(4, byteorder='little', signed=True)

    @staticmethod
    def uint32_t(n):
        return int(n).to_bytes(4, byteorder='little', signed=False)

    @staticmethod
    def int64_t(n):
        return int(n).to_bytes(8, byteorder='little', signed=True)

    @staticmethod
    def uint64_t(n):
        return int(n).to_bytes(8, byteorder='little', signed=False)

    @staticmethod
    def unmarshal_int(b):
        return int.from_bytes(b, byteorder='little', signed=True)

    @staticmethod
    def unmarshal_uint(b):
        return int.from_bytes(b, byteorder='little', signed=False)

    @staticmethod
    def compactsize_t(n):
        if n < 252:
            return BitUtils.uint8_t(n)
        if n < 0xffff:
            return BitUtils.uint8_t(0xfd) + BitUtils.uint16_t(n)
        if n < 0xffffffff:
            return BitUtils.uint8_t(0xfe) + BitUtils.uint32_t(n)
        return BitUtils.uint8_t(0xff) + BitUtils.uint64_t(n)

    @staticmethod
    def unmarshal_compactsize(b):
        key = b[0]
        if key == 0xff:
            return b[0:9], BitUtils.unmarshal_uint(b[1:9])
        if key == 0xfe:
            return b[0:5], BitUtils.unmarshal_uint(b[1:5])
        if key == 0xfd:
            return b[0:3], BitUtils.unmarshal_uint(b[1:3])
        return b[0:1], BitUtils.unmarshal_uint(b[0:1])

    @staticmethod
    def bool_t(flag):
        return BitUtils.uint8_t(1 if flag else 0)

    @staticmethod
    def set_findblock(n):
        return n % 10000

    @staticmethod
    def print_header(header, expected_cksum=None):
        """
        Report the contents of the given bitcoin message header
        :param header: bitcoin message header (bytes or bytearray)
        :param expected_cksum: the expected checksum for this version message, if known
        :return: message type
        """
        magic, command_hex, payload_size, cksum = header[:4], header[4:16], header[16:20], header[20:]
        command = str(bytearray([b for b in command_hex if b != 0]), encoding='utf-8')
        psz = BitUtils.unmarshal_uint(payload_size)
        if expected_cksum is None:
            verified = ''
        elif expected_cksum == cksum:
            verified = '(verified)'
        else:
            verified = '(WRONG!! ' + expected_cksum.hex() + ')'
        prefix = '  '
        print(prefix + 'HEADER')
        print(prefix + '-' * 56)
        prefix *= 2
        print('{}{:32} magic'.format(prefix, magic.hex()))
        print('{}{:32} command: {}'.format(prefix, command_hex.hex(), command))
        print('{}{:32} payload size: {}'.format(prefix, payload_size.hex(), psz))
        print('{}{:32} checksum {}'.format(prefix, cksum.hex(), verified))
        return command

    @staticmethod
    def print_version_msg(b):
        """
        Report the contents of the given bitcoin version message (sans the header)
        :param payload: version message contents
        """
        # pull out fields
        version, my_services, epoch_time, your_services = b[:4], b[4:12], b[12:20], b[20:28]
        rec_host, rec_port, my_services2, my_host, my_port = b[28:44], b[44:46], b[46:54], b[54:70], b[70:72]
        nonce = b[72:80]
        user_agent_size, uasz = BitUtils.unmarshal_compactsize(b[80:])
        i = 80 + len(user_agent_size)
        user_agent = b[i:i + uasz]
        i += uasz
        start_height, relay = b[i:i + 4], b[i + 4:i + 5]
        extra = b[i + 5:]

        # print report
        prefix = '  '
        print(prefix + 'VERSION')
        print(prefix + '-' * 56)
        prefix *= 2
        print('{}{:32} version {}'.format(prefix, version.hex(), BitUtils.unmarshal_int(version)))
        print('{}{:32} my services'.format(prefix, my_services.hex()))
        time_str = time.strftime("%a, %d %b %Y %H:%M:%S GMT", time.gmtime(BitUtils.unmarshal_int(epoch_time)))
        print('{}{:32} epoch time {}'.format(prefix, epoch_time.hex(), time_str))
        print('{}{:32} your services'.format(prefix, your_services.hex()))
        print('{}{:32} your host {}'.format(prefix, rec_host.hex(), BitUtils.ipv6_to_ipv4(rec_host)))
        print('{}{:32} your port {}'.format(prefix, rec_port.hex(), BitUtils.unmarshal_uint(rec_port)))
        print('{}{:32} my services (again)'.format(prefix, my_services2.hex()))
        print('{}{:32} my host {}'.format(prefix, my_host.hex(), BitUtils.ipv6_to_ipv4(my_host)))
        print('{}{:32} my port {}'.format(prefix, my_port.hex(), BitUtils.unmarshal_uint(my_port)))
        print('{}{:32} nonce'.format(prefix, nonce.hex()))
        print('{}{:32} user agent size {}'.format(prefix, user_agent_size.hex(), uasz))
        print('{}{:32} user agent \'{}\''.format(prefix, user_agent.hex(), str(user_agent, encoding='utf-8')))
        print('{}{:32} start height {}'.format(prefix, start_height.hex(), BitUtils.unmarshal_uint(start_height)))
        print('{}{:32} relay {}'.format(prefix, relay.hex(), bytes(relay) != b'\0'))
        if len(extra) > 0:
            print('{}{:32} EXTRA!!'.format(prefix, extra.hex()))

    @staticmethod
    def print_message(msg, text=None):
        """
        Report the contents of the given bitcoin message
        :param msg: bitcoin message including header
        :return: message type
        """
        print('\n{}MESSAGE'.format('' if text is None else (text + ' ')))
        print('({}) {}'.format(len(msg), msg[:60].hex() + ('' if len(msg) < 60 else '...')))
        payload = msg[HDR_SZ:]
        command = BitUtils.print_header(msg[:HDR_SZ])
        if command == 'version':
            BitUtils.print_version_msg(payload)


# Header class to manage header
class Header:
    def __init__(self, commandname, payload):
        self.start_string = MAGIC
        self.command_name = bytes(commandname, 'utf-8').ljust(12, b'\0')  # char[12]
        len_of_payload = len(payload)
        self.payload_size = BitUtils.uint32_t(len_of_payload)
        hash_of_payload = sha256(sha256(payload).digest()).digest()  # Hash256(256(Payload)) must be in bytes
        self.check_sum = hash_of_payload[:4]  # char[4] extract first 4 bytes and make it check sum
        self.header = self.set_header()

    # function which set the header variable
    def set_header(self):
        header_string = self.start_string + self.command_name + self.payload_size + self.check_sum
        return header_string
        # print(f"Header is: {header.hex()} and length of header is: {len(header)}")

    # function to get the header
    def get_header(self):
        return self.header


# payload class to make version payload
class PayLoad:
    def __init__(self, services, myservices, myip, myport, nodeservice, nodeip, nodeport, nonce, useragent,
                 startheight, relay):
        # Payload variables Start
        self.version = BitUtils.int32_t(VERSION)  # int_32
        self.services = BitUtils.uint64_t(services)  # uint64 0x00
        self.timestamp = BitUtils.int64_t(time.time())  # int64
        self.addr_recv_service = BitUtils.uint64_t(myservices)  # uint64 0x01
        self.addr_recv_IPaddr = BitUtils.ipv6_from_ipv4(myip)  # char[16]
        self.addr_recv_port = BitUtils.uint16_t(myport)  # uint16
        self.addr_trans_service = BitUtils.uint64_t(nodeservice)  # uint64 0x00
        self.addr_trans_IPaddr = BitUtils.ipv6_from_ipv4(nodeip)  # char[16]
        self.addr_trans_port = BitUtils.uint16_t(nodeport)  # uint16
        self.nonce = BitUtils.uint64_t(nonce)  # uint64
        self.user_agent = bytes(useragent, 'utf-8')  # string
        self.user_agent_bytes = BitUtils.compactsize_t(len(self.user_agent))  # uint
        self.start_height = BitUtils.int32_t(startheight)  # int32
        self.relay = BitUtils.bool_t(relay)  # bool
        # Payload variable End
        self.payload = self.set_payload()

    def set_payload(self):
        payload_string = self.version + self.services + self.timestamp + self.addr_recv_service + \
                         self.addr_recv_IPaddr + self.addr_recv_port + self.addr_trans_service + \
                         self.addr_trans_IPaddr + self.addr_trans_port + self.nonce + self.user_agent_bytes + \
                         self.user_agent + self.start_height + self.relay
        return payload_string
        # print(f"Payload is: {payload.hex()} and length of payload is: {len(payload)}")

    def get_payload(self):
        return self.payload


class GetBlocks:
    def __init__(self, hash_count, block_header_hash, stop_hash):
        # Payload variables Start
        self.version = BitUtils.uint32_t(VERSION)
        self.hash_count = BitUtils.compactsize_t(hash_count)
        self.block_header_hashes = bytes(block_header_hash, 'utf-8').ljust(32, b'\0')
        self.stop_hash = bytes(stop_hash, 'utf-8').ljust(32, b'\0')
        self.getblocks = self.set_get_blocks()
        # Payload variable End

    # function which set the payload variable
    def set_get_blocks(self):
        get_block_string = self.version + self.hash_count + self.block_header_hashes + self.stop_hash
        return get_block_string
        # print(f"Payload is: {payload.hex()} and length of payload is: {len(payload)}")

    # function to get the payload
    def get_payload(self):
        return self.getblocks


# main bitcoin class to manages messages
class BitCoin:
    def __init__(self, block_number):
        self.find_block = BitUtils.set_findblock(block_number)
        self.sock, self.address = self.listner()
        self.myip, self.myport = self.address
        self.bitip = '88.99.149.100' # ip address which was working for me as on 3 dec 11:00:00
        self.bitport = 8333
        self.mostRecentBlockHash = "000000000019d6689c085ae165831e934ff763ae46a2a6c172b3f1b60a8ce26f" # first block of bitcoin
        self.blocklist = [self.mostRecentBlockHash]

    # helper function which bind ip and port
    @staticmethod
    def listner():
        hostname = socket.gethostname()
        ip = socket.gethostbyname(hostname)
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        sock.bind((ip, 0))
        return sock, sock.getsockname()

    # function whichstart the process of sending version message
    def send_version(self):
        payload = PayLoad(SERVICES.Unnamed.value, 0x01, self.myip, self.myport, 0x00, self.bitip, self.bitport, 0, '',
                          0, 0)
        header = Header('version', payload.get_payload())
        message = header.get_header() + payload.get_payload()
        self.send_v_message(message, header, payload)

    # function which sends the version message
    def send_v_message(self, message, header, payload):
        print(' =' * 100)
        print("SENDING MESSAGE")
        print(' =' * 100)
        print(f"Sending Message: {message.hex()}")
        BitUtils.print_header(header.get_header())
        BitUtils.print_version_msg(payload.get_payload())
        print(' =' * 100)
        print("RECEIVING MESSAGE")
        print(' =' * 100)
        self.sock.connect((self.bitip, self.bitport))
        self.sock.sendall(message)
        msg_header = self.sock.recv(HDR_SZ)
        BitUtils.print_header(msg_header)
        payloadsize = BitUtils.unmarshal_uint(msg_header[16:20])
        msg_payload = self.sock.recv(payloadsize)
        BitUtils.print_version_msg(msg_payload)

    # function which start the process of sending vereck message
    def send_vereck(self):
        payload = b''
        header = Header('verack', payload)
        message = header.get_header()
        self.send_vrec_message(message, header)

    # function to send vereck message
    def send_vrec_message(self, message, header):
        print(' =' * 100)
        print("SENDING MESSAGE")
        print(' =' * 100)
        print(f"Sending Message: {message.hex()}")
        BitUtils.print_header(header.get_header())
        self.sock.sendall(message)
        print(' =' * 100)
        print("RECEIVING MESSAGE")
        print(' =' * 100)
        expected_command = 'feefilter'
        self.recv_msg_helper(expected_command)

    # functio which start the get block message process
    def send_getblock(self):
        while len(self.blocklist) < self.find_block:
            print(' =' * 100)
            print("SENDING MESSAGE")
            print(' =' * 100)
            message = self.create_get_block_message()
            self.sock.sendall(message)
            BitUtils.print_message(message)
            print(' =' * 100)
            print("RECEIVING MESSAGE")
            print(' =' * 100)
            expected_command = 'inv'
            payload = self.recv_getblock_message(expected_command)
            self.update_data(payload)
        self.fing_block()

    # function which append the array every time a new inv message pass new hashes
    def update_data(self, payload):
        count = BitUtils.unmarshal_compactsize(payload)
        inventory = payload[len(count[0]):]
        size = 32
        for i in range(0, len(inventory), size):
            self.blocklist.append(inventory[i:i+size].hex())

    # function to generate the get block message
    def create_get_block_message(self):
        getblock = GetBlocks(1, self.mostRecentBlockHash, '00000000000000000000000000000000')
        payload = getblock.get_payload()
        header = Header('getblocks', payload)
        header_msg = header.get_header()
        message = header_msg + payload
        return message

    # function to receive message of getblock message (In short inv message)
    def recv_getblock_message(self, expected_command):
        while True:
            command, message, payload = self.recv_single_message()
            if command == expected_command:
                BitUtils.print_message(message)
                return payload

    # function to receive messages
    def recv_msg_helper(self, expected_command):
        while True:
            command, message, payload = self.recv_single_message()
            if command == expected_command:
                print(f' * ' * 10 + f'{expected_command.upper()} MESSAGE FOUND' + ' * ' * 10)
                BitUtils.print_message(message)
                print(f"Payload: {payload.hex()}")
                self.send_getblock()
                return 0
            elif command == 'verack':
                BitUtils.print_message(message)
                print(f"Payload: {payload.hex()}")
            elif command == 'ping':
                BitUtils.print_message(message)
                print(f"Payload: {payload.hex()}")
            elif command == 'sendheaders':
                BitUtils.print_message(message)
                print(f"Payload: {payload.hex()}")
            else:
                BitUtils.print_message(message)
                print(f"Payload: {payload.hex()}")

    # function to receive single message at a time
    def recv_single_message(self):
        message = self.sock.recv(24)
        command = self.get_command(message)
        payloadsize = self.get_payloadsize(message)
        payload = self.recv_payload(payloadsize)
        return command, message, payload

    # helper function which finds command from the header
    @staticmethod
    def get_command(message):
        command = message[4:16]
        command = command.hex()
        command = bytes.fromhex(command)
        command = command.rstrip(b'\x00')
        command_str = str(command, 'utf-8')
        return command_str

    # helper function which finds the size of payload
    @staticmethod
    def get_payloadsize(message):
        payload = message[16:20]
        payload_size = BitUtils.unmarshal_uint(payload)
        return payload_size

    # function to receive payload
    def recv_payload(self, payload_size):
        payload = self.sock.recv(payload_size)
        return payload

    def fing_block(self):
        # find the block from blocklist
        pass


# main function
def main():
    obj = BitCoin(4173214)
    obj.send_version()
    obj.send_vereck()


if __name__ == "__main__":
    main()

'''
I have implemented getblocks message but i am updating hashes which i got from inv message there is where i am stuck. 

OUTPUT:


 = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
SENDING MESSAGE
 = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
Sending Message: f9beb4d976657273696f6e0000000000560000002d2cb9a47f110100000000000000000088468c6300000000010000000000000000000000000000000000ffffc0a80065cee3000000000000000000000000000000000000ffff586395648d200000000000000000000000000000
  HEADER
  --------------------------------------------------------
    f9beb4d9                         magic
    76657273696f6e0000000000         command: version
    56000000                         payload size: 86
    2d2cb9a4                         checksum
  VERSION
  --------------------------------------------------------
    7f110100                         version 70015
    0000000000000000                 my services
    88468c6300000000                 epoch time Sun, 04 Dec 2022 07:04:40 GMT
    0100000000000000                 your services
    00000000000000000000ffffc0a80065 your host 192.168.0.101
    cee3                             your port 58318
    0000000000000000                 my services (again)
    00000000000000000000ffff58639564 my host 88.99.149.100
    8d20                             my port 8333
    0000000000000000                 nonce
    00                               user agent size 0
                                     user agent ''
    00000000                         start height 0
    00                               relay False
 = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
RECEIVING MESSAGE
 = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
  HEADER
  --------------------------------------------------------
    f9beb4d9                         magic
    76657273696f6e0000000000         command: version
    66000000                         payload size: 102
    83959bae                         checksum
  VERSION
  --------------------------------------------------------
    7f110100                         version 70015
    0904000000000000                 my services
    88468c6300000000                 epoch time Sun, 04 Dec 2022 07:04:40 GMT
    0000000000000000                 your services
    00000000000000000000ffffae1559d8 your host 174.21.89.216
    e3ce                             your port 52963
    0904000000000000                 my services (again)
    00000000000000000000000000000000 my host 0.0.0.0
    0000                             my port 0
    dd88aa086b95d16c                 nonce
    10                               user agent size 16
    2f5361746f7368693a302e32302e302f user agent '/Satoshi:0.20.0/'
    7daf0b00                         start height 765821
    01                               relay True
 = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
SENDING MESSAGE
 = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
Sending Message: f9beb4d976657261636b000000000000000000005df6e0e2
  HEADER
  --------------------------------------------------------
    f9beb4d9                         magic
    76657261636b000000000000         command: verack
    00000000                         payload size: 0
    5df6e0e2                         checksum
 = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
RECEIVING MESSAGE
 = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

MESSAGE
(24) f9beb4d976657261636b000000000000000000005df6e0e2
  HEADER
  --------------------------------------------------------
    f9beb4d9                         magic
    76657261636b000000000000         command: verack
    00000000                         payload size: 0
    5df6e0e2                         checksum
Payload:

MESSAGE
(24) f9beb4d973656e646865616465727300000000005df6e0e2
  HEADER
  --------------------------------------------------------
    f9beb4d9                         magic
    73656e646865616465727300         command: sendheaders
    00000000                         payload size: 0
    5df6e0e2                         checksum
Payload:

MESSAGE
(24) f9beb4d973656e64636d70637400000009000000e92f5ef8
  HEADER
  --------------------------------------------------------
    f9beb4d9                         magic
    73656e64636d706374000000         command: sendcmpct
    09000000                         payload size: 9
    e92f5ef8                         checksum
Payload: 000200000000000000

MESSAGE
(24) f9beb4d973656e64636d70637400000009000000ccfe104a
  HEADER
  --------------------------------------------------------
    f9beb4d9                         magic
    73656e64636d706374000000         command: sendcmpct
    09000000                         payload size: 9
    ccfe104a                         checksum
Payload: 000100000000000000

MESSAGE
(24) f9beb4d970696e6700000000000000000800000046cbc2bb
  HEADER
  --------------------------------------------------------
    f9beb4d9                         magic
    70696e670000000000000000         command: ping
    08000000                         payload size: 8
    46cbc2bb                         checksum
Payload: 1a765083fcf50e31

MESSAGE
(24) f9beb4d96164647200000000000000001f0000009ba53b36
  HEADER
  --------------------------------------------------------
    f9beb4d9                         magic
    616464720000000000000000         command: addr
    1f000000                         payload size: 31
    9ba53b36                         checksum
Payload: 0188468c63090400000000000000000000000000000000ffff58639564208d
 *  *  *  *  *  *  *  *  *  * FEEFILTER MESSAGE FOUND *  *  *  *  *  *  *  *  *  *

MESSAGE
(24) f9beb4d966656566696c74657200000008000000e80fd19f
  HEADER
  --------------------------------------------------------
    f9beb4d9                         magic
    66656566696c746572000000         command: feefilter
    08000000                         payload size: 8
    e80fd19f                         checksum
Payload: e803000000000000
 = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
SENDING MESSAGE
 = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

MESSAGE
(125) f9beb4d9676574626c6f636b7300000065000000c26a128b7f1101000130303030303030303030313964363638396330383561653136353833316539...
  HEADER
  --------------------------------------------------------
    f9beb4d9                         magic
    676574626c6f636b73000000         command: getblocks
    65000000                         payload size: 101
    c26a128b                         checksum
 = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
RECEIVING MESSAGE
 = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

MESSAGE
(24) f9beb4d9696e760000000000000000005346000025173c57
  HEADER
  --------------------------------------------------------
    f9beb4d9                         magic
    696e76000000000000000000         command: inv
    53460000                         payload size: 18003
    25173c57                         checksum
 = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
SENDING MESSAGE
 = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

MESSAGE
(125) f9beb4d9676574626c6f636b7300000065000000c26a128b7f1101000130303030303030303030313964363638396330383561653136353833316539...
  HEADER
  --------------------------------------------------------
    f9beb4d9                         magic
    676574626c6f636b73000000         command: getblocks
    65000000                         payload size: 101
    c26a128b                         checksum

'''