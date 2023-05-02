"""
Forex Provider
(c) all rights reserved

This module implements a staging version the Forex Provider price feed on localhost.
"""
import socket
import selectors
from datetime import datetime, timedelta
import time
import random
import fxp_bytes


REQUEST_ADDRESS = ('localhost', 50403)
REQUEST_SIZE = 12
REVERSE_QUOTED = {'GBP', 'EUR', 'AUD'}
SUBSCRIPTION_TIME = 19#10 * 60  # seconds


class TestPublisher(object):
    """
    Publishes occasional messages
    Updated to ensure 4-way cycle markets are always in same order 
      e.g.  always CAD/EUR, not sometimes EUR/CAD
    """
    def __init__(self):
        self.subscriptions = {}
        self.socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        self.reference = {'GBP': 1.25, 'JPY': 100.0, 'EUR': 1.10, 'CHF': 1.00, 'AUD': 0.75}

    def register_subscription(self, subscriber):
        print('registering subscription for {}'.format(subscriber))
        self.subscriptions[subscriber] = datetime.utcnow()

    @staticmethod
    # ensure market names always in correct order, alpha sort e.g. CAD/EUR
    def format_market_order(curr_a, curr_b):
        if (curr_a > curr_b):
            curr_first = curr_b
            curr_second = curr_a
        else:
            curr_first = curr_a
            curr_second = curr_b
        return "{}/{}".format(curr_first, curr_second)

    def publish(self):
        # remove expired subscriptions
        ts = datetime.utcnow()
        for subscriber in set(self.subscriptions):
            if (ts - self.subscriptions[subscriber]).total_seconds() >= SUBSCRIPTION_TIME:
                print('{} subscription expired'.format(subscriber))
                del self.subscriptions[subscriber]
        if len(self.subscriptions) == 0:
            print('no subscriptions')
            return 1000.0  # nothing to do until we get a subscription, so we can wait a long time

        # random walk the prices
        quotes = []
        for ccy in self.reference:
            self.reference[ccy] *= max(0.9, random.gauss(1.0, 0.0001))
            self.reference[ccy] = round(self.reference[ccy], 5)
            if ccy in REVERSE_QUOTED:
                quote = {'cross': ccy + '/USD'}
            else:
                quote = {'cross': 'USD/' + ccy}
            quote['price'] = self.reference[ccy]
            quotes.append(quote)

        # occasionally put in some older timestamps to simulate out-of-order UDP messages
        if random.random() < 0.10: # 10% of the time
            print('sending an out of order message')
            ts -= timedelta(seconds=random.gauss(10, 3), microseconds=random.gauss(200, 10))
            for quote in quotes:
                quote['timestamp'] = ts

        # perhaps take out some of the reference crosses and mix them up
        quotes = random.sample(quotes, k=len(quotes) - random.choice((0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 3)))

        # occasionally put in an arbitrage
        if random.random() < 0.95:  # 5% of the time
            xxx, yyy = sorted(random.sample(list(self.reference), 2))
            xxx_per_usd = self.reference[xxx] if xxx not in REVERSE_QUOTED else 1/self.reference[xxx]
            yyy_per_usd = self.reference[yyy] if yyy not in REVERSE_QUOTED else 1/self.reference[yyy]
            rate = (yyy_per_usd / xxx_per_usd) * random.gauss(1.0, 0.01)
            if random.random() < 0.5:
                print('putting in a 3-way cycle')
                quotes.append({'cross': '{}/{}'.format(xxx, yyy), 'price': rate})
            else:
                print('putting in a 4-way cycle - v2')
                market_name = TestPublisher.format_market_order("CAD",xxx)
                quotes.append({'cross': '{}'.format(market_name), 'price': rate/2})
                market_name = TestPublisher.format_market_order("CAD",yyy)
                quotes.append({'cross': '{}'.format(market_name), 'price': rate*2})

        # send the messages to current subscribers
        message = fxp_bytes.marshal_message(quotes)
        for subscriber in self.subscriptions:
            print('publishing {} to {}'.format(quotes, subscriber))
            self.socket.sendto(message, subscriber)

        # pick a time to wait until the next message
        return 1.0  # FIXME randomize quiet time


class ForexProvider(object):
    """
    Accept subscriptions for a new instance of a given publisher class.
    """

    def __init__(self, request_address, publisher_class):
        """
        :param request_address:
        :param publisher_class: publisher class must support publish and register_
        """
        self.selector = selectors.DefaultSelector()
        self.subscription_requests = self.start_a_server(request_address)
        self.selector.register(self.subscription_requests, selectors.EVENT_READ)
        self.publisher = publisher_class()

    def run_forever(self):
        print('waiting for subscribers on {}  - v2'.format(self.subscription_requests))
        next_timeout = 0.2  # FIXME
        while True:
            events = self.selector.select(next_timeout)
            for key, mask in events:
                self.register_subscription()
            next_timeout = self.publisher.publish()

    def register_subscription(self):
        data, _address = self.subscription_requests.recvfrom(REQUEST_SIZE)
        subscriber = fxp_bytes.deserialize_address(data)
        self.publisher.register_subscription(subscriber)

    @staticmethod
    def start_a_server(address):
        """
        Start a socket bound to given address.

        :returns: listening socket
        """
        listener = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        listener.bind(address)
        listener.settimeout(0.2)  # FIXME
        return listener


if __name__ == '__main__':
    # if REQUEST_ADDRESS[1] == 50403:
    #     print('Pick your own port for testing!')
    #     print('Modify REQUEST_ADDRESS above to use localhost and some random port')
    #     exit(1)
    fxp = ForexProvider(REQUEST_ADDRESS, TestPublisher)
    fxp.run_forever()
