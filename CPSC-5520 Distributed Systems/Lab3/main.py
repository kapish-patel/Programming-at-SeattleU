import socket
import math
import fxp_bytes_subscriber
from datetime import datetime, timedelta

bufferSize = 1024
BACKLOG = 100


def start_a_server():
    listener = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    listener.bind(("localhost", 0))  # use any free socket
    listener.settimeout(0.2)    # 200ms for timeout
    return listener, listener.getsockname()


class Lab3(object):
    def __init__(self, publisher_addr):
        self.graph = {}
        self.server_addr = publisher_addr
        self.listener, self.listener_address = start_a_server()

    def run(self):
        print('starting on {} port {}'.format(self.listener_address[0], self.listener_address[1]))
        with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as msg_sender:
            msg = fxp_bytes_subscriber.serialize_address(self.listener_address[0], self.listener_address[1])
            msg_sender.sendto(msg, self.server_addr)

        last_packet_time = None
        start_time = datetime.utcnow()
        off_time = start_time + timedelta(microseconds=600000000)

        while off_time >= datetime.utcnow():
            data = None
            try:
                data = self.listener.recv(bufferSize)
            except Exception:
                data = None

            if data is not None and len(data) > 0:
                currency_exchange_list = fxp_bytes_subscriber.unmarshal_message(data)
                for each_currency_exchange in currency_exchange_list:
                    if each_currency_exchange["from"] in self.graph:    # check v1 is present in graph list
                        if each_currency_exchange["to"] in self.graph[each_currency_exchange["from"]]:  # check v2 is present for v1 in graph or not
                            last_packet_time = self.graph[each_currency_exchange["from"]][each_currency_exchange["to"]]["time"]
                            if last_packet_time <= each_currency_exchange["time"]:  # check and update time and exchange rate for v1 --> v2
                                self.graph[each_currency_exchange["from"]][each_currency_exchange["to"]] = {"price": math.log10(each_currency_exchange["price"]), "time": each_currency_exchange["time"]}
                                # last_packet_time = each_currency_exchange["time"]
                                print(each_currency_exchange["time"], each_currency_exchange["from"], each_currency_exchange["to"], each_currency_exchange["price"])
                            else:
                                print("ignoring out-of-sequence message")
                        else:   # vertex v1 is present but edge b/w v1 and v2 is not present. so add it.
                            self.graph[each_currency_exchange["from"]] = {each_currency_exchange["to"]: {"price": math.log10(each_currency_exchange["price"]), "time": each_currency_exchange["time"]}}
                            print(each_currency_exchange["time"], each_currency_exchange["from"], each_currency_exchange["to"], each_currency_exchange["price"])
                    else:   # no v1 in present in graph hence add v1, v2 and edge in graph
                        self.graph[each_currency_exchange["from"]] = {each_currency_exchange["to"]: {"price": math.log10(each_currency_exchange["price"]), "time": each_currency_exchange["time"]}}
                        last_packet_time = each_currency_exchange["time"]
                        print(each_currency_exchange["time"], each_currency_exchange["from"], each_currency_exchange["to"], each_currency_exchange["price"])
                # print(self.graph)


if __name__ == '__main__':
    publisherAddressPort = ("127.0.0.1", 50403)
    lab3 = Lab3(publisherAddressPort)
    lab3.run()
