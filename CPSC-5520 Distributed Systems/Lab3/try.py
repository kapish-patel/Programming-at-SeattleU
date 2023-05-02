import socket
from array import array
import ipaddress

import fxp_bytes_subscriber as utils

def listner(address):
    print(address)
    listener = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    listener.bind(address)
    return listener


ip = socket.gethostbyname('Localhost')
print(f"IP from gethostbyname method: {ip}")
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
listner_sock = listner((ip, 0))
address = listner_sock.getsockname()
print(f"Ip and Port from Listener:{address}")
ip, port = address
'''ser_Ip_Port = utils.Ip_Port_serializer(ip, port)
print(ser_Ip_Port)'''
ipaddres = ipaddress.ip_address(ip)
ipaddres = int(ipaddres)
print(f"convert string IP: {ip} to Int IP: {ipaddres}")
a = array('l', [ipaddres])  # array of 8-byte floating-point numbers
a.byteswap()
a = a.tobytes()
print("Serialized IP: ", a)
dsip = ipaddress.ip_address(a)
print("DeSerialized IP: ", dsip)


