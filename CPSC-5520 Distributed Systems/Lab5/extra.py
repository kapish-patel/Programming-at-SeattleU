import time
from hashlib import sha256
import codecs

def uint64_t(n):
    return int(n).to_bytes(8, byteorder='little', signed=False)


def int64_t(n):
    return int(n).to_bytes(8, byteorder='little', signed=True)


def int32_t(n):
    return int(n).to_bytes(4, byteorder='little', signed=True)


'''
#services = uint64_t(0x00) #uint64
#timestamp = int64_t(time.time()) #int64
#user_agent = bytes('','utf-8') #string
#print(user_agent)
'''

'''
version = int32_t(70015)    # int_32
print(version)
hassh = sha256(sha256(version).digest()).digest()
print(hash[:4].hex())
'''
"""start_string = 'f9beb4d9'  # char[4]
print(len(bytes.fromhex(start_string)))"""


"""command_name = bytes('version', 'utf-8').ljust(12, b'\0')
print(command_name.hex())
print(len(command_name))"""

'''
#print(207489 % 10000)
a = b'\xfd\xf4\x01'
ahex = a.hex()
print(ahex)
#command = str(bytearray([b for b in ahex if b != 0]), encoding='utf-8')
command = bytes.fromhex(ahex)
print(command)

#a = '56000000'
'''

a = b'\x02\x00\x00\x00H`\xeb\x18\xbf\x1b\x16 \xe3~\x94\x90\xfc\x8aBu\x14Ao\xd7QY\xab\x86h\x8e\x9a\x83'
print(len(a))
ahex = a.hex()
print(ahex)
print(len(ahex))

#020000004860eb18bf1b1620e37e9490fc8a427514416fd75159ab86688e9a83
#000000000019d6689c085ae165831e934ff763ae46a2a6c172b3f1b60a8ce26f

00000000020000005714bd772bcbdb97a08d32cc82469cadbf7feb69bb4131a993bc7c7f