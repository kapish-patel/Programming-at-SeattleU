from hashlib import sha256
import socket
import time
import sys

HDR_SZ = 24

hostname = socket.gethostname()
selfip = socket.gethostbyname(hostname)
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM) 
sock.bind((selfip, 0))
selfip, selfport = sock.getsockname()
print(selfip, selfport)
'''
a = 'magic'
hash = sha256(a.encode("utf-8")).hexdigest()
print(f"hash of {a} is {hash}")


a = 86
bytesofa = bytes(a)
hexofa = bytesofa.hex()
print(f"{a} in bytes look like: {bytesofa} and hex look like: {hexofa}")
afromhex = bytes.fromhex(hexofa)
print(f"value of a after conversion from hex to byte: {afromhex}")
'''


def compactsize_t(n):
    if n < 252:
        return uint8_t(n)
    if n < 0xffff:
        return uint8_t(0xfd) + uint16_t(n)
    if n < 0xffffffff:
        return uint8_t(0xfe) + uint32_t(n)
    return uint8_t(0xff) + uint64_t(n)


def unmarshal_compactsize(b):
    key = b[0]
    if key == 0xff:
        return b[0:9], unmarshal_uint(b[1:9])
    if key == 0xfe:
        return b[0:5], unmarshal_uint(b[1:5])
    if key == 0xfd:
        return b[0:3], unmarshal_uint(b[1:3])
    return b[0:1], unmarshal_uint(b[0:1])

def bool_t(flag):
    return uint8_t(1 if flag else 0)


def ipv6_from_ipv4(ipv4_str):
    pchIPv4 = bytearray([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0xff, 0xff])
    return pchIPv4 + bytearray((int(x) for x in ipv4_str.split('.')))


def ipv6_to_ipv4(ipv6):
    return '.'.join([str(b) for b in ipv6[12:]])


def uint8_t(n):
    return int(n).to_bytes(1, byteorder='little', signed=False)


def uint16_t(n):
    return int(n).to_bytes(2, byteorder='little', signed=False)


def int32_t(n):
    return int(n).to_bytes(4, byteorder='little', signed=True)


def uint32_t(n):
    return int(n).to_bytes(4, byteorder='little', signed=False)


def int64_t(n):
    return int(n).to_bytes(8, byteorder='little', signed=True)


def uint64_t(n):
    return int(n).to_bytes(8, byteorder='little', signed=False)


def unmarshal_int(b):
    return int.from_bytes(b, byteorder='little', signed=True)


def unmarshal_uint(b):
    return int.from_bytes(b, byteorder='little', signed=False)


def print_message(msg, text=None):
    """
    Report the contents of the given bitcoin message
    :param msg: bitcoin message including header
    :return: message type
    """
    print('\n{}MESSAGE'.format('' if text is None else (text + ' ')))
    print('({}) {}'.format(len(msg), msg[:60].hex() + ('' if len(msg) < 60 else '...')))
    payload = msg[HDR_SZ:]
    command = print_header(msg[:HDR_SZ])
    if command == 'version':
        print_version_msg(payload)
    # FIXME print out the payloads of other types of messages, too
    return command


def print_header(header, expected_cksum=None):
    """
    Report the contents of the given bitcoin message header
    :param header: bitcoin message header (bytes or bytearray)
    :param expected_cksum: the expected checksum for this version message, if known
    :return: message type
    """
    magic, command_hex, payload_size, cksum = header[:4], header[4:16], header[16:20], header[20:]
    command = str(bytearray([b for b in command_hex if b != 0]), encoding='utf-8')
    psz = unmarshal_uint(payload_size)
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


def print_version_msg(b):
    """
    Report the contents of the given bitcoin version message (sans the header)
    :param payload: version message contents
    """
    # pull out fields
    version, my_services, epoch_time, your_services = b[:4], b[4:12], b[12:20], b[20:28]
    rec_host, rec_port, my_services2, my_host, my_port = b[28:44], b[44:46], b[46:54], b[54:70], b[70:72]
    nonce = b[72:80]
    user_agent_size, uasz = unmarshal_compactsize(b[80:])
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
    print('{}{:32} version {}'.format(prefix, version.hex(), unmarshal_int(version)))
    print('{}{:32} my services'.format(prefix, my_services.hex()))
    time_str = time.strftime("%a, %d %b %Y %H:%M:%S GMT", time.gmtime(unmarshal_int(epoch_time)))
    print('{}{:32} epoch time {}'.format(prefix, epoch_time.hex(), time_str))
    print('{}{:32} your services'.format(prefix, your_services.hex()))
    print('{}{:32} your host {}'.format(prefix, rec_host.hex(), ipv6_to_ipv4(rec_host)))
    print('{}{:32} your port {}'.format(prefix, rec_port.hex(), unmarshal_uint(rec_port)))
    print('{}{:32} my services (again)'.format(prefix, my_services2.hex()))
    print('{}{:32} my host {}'.format(prefix, my_host.hex(), ipv6_to_ipv4(my_host)))
    print('{}{:32} my port {}'.format(prefix, my_port.hex(), unmarshal_uint(my_port)))
    print('{}{:32} nonce'.format(prefix, nonce.hex()))
    print('{}{:32} user agent size {}'.format(prefix, user_agent_size.hex(), uasz))
    print('{}{:32} user agent \'{}\''.format(prefix, user_agent.hex(), str(user_agent, encoding='utf-8')))
    print('{}{:32} start height {}'.format(prefix, start_height.hex(), unmarshal_uint(start_height)))
    print('{}{:32} relay {}'.format(prefix, relay.hex(), bytes(relay) != b'\0'))
    if len(extra) > 0:
        print('{}{:32} EXTRA!!'.format(prefix, extra.hex()))


ip = '89.22.110.234'
port = 8333

# ---------------------------------------------PAYLOAD------------------------------------------------------------------
version = int32_t(70015)    # int_32
services = uint64_t(0x00)   # uint64
timestamp = int64_t(time.time())    # int64
addr_recv_service = uint64_t(0x01)  # uint64
addr_recv_IPaddr = ipv6_from_ipv4(ip)   # char[16]
addr_recv_port = uint16_t(port)  # uint16
addr_trans_service = uint64_t(0x00)  # uint64
addr_trans_IPaddr = ipv6_from_ipv4(selfip)  # char[16]
addr_trans_port = uint16_t(selfport)    # uint16
nonce = uint64_t(0) # uint64
user_agent = bytes('', 'utf-8')  # string
user_agent_bytes = compactsize_t(len(user_agent))   # uint
start_height = int32_t(0)   # int32
relay = bool_t(0)   # bool
payload = version + services + timestamp + addr_recv_service + \
          addr_recv_IPaddr + addr_recv_port + addr_trans_service +\
          addr_trans_IPaddr + addr_trans_port + nonce + user_agent +\
          user_agent_bytes + start_height + relay  # uint_32

# ---------------------------------------------------HEADER-------------------------------------------------------------
start_string = bytes.fromhex('f9beb4d9')  # char[4]
command_name = bytes('version', 'utf-8').ljust(12, b'\0')  # char[12]
n = len(payload)
payload_size = uint32_t(n)
hash_of_payload = sha256(sha256(payload).digest()).digest()  # Hash256(256(Payload)) must be in bytes
check_sum = hash_of_payload[:4]  # char[4] extract first 4 bytes and make it check sum
header = start_string + command_name + payload_size + check_sum
# -------------------------------------------MESSAGE--------------------------------------------------------------------
message = header + payload
print_message(message)
sock.connect((ip, port))
sock.sendall(message)
recv_msg = sock.recv(24)
print_header(recv_msg)
payloadsize = unmarshal_uint(recv_msg[16:20])
recv_payload = sock.recv(payloadsize)
print_version_msg(recv_payload)
recv_msg = sock.recv(24)
# ---------------------------------------------------VERACK-------------------------------------------------------------
start_string = bytes.fromhex('f9beb4d9')  # char[4]
command_name = bytes('verack', 'utf-8').ljust(12, b'\0')  # char[12]
vpayload = b''
n = len(vpayload)
payload_size = uint32_t(n)
hash_of_payload = sha256(sha256(vpayload).digest()).digest()  # Hash256(256(Payload)) must be in bytes
check_sum = hash_of_payload[:4]  # char[4] extract first 4 bytes and make it check sum
header = start_string + command_name + payload_size + check_sum
print(f"Sending verack: {header.hex()} size is: {len(header)}")
print_header(header)
sock.sendall(header)
print("Waiting for reply...")
for i in range(5):
    msg4 = sock.recv(24)
    print(f"Msg received is {msg4.hex()} and size is: {len(msg4)}")
    print_message(msg4)

