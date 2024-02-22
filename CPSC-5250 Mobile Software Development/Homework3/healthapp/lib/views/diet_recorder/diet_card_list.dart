import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthapp/view-models/switcher_provider.dart';
import 'package:provider/provider.dart';

class DietCardList extends StatelessWidget {
  final String foodName;
  final String calories;
  final String quantity;
  final String dateTime;
  final Function ontapDelete;
  final Function ontapEdit;

  const DietCardList({
    Key? key,
    required this.foodName,
    required this.calories,
    required this.quantity,
    required this.dateTime,
    required this.ontapDelete,
    required this.ontapEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSwitched = context.watch<SwitcherProvider>().isSwitched;

    return isSwitched ?
    // cupertino widgets
    Card(
      elevation: 3,
      margin: const EdgeInsets.all(8),
      child: CupertinoListTile(
        title: Text(
          foodName,
          style: const TextStyle(fontSize: 18),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Calories: $calories, Quantity: $quantity',
              style: const TextStyle(fontSize: 12),
            ),
            Text(
              dateTime,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoButton(
              onPressed: () {
                ontapEdit();
              },
              child: const Icon(Icons.edit),
            ),
            CupertinoButton(
              onPressed: () {
                ontapDelete();
              },
              child: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    )
    :
    Card(
      elevation: 3,
      margin: const EdgeInsets.all(8),
      child: ListTile(
        title: Text(
          foodName,
          style: const TextStyle(fontSize: 18),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Calories: $calories, Quantity: $quantity',
              style: const TextStyle(fontSize: 12),
            ),
            Text(
              dateTime,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                ontapEdit();
              },
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                ontapDelete();
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
