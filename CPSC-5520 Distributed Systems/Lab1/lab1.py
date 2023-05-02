"""
CPSC 5520, Seattle University
This is free and unencumbered software released into the public domain.
:Authors: Kapish Patel
"""
import pickle
import socket
import sys


class Lab1(object):
    """
    Class to perform the specified behavior for Lab 1.
    """

    def __init__(self, gcd_host, gcd_port):
        """
        Constructs a Lab1 object to talk to the given Group Coordinator Daemon.

        :param gcd_host: host name of GCD
        :param gcd_port: port number of GCD
        """
        self.host = gcd_host
        self.port = int(gcd_port)
        self.members = []
        self.peer_timeout = 1.5  # seconds

    def join_group(self):
        """
        Does what is specified for Lab 1.
        Also verbosely prints out what it is doing.
        """
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as gcd:
            address = (self.host, self.port)
            print('JOIN {}'.format(address))
            gcd.connect(address)
            self.members = self.message(gcd, 'JOIN')
            self.meet_members()

    def meet_members(self):
        """
        Sends a HELLO to all the group members.
        Also verbosely prints out what it is doing.
        """
        for member in self.members:
            print('HELLO to {}'.format(member))
            with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as peer:
                peer.settimeout(self.peer_timeout)
                try:
                    peer.connect((member['host'], member['port']))
                except Exception as err:
                    print('failed to connect: {}', err)
                else:
                    message = self.message(peer, 'HELLO')
                    print(message)

    @staticmethod
    def message(sock, send_data, buffer_size=1024):
        """
        Pickles and sends the given message to the given socket and unpickles the returned value and returns it.

        :param sock: socket to message/recv
        :param send_data: message data (anything pickle-able)
        :param buffer_size: number of bytes in receive buffer
        :return: message response (unpickled--pickled data must fit in buffer_size bytes)
        """
        sock.sendall(pickle.dumps(send_data))
        return pickle.loads(sock.recv(buffer_size))


if __name__ == '__main__':
    if len(sys.argv) != 3:
        print("Usage: python lab1.py GCDHOST GCDPORT")
        exit(1)
    host, port = sys.argv[1:]
    lab1 = Lab1(host, port)
    lab1.join_group()
