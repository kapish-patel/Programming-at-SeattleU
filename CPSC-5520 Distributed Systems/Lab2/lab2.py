''' 
Todo: make a python script to perform bully algorithm
Author: Kapish Patel
Details given:
    Have an identity which is the pair: (days until your next birthday, your SU ID)
    JOIN the group by talking to the GCD.
    Participate in elections.
    Notice when the current leader has failed and initiate an election. (Extra Credit)
    Pretend to fail every once in a while and then subsequently recover. (Extra Credit)
'''
# required python libraries
from datetime import datetime
from enum import Enum
import pickle
import sys
import socket
import selectors


CHECK_INTERVAL = 120
BUFF_SIZE = 1024
class State(Enum):
    #erase memory of peer
    QUIESCENT = "QUIESCENT"
    #outgoing messages
    SEND_ELECTION = "ELECTION"
    SEND_VICTORY = "COORDINATOR"
    SEND_OK = "OK"
    # incomming messages
    WAITING_FOR_OK = "WAIT_OK"
    WAITING_FOR_VICTORY = "WHO IS THE WINNER ?"
    WAITING_FOR_ANY_MESSAGE = "WAITING"

    def is_incoming(self):
        return self not in (State.SEND_ELECTION, State.SEND_VICTORY, State.SEND_OK)
    
class connectgcd:

    def __init__(self, args_Host, args_Port, arg_Bdate, arg_Suid):
        self.gcd_Host = args_Host
        self.gcd_Port = int(args_Port)
        self.nextB_dayin = int((arg_Bdate - datetime.now()).days)
        self.su_Id = arg_Suid
        self.Process_Id = (self.nextB_dayin, self.su_Id)
        self.grp_Members = {}
        self.member_State = {}
        self.current_Bully = None
        self.selector = selectors.DefaultSelector()
        self.listner, self.listener_Address = self.start_server(self)
        print(self.listner, self.listener_Address)

    def accept_peer(self):
        try:
            print("in accept peer")
            peer, addr = self.listner.accept()
            print(f"{self.pr_sock(peer)} accepted {self.pr_now()}")
            self.set_State(State.WAITING_FOR_ANY_MESSAGE, peer)
        except Exception as err:
            print("Accept failed:", err)
    '''
    def receive_Msg(self, peer):
        pass'''
        
    def send_Msg(self, peer): #to be completed
        state = self.get_State(peer)
        print(f"{self.pr_sock(peer)}: Sending : {state.value} {self.pr_now()}")
        try:
            self.send(peer, state.value, self.grp_Members) #need to make self function used for send socket to used
        except ConnectionError as err:
            pass
        except Exception as err:
            pass
        if state == State.SEND_ELECTION:
            self.set_State(State.WAITING_FOR_OK, peer, switch_mode = True)
        else:
            self.set_quiescent(peer)
    
    '''def check_Timeouts(self):
        pass'''

    def get_State(self, peer = None, detail = False): #to be completed
        if peer is None:
            peer = self
        status = self.member_State[peer] if peer in self.member_State else (State.QUIESCENT, None)
        
        return status if detail else status[0]

    def set_State(self, state, peer = None, switch_mode = False):
        if peer == None:
            peer = self
        self.member_State[peer] = state
        pass
    
    def check_Timeouts(self):
        self.run()

    def run(self):
        while True:
                print("before interval")
                events = self.selector.select(CHECK_INTERVAL)
                print("After select interval")
                print(events)
                for key, mask in events:
                    if key.fileobj == self.listner:
                        self.accept_peer()
                    elif mask & selectors.EVENT_READ:
                        self.receive_Msg(key.fileobj)
                    else:
                        self.send_Msg(key.fileobj)
                self.check_Timeouts() # runs election when there is o one is grp
    
    def start_Election(self, reason):
        if reason == 'first node':
            print("First node")
            self.set_State(State.SEND_VICTORY.value, self.listener_Address)
            self.current_Bully = self.listener_Address
            print(self.pr_leader())
        elif reason == 'new node':
            sortdict = sorted(self.grp_Members, reverse=True)
            print(f"Sorted list: {sortdict}")
            for i in sortdict:
                if i > self.Process_Id:
                    print(i)
                    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
                    print(f"Sending ELECTION to : {i} from {self.Process_Id}")
                    self.selector.register(sock, selectors.EVENT_WRITE, self.send_Msg)
            
                




            

    def conn_gcd(self):
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock_conn:
            sock_conn.connect((self.gcd_Host, self.gcd_Port))
            print("JOIN", self.gcd_Host, self.gcd_Port)
            sock_conn.sendall(pickle.dumps(("JOIN", ((self.nextB_dayin, self.su_Id), (self.listener_Address)))))
            raw_data = sock_conn.recv(1024)
            finished_data = pickle.loads(raw_data)
            print("Data from GCD", finished_data)
            self.grp_Members = finished_data
            print(self.grp_Members)
            if len(self.grp_Members) == 1:
                print("In first node")
                self.start_Election('first node')
            else:
                self.start_Election('new node')
            self.run()
            

    @staticmethod
    def start_server(self):
        localhost_ip = socket.gethostbyname('localhost')
        listner_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        listner_socket.bind((localhost_ip, 0))
        address = listner_socket.getsockname()
        listner_socket.listen(6)
        listner_socket.setblocking(False)
        print(address)
        self.selector.register(listner_socket, selectors.EVENT_READ, self.accept_peer)
        return listner_socket, address

    @staticmethod
    def pr_now():
        return datetime.now().strftime('%H:%M%S.%f')

    @staticmethod
    def pr_sock(self, sock):
        if sock is None or sock == self or sock == self.listner:
            return 'self'
        return self.cpr_sock(sock)

    @staticmethod
    def cpr_sock(sock):
        l_port = sock.getsockname()[1]
        try:
            r_port = sock.getpeername()[1]
        except OSError:
            r_port = "???"
        return f"{l_port} -> {r_port} ({id(sock)})"

    @classmethod
    def send(cls, peer, message_name, message_data = None, wait_for_reply=False, buffer_size = BUFF_SIZE):
        pass #to be completed
    
    @staticmethod
    def receive(peer, buffer_size = BUFF_SIZE):
        pass #to be completed

    def pr_leader(self):
        return "Unknown" if self.current_Bully is None else ('self' if self.current_Bully == self.Process_Id else self.current_Bully)


if __name__ == "__main__":
    if len(sys.argv) != 5:
        print('Usage: python server.py Host Port DateofBirth(mm/dd/yyyy) Suid')
        exit(1)
    client1 = connectgcd(str(sys.argv[1]), int(sys.argv[2]), datetime.strptime(sys.argv[3], '%m/%d/%Y'),
                         int(sys.argv[4]))
    client1.conn_gcd()
