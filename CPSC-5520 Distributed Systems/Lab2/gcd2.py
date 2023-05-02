"""
CPSC 5520, Seattle University
This is free and unencumbered software released into the public domain.
:Authors: Kevin Lundeen
:Version: f19-02
"""
import pickle
import socket
import socketserver
import sys

BUF_SZ = 1024  # tcp receive buffer size


class GroupCoordinatorDaemon(socketserver.BaseRequestHandler):
    """
    A Group Coordinator Daemon (GCD) which will respond with a list of potential group members to a text message JOIN
    with list of group members to contact.

    We respond with a dictionary of group members.
    """

    # global group data structures
    listeners_by_pid = {}  # listener address indexed by process id (as returned from JOIN message)
    pids_by_listener = {}  # process ids indexed by listener address (only one pid for each unique (host, port))
    pids_by_student = {}  # process ids indexed by student id (each student only allowed one at a time)

    # we want to restrict all listeners to be on the same host as the GCD
    localhost_ip = socket.gethostbyname('localhost')

    def handle(self):
        """
        Handles the incoming messages - expects only 'JOIN' messages
        """
        #print(self.request.getsockname())
        raw = self.request.recv(BUF_SZ)  # self.request is the TCP socket connected to the client
        try:
            message = pickle.loads(raw)
        except Exception:
            response = bytes('Expected a pickled message, got ' + str(raw)[:100] + '\n', 'utf-8')
        else:
            try:
                response_data = self.handle_join(message)
            except ValueError as err:
                response_data = str(err)
            response = pickle.dumps(response_data)
        self.request.sendall(response)
        self.request.shutdown(socket.SHUT_RDWR)
        self.request.close()

    @staticmethod
    def handle_join(message):
        """
        Process this JOIN message by adding new member into the group data structures.
        Also do some validation:
        - of the right form
        - listener is on localhost (or equivalent)

        :param message: ('JOIN', ((days_to_bd, su_id), (host, port)))
        :return: GroupCoordinatorDaemon.listeners_by_pid
        :raises ValueError: if the message cannot be validated
        """
        try:
            # pull apart message
            message_name, message_data = message
        except (ValueError, TypeError):
            raise ValueError('Malformed message')

        if message_name != 'JOIN':
            raise ValueError('Unexpected message: {}'.format(message_name))

        # pull apart message_data
        try:
            process_id, listener = message_data
            listen_host, listen_port = listener
            days_to_birthday, student_id = process_id
        except (ValueError, TypeError):
            raise ValueError('Malformed message data, expected ((days_to_bd, su_id), (host, port))')
        if not (type(days_to_birthday) is int and type(student_id) is int and
                0 < days_to_birthday < 366 and 1_000_000 <= student_id < 10_000_000):
            raise ValueError('Malformed process id, expected (days_to_next_birthday, student_id)')

        # make sure that listen_host is localhost or equivalent
        try:
            listen_ip = socket.gethostbyname(listen_host)
        except Exception as err:
            raise ValueError(str(err))
        if not (type(listen_port) is int and 0 < listen_port < 65_536):
            raise ValueError('Invalid port number')
        if listen_ip != GroupCoordinatorDaemon.localhost_ip:
            raise ValueError('Only local group members currently allowed')
        listener = (listen_ip, listen_port)

        # aliases for global dictionaries
        students = GroupCoordinatorDaemon.pids_by_student
        group = GroupCoordinatorDaemon.listeners_by_pid
        listeners = GroupCoordinatorDaemon.pids_by_listener

        # remove any old memberships for the same student
        if student_id in students and students[student_id] != process_id:
            old_pid = students[student_id]
            del group[old_pid]
        students[student_id] = process_id

        # add this entry into group membership
        group[process_id] = listener

        # also remove any old memberships which claimed this same listener (host, port) pair
        if listener in listeners and listeners[listener] != process_id:
            old_pid = listeners[listener]
            if old_pid in group:
                del group[old_pid]
        listeners[listener] = process_id

        return group


if __name__ == '__main__':
    if len(sys.argv) != 2:
        print("Usage: python gcd2.py GCDPORT")
        exit(1)
    port = int(sys.argv[1])
    with socketserver.TCPServer(('', port), GroupCoordinatorDaemon) as server:
        server.serve_forever()
