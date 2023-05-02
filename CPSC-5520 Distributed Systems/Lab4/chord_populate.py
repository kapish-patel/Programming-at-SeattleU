'''
Aim:
    Send data to a specific node in chord and populate it over there
'''

import csv as csv
import sys
import socket
import pickle

ADDKEY = "add_key"

#class populate populates data into chord from a csv file
class populate_Data:
    def __init__(self,port, filename):
        self.Port = int(port)
        self.Ip = '127.0.0.1'
        self.dict = self.set_Dictionary(filename)

    #setall the data into dictionary and return that dictionary
    @staticmethod
    def set_Dictionary(filename):
        dict = {}
        with open(filename,'r') as Csv_file:
            Csv_Data = csv.reader(Csv_file)
            for Row in Csv_Data:
                dictkey = str(Row[0]+Row[3])
                dict[dictkey] = Row
        return dict

    #call populate function to populate data into chord 
    def Populate(self):
        for i, (key, value) in enumerate(self.dict.items()):
            self.send_Data(key, value)

    #send data over a tcp tunnel to given port
    def send_Data(self, key, value):
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
            sock.connect((self.Ip, self.Port))
            sock.sendall(pickle.dumps((ADDKEY, key, value)))

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print('Usage: python server.py PORT FILENAME')
        exit(1)
    port = sys.argv[1]
    filename = str(sys.argv[2])
    a = populate_Data(port, filename)
    a.Populate()
    
