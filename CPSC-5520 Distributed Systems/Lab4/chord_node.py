'''
Aim:
    Port number of other nodes as Argument or 0 to make new network 

    this file will create a node in chord and listen for incomming nodes or queries

    use blocking TCP and pickle to martial  messages
'''
import sys
from argparse import ArgumentParser
import threading
from datetime import datetime
import socket
import pickle
from enum import Enum
from hashlib import sha1


#Global Variables
M = 3  # FIXME: Test environment, normally = hashlib.sha1().digest_size * 8
NODES = 2**M
BUF_SZ = 4096  # socket recv arg
BACKLOG = 100  # socket listen arg
TEST_BASE = 43544  # for testing use port numbers on localhost at TEST_BASE+n
HOSTNAME = "localhost"
SOCKET_TIMEOUT = 1


#RPC class for storing types as Enum  
class RPC(Enum):
    FIND_SUCCESSOR = " find_successor"
    FIND_PREDECESSOR = " find_predecessor"
    GET_SUCCESSOR = " get_successor"
    GET_PREDECESSOR = " get_successor"
    SET_PREDECESSOR = " set_predecessor"
    UPDATE_FINGER_TABLE = "update_finger_table"
    CLOSEST_PRECEDING_FINGER = "closest_preceding_finger"
    ADD_KEY = "add_key"
    RESOLVE_QUERY = "resolve_query"

class Chord_Utils(object):

    

    #start socket and return socket and address
    def start(n):
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        address = (HOSTNAME, TEST_BASE + n)
        sock.bind(address)
        sock.listen(BACKLOG)
        return sock, address

    #Hash function to hash any thing 
    def hash(data_to_hash):
        data_to_hash_string = str(data_to_hash)
        data_to_hash_bytes = data_to_hash_string.encode()
        hashed_data = sha1(data_to_hash_bytes)
        hex_of_data = hashed_data.hexdigest()
        hashed_data_int = int(hex_of_data, 16) % NODES
        return hashed_data_int

    # lookup_node function to return ip and poert of a node
    @staticmethod
    def lookup_node(node):
        return HOSTNAME, TEST_BASE + node

    #print_Log is used for printing message at current time
    @staticmethod
    def print_Log(message):
        print(f"[{Chord_Utils.get_CurrentTime()}]: {message}") 
    
    #get_CurrentTime is used to return current time
    @staticmethod
    def get_CurrentTime():
        return datetime.now().strftime("%I:%M:%S:%f")

    @staticmethod
    def revc_message(sock, buff_size = BUF_SZ):
        return pickle.loads(sock.recv(buff_size))

class ModRange(object):
    """
    Range-like object that wraps around 0 at some divisor using modulo arithmetic.

    >>> mr = ModRange(1, 4, 100)
    >>> mr
    <mrange [1,4)%100>
    >>> 1 in mr and 2 in mr and 4 not in mr
    True
    >>> [i for i in mr]
    [1, 2, 3]
    >>> mr = ModRange(97, 2, 100)
    >>> 0 in mr and 99 in mr and 2 not in mr and 97 in mr
    True
    >>> [i for i in mr]
    [97, 98, 99, 0, 1]
    >>> [i for i in ModRange(0, 0, 5)]
    [0, 1, 2, 3, 4]
    """

    def __init__(self, start, stop, divisor):
        self.divisor = divisor
        self.start = start % self.divisor
        self.stop = stop % self.divisor
        # we want to use ranges to make things speedy, but if it wraps around the 0 node, we have to use two
        if self.start < self.stop:
            self.intervals = (range(self.start, self.stop),)
        elif self.stop == 0:
            self.intervals = (range(self.start, self.divisor),)
        else:
            self.intervals = (range(self.start, self.divisor), range(0, self.stop))

    def __repr__(self):
        """ Something like the interval|node charts in the paper """
        return ''.format(self.start, self.stop, self.divisor)

    def __contains__(self, id):
        """ Is the given id within this finger's interval? """
        for interval in self.intervals:
            if id in interval:
                return True
        return False

    def __len__(self):
        total = 0
        for interval in self.intervals:
            total += len(interval)
        return total

    def __iter__(self):
        return ModRangeIter(self, 0, -1)


class ModRangeIter(object):
    """ Iterator class for ModRange """
    def __init__(self, mr, i, j):
        self.mr, self.i, self.j = mr, i, j

    def __iter__(self):
        return ModRangeIter(self.mr, self.i, self.j)

    def __next__(self):
        if self.j == len(self.mr.intervals[self.i]) - 1:
            if self.i == len(self.mr.intervals) - 1:
                raise StopIteration()
            else:
                self.i += 1
                self.j = 0
        else:
            self.j += 1
        return self.mr.intervals[self.i][self.j]


class FingerEntry(object):
    """
    Row in a finger table.

    >>> fe = FingerEntry(0, 1)
    >>> fe
    
    >>> fe.node = 1
    >>> fe
    
    >>> 1 in fe, 2 in fe
    (True, False)
    >>> FingerEntry(0, 2, 3), FingerEntry(0, 3, 0)
    (, )
    >>> FingerEntry(3, 1, 0), FingerEntry(3, 2, 0), FingerEntry(3, 3, 0)
    (, , )
    >>> fe = FingerEntry(3, 3, 0)
    >>> 7 in fe and 0 in fe and 2 in fe and 3 not in fe
    True
    """
    def __init__(self, n, k, node=None):
        if not (0 <= n < NODES and 0 < k <= M):
            raise ValueError(' || invalid finger entry values')
        self.start = (n + 2**(k-1)) % NODES
        self.next_start = (n + 2**k) % NODES if k < M else n
        self.interval = ModRange(self.start, self.next_start, NODES)
        self.node = node

    def __repr__(self):
        """ Something like the interval|node charts in the paper """
        return ''.format(self.start, self.next_start, self.node)

    def __contains__(self, id):
        """ Is the given id within this finger's interval? """
        return id in self.interval


#Class ChordNode is representing a node in chord alias -> Node
class ChordNode(object):
    def __init__(self, n):
        self.node = n
        self.finger = [None] + [FingerEntry(n, k) for k in range(1, M+1)]  # indexing starts at 1
        self.predecessor = None
        self.successor = None
        self.keys = {}
        self.server, self.address = Chord_Utils.start(self.node)

    @property
    def successor(self):
        return self.finger[1].node

    @successor.setter
    def successor(self, id):
        self.finger[1].node = id

    #Run to runs the chord node
    def Run(self, existing_Node):

        '''
        * * * * * Creating Thread * * * * * 
        thread-start network 
        used for joining the network on a different thread using a existing node 
        '''
        threading.Thread(target=self.Join, args=(existing_Node)).start() 
        self.Listen_RPC()

    #Listen for rpc and handel it with a new thread 
    def Listen_RPC(self):
        Chord_Utils.print_Log(f" || Listening at Address: {self.address}")
        #try except for user keyboard interuption
        try:
            while True:
                client_sock, Client_Address = self.server.accept()   #Accept the socket request stored in server variable 
                '''
                * * * * * Creating Thread * * * * * 
                thread-handeling RPC 
                used for handeling rpc calls   
                '''
                threading.Thread(target=self.Handel_RPC, args=(client_sock)).start()
        except KeyboardInterrupt as  e:
            Chord_Utils.print_Log(f" || Keyboard Interupted: Exiting !!! {e} ") 

    #Join start the chord network
    def Join(self, existing_Node = None):
        if existing_Node  is not None:
            Chord_Utils.print_Log(" || Joining. ")
            self.construct_finger_table(existing_Node)
            self.update_other_nodes() 
        else:
            Chord_Utils.print_Log(" || Creating. ")
            for i in range(1, M+1):
                self.finger[i].node = self.node
            self.predecessor= self.node
        Chord_Utils.print_Log(f" * * * * * Node Value * * * * * \n{self}")

    #RPC_call function send message to other node using rpc
    def RPC_call(self, existing_Node, method, argument_1 = None, argument_2 = None):
        Chord_Utils.print_Log(f" || Calling {method} on Node {existing_Node}")
        if existing_Node == self.node:
            return self.find_RPC(method, argument_1, argument_2)
        # try catch for timeout in socket 
        try: 
            with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
                sock.settimeout(SOCKET_TIMEOUT)
                sock.connect(Chord_Utils.lookup_node(existing_Node)) 
                sock.sendall(pickle.dumps((method, argument_1, argument_2)))
                return Chord_Utils.recv_message(sock)
        except socket.timeout as err:
            Chord_Utils.print_Log(f" || Socket Timeout for Node :{existing_Node} -- Error: {err}")

    #construct_finger_table function to construct finger table 
    def construct_finger_table(self, existing_Node):
        Chord_Utils.print_Log(" || Constructing Finger table. ")
        self.finger[1].node = self.RPC_call(existing_Node, RPC.FIND_PREDECESSOR.value, self.finger[1].start) 
        self.predecessor = self.RPC_call(self.successor, RPC.GET_PREDECESSOR.value)
        self.RPC_call(self.successor, RPC.SET_PREDECESSOR, self.node)
        for i in range(1, M):
            if self.finger[i+1].start in ModRange(self.node, self.finger[i].node, NODES):
                self.finger[i+1].node = self.finger[i].node
            else:
                self.finger[i+1].node = self.RPC_call(existing_Node, RPC.FIND_SUCCESSOR.value, self.finger[i+1].start)
    
    #update_other_nodes function to update other nodes in the chord system
    def update_other_nodes(self):
        Chord_Utils.print_Log(" || Update Other Nodes. ")
        for i in range(1, M+1):
            temp_predecessor = self.find_predecessor((1 + self.node - 2**(i-1) + NODES) % NODES) #Pending !!!!!
            self.RPC_call(temp_predecessor, RPC.UPDATE_FINGER_TABLE.value, self.node, i)

    def Handel_RPC(self, client_sock):
        RPC_Message = client_sock.recv(BUF_SZ)
        method, key, value = pickle.loads(RPC_Message)
        return_Result = self.find_RPC(method, key, value)
        client_sock.sendall(pickle.dumps(return_Result))

    def find_RPC(self, method, argument_1, argument_2):
        # check which function to return on the basis of Enum value check Enum class 
        if method == RPC.ADD_KEY.value: #add key RPC
            return self.add_key(argument_1, argument_2) 
        elif method == RPC.FIND_SUCCESSOR.value:    #find successor RPC
            return self.find_successor(argument_1)
        elif method == RPC.FIND_PREDECESSOR.value:  #find predecessor RPC
            return self.find_predecessor(argument_1)
        elif method == RPC.GET_SUCCESSOR.value: #get successor rpc
            return self.get_Successor()
        elif method == RPC.GET_PREDECESSOR.value:   #get predecessor rpc
            return self.get_Predecessor()
        elif method == RPC.SET_PREDECESSOR.value:   #set predecessor rpc
            return self.set_Predecessor(argument_1)
        elif method == RPC.UPDATE_FINGER_TABLE.value:   #update finget tabel rpc
            return self.update_finger_table(argument_1, argument_2)
        elif method == RPC.CLOSEST_PRECEDING_FINGER.value:  #cosest preceding finger rpc
            return self.closest_preceding_finger(argument_1)
        elif method == RPC.RESOLVE_QUERY.value: #resolve query rpc 
            return self.resolve_query(argument_1)   #Pending!!!!!!!!!!!!!!!!!!!!!!1
        else:
            return " || UNKNOWN RPC"

    #add_key function to add keys in chord
    def add_key(self, key, value):
        hash_key = Chord_Utils.hash(key) 
        successor = self.find_successor(hash_key)
        if successor == self.node:
            self.keys[key] = value
            return f" || Key {key} is added to node {successor}"
        else:
            return self.RPC_call(successor, RPC.ADD_KEY.value, key, value)

    # find_successor function to find successor of given if       
    def find_successor(self, id):
        node_port = self.find_predecessor(id)
        return self.RPC_call(node_port, RPC.GET_SUCCESSOR.value)

    # find_predecessor function to find the predecessor of given id
    def find_predecessor(self, id):
        node_port = self.node
        while id not in ModRange((node_port + 1) % NODES, (self.RPC_call(node_port, RPC.GET_SUCCESSOR.value) +1) % NODES, NODES):
            node_port = self.RPC_call(node_port, RPC.CLOSEST_PRECEDING_FINGER.value, id)
        return node_port
    
    #get Successor
    def get_Successor(self):
        return self.successor
    
    #get Predecessor
    def get_Predecessor(self):
        return self.predecessor

    #set predecessor of current node
    def set_Predecessor(self, predecessor):
        self.predecessor = predecessor 

    #update_finger_table
    def update_finger_table(self, s, i):
        if (self.finger[i].start != self.finger[i].node and s in ModRange(self.finger[i].start, self.finger[i].node, NODES)):
            Chord_Utils.print_Log(f"Update Finger Table ({s},{i}): {self.node}[{i}] = {s} since {s} in [{self.finger[i].start}, {self.finger[i].node}]")
            self.finger[i].node = s
            temp_predecessor = self.predecessor
            Chord_Utils.print_Log(f" * * * * * Node Value * * * * * \n{self}")
            self.RPC_call(temp_predecessor, RPC.UPDATE_FINGER_TABLE.value, s, i)
            return str(self)
        else:
            return Chord_Utils.print_Log(" || NO Update")

    #get closest finget entry of predcessor id 
    def closest_preceding_finger(self, id):
        for i in range(M, 0, -1):
            if self.finger[i].node in ModRange((self.node + 1) % NODES, id, NODES):
                return self.finger[i].node
        return self.node 

    # resolve_query function used for resolving query made by user
    def resolve_query(self, key):
        hashed_key  = Chord_Utils.hash(key)
        temp_successor = self.find_successor(hashed_key)
        if temp_successor == self.node:
            if key not in self.keys:
                Chord_Utils.print_Log(" || Key: {key} not found.")
                return f"key {key} dose not exist"
            Chord_Utils.print_Log(" || Key Found in Node {self.node}")
            return self.keys[key]
        else:
            return self.RPC_call(temp_successor, RPC.RESOLVE_QUERY.value, key)

    def print_finger(self):
        return '\n'.join([f"{entry}: {self.finger[entry]}" for entry in range(1, M+1)])

    def __repr__(self):
        return f"node: {self.node} \n Predecessor: {self.predecessor} \n Total Keys: {len(self.keys)} \n finger table: \n {self.print_finger()}"

def Parse_Args():
    arg_pass = ArgumentParser()
    arg_pass.add_argument('node', type = int, help = "Enter the Node Id of Chord Node:")
    arg_pass.add_argument('--existing-node', type = int, help = "Enter the Node Id of Existing Chord Node:")
    arguments = arg_pass.parse_args()
    return arguments.node, arguments.existing_node

def main():
    node, existing_Node = Parse_Args()
    Chr_node = ChordNode(node)
    Chr_node.Run(existing_Node)

if __name__ == "__main__":
    main()