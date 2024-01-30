import 'package:flutter/material.dart';
import 'package:healthapp/card_list.dart';
import 'package:provider/provider.dart';
import 'package:healthapp/providers/diet_provider.dart';

class DietHistory extends StatelessWidget {
  const DietHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, DietProvider dietProvider, child) {
      return ListView.builder(
        itemCount: dietProvider.diets.length,
        itemBuilder: (context, index) {
          return CardList(
            type: 'diet',
            mealname: dietProvider.diets[index].mealname, 
            calories: dietProvider.diets[index].calories.toString(), 
            quantity: dietProvider.diets[index].quantity.toString(),
            dateTime: dietProvider.diets[index].dateTime.toString(),
          );
        },
      );
    });
  }
}