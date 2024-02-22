import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthapp/view-models/switcher_provider.dart';
import 'package:provider/provider.dart';

class Switcher extends StatelessWidget {
  const Switcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final value = context.watch<SwitcherProvider>().isSwitched;
    return Container(
      padding: const EdgeInsets.all(10),
      child: value ? CupertinoSwitch(
        activeColor: Colors.orange[600],
        value: value, 
        onChanged: (value) {
          context.read<SwitcherProvider>().toggleSwitch(value);
        }
      )
      : 
      Switch(
        activeColor: Colors.orange[600],
        value: value, 
        onChanged: (value) {
          context.read<SwitcherProvider>().toggleSwitch(value);
        }
      )
    );
  }
}
