import 'package:budget_manager/bank_account.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class BankBalanceForm extends StatefulWidget {
  const BankBalanceForm({super.key});

  @override
  createState() => _BankBalanceFormState();
}

class _BankBalanceFormState extends State<BankBalanceForm> {
  final TextEditingController _balanceController = TextEditingController();

  @override
  initState() {
    super.initState();
    print('initializing bank balance form');
    _balanceController.text = '${context.read<BankAccount>().getBalance()}';
  }

  _onSave() {
    double newBalance = double.parse(_balanceController.text);
    print('updating bank balance to $newBalance');
    context.read<BankAccount>().setBalance(newBalance);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _balanceController,
          keyboardType: TextInputType.number,
        ),
        ElevatedButton(
          onPressed: _onSave,
          child: const Text('Save'),
        )
      ]
    );
  }
}
