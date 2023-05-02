'''
find the working node from node_main.txt
'''
import socket

class findnode:
    '''
    findnode class to find the nodes from node_main.txt and store ip and port of that node 
    '''
    def __init__(self):
        self.ip = None
        self.port = None
        self.extra = None

    def extract_txt(self):
        filename = "nodes_main.txt"
        with open(filename,'r') as txtfile:
            for line in txtfile:
                passingvalue = line.strip()
                self.extract_ip_port_try_connection(passingvalue)

    def extract_ip_port_try_connection(self, line):
        ip_port, self.extra = self.split("#", line)
        print(f"IP Port: {ip_port} and Extra {extra}")
        self.ip, self.port, = self.split(':', ip_port)
        self. find_node()

    def split(self, symbol, line):
        arg1, arg2 = line.split(symbol)
        return arg1, arg2

    def find_node(self):
        host = self.ip
        port = int(self.port)
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
            try:
                sock.connect((host, port))
                sock.sendall()
            except socket.timeout as err:
                response = f"Failed to connect - timeout: {err}"
            message = sock.recv(1024)
            print(message)

#main function
def main():
    node = findnode()
    node.extract_txt()
if __name__ == "__main__":
    main()