import datetime
import math
import socket
import fxp_bytes_subscriber
import ipaddress

#Constants
BUFF_SIZE = 1024
class Subscriber:
    def __init__(self):
        self.Publisher_Ip = "127.0.0.1"
        self.Publisher_Port = 50403
        self.Subs_Ip = '127.0.0.1'
        self.Subs_Port = 0
        self.listener, self.listner_address = self.listner(self.Subs_Ip)
        self.graph = {}

    #addNodes method to add nodes to graph
    def addNodes(self, Date_time, From, To, Price):
        if self.graph == {}:
            self.graph[From] = {To: (Date_time, math.log10(Price))}
        elif From not in self.graph:
            self.graph[From] = {To: (Date_time, math.log10(Price))}
        elif From in self.graph:
            if To in self.graph[From]:
                temp_dict = self.graph[From]
                temp_dict[To] = (Date_time, math.log10(Price))
                self.graph[From] = temp_dict
            elif To not in self.graph[From]:
                temp_dict = self.graph[From]
                temp_dict[To] = (Date_time, math.log10(Price))
                self.graph[From] = temp_dict

    # Listner() method is used to get the ip and port of subscribe
    @staticmethod
    def listner(address):
        listener = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        listener.bind((address, 0))
        listener.settimeout(0.2)
        listener.setblocking(False)
        return listener, listener.getsockname()

    # connect_publisher function to connect to publisher
    def connect_publisher(self):
        # using AF_INET used for ipV4 and SOCK_DGRAM is used for sending datagram packets
        subs_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        self.Subs_Port = self.listner_address[1]
        print(f"Ip is : {self.Subs_Ip} and Port is : {self.Subs_Port}")
        Msg_IP_Port = fxp_bytes_subscriber.Ip_Port_serializer(self.Subs_Ip, self.Subs_Port)
        subs_socket.sendto(Msg_IP_Port, (self.Publisher_Ip, self.Publisher_Port))
        time_start = datetime.datetime.utcnow()
        old_message_time = time_start  #set time to check for messages older than this time
        while True:
            Data_from_pub = None
            try:
                Data_from_pub = self.listener.recv(BUFF_SIZE)
            except Exception:
                data = None
            if Data_from_pub is not None and len(Data_from_pub) > 0:  # check weather data is present or not
                Finished_Datas = fxp_bytes_subscriber.unmarshal_message(Data_from_pub)
                for Finished_Data in Finished_Datas:
                    #get all data
                    Date_time = Finished_Data['time']
                    From = Finished_Data['from']
                    To = Finished_Data['to']
                    Price = Finished_Data['price']
                    if Date_time > old_message_time:
                        self.addNodes(Date_time, From, To, Price)
                        print(self.graph)


if __name__ == '__main__':
    subscriber = Subscriber()
    subscriber.connect_publisher()
