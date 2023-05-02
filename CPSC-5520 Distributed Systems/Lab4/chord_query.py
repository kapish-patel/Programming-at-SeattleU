'''
Aim:
    Port number of any existing node  and key(value of column 1+4 fromm the data file) 

    basically a key to search in chord
'''

import socket 
import pickle
from argparse import ArgumentParser

BUF_SZ = 4096  # socket recv arg
TEST_BASE = 43544  # for testing use port numbers on localhost at TEST_BASE+n
HOSTNAME = "localhost"
SOCKET_TIMEOUT = 1
METHOD = "resolve_query"

class Chord_query(object):
    def __init__(self, address):
        self.node_address = address

    def Query(self, key):
        return self.RPC_call(self.node_address, METHOD, key)
    
    @staticmethod
    def RPC_call(node_address, method, argument_1 = None, argument_2 = None):
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
            sock.connect(node_address)
            sock.sendall(pickle.dumps(method, argument_1, argument_2))
            return pickle.loads(sock.recv(BUF_SZ))


def pass_args():
  arg_parser = ArgumentParser()
  arg_parser.add_argument('node', type=int, help='The node id of an existing Chord node')
  arg_parser.add_argument('key', type=str, help='The key of a data item')
  args = arg_parser.pass_args()
  return args.node, args.key

def main():
    port, key = pass_args()
    query = Chord_query((HOSTNAME, TEST_BASE + port))
    print(query.Query(key))
if __name__ == "__main__":
    main()