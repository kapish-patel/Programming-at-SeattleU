import 'package:flutter/foundation.dart';

class BankAccount with ChangeNotifier {
  double _balance;

  BankAccount(this._balance);

  double getBalance() { return _balance; }

  void setBalance(double newBalance) {
    _balance = newBalance;
    notifyListeners();
  }
}