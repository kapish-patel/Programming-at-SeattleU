import 'package:flutter/material.dart';

class BankAccount  with ChangeNotifier{
  double balance;

  BankAccount(this.balance);

  double getbalance() {
    return this.balance;
  }

}