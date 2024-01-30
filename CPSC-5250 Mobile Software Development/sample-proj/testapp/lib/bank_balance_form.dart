import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BankBalancePage extends StatefulWidget {

  const BankBalancePage({Key? key}) : super(key: key);

  @override
  createState() => _BankBalancePageState();
}

class _BankBalancePageState extends State<BankBalancePage> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _bankBalanceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    double currentBalance = context.read<double>();
    _bankBalanceController.text = currentBalance.toString();
  }

  void _onclick() {
    double newbankBalance = double.parse(_bankBalanceController.text);
    _bankBalanceController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Text("Bank Balance"),
          TextFormField(
            controller: _bankBalanceController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Enter Bank Balance",
            ),
          ),

          ElevatedButton(
            onPressed: _onclick, 
            child: const Text("Submit")
          )
        ],
      )
    );
  }
}