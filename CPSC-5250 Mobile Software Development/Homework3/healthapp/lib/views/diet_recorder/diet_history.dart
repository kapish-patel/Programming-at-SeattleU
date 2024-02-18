import 'package:flutter/material.dart';
import 'package:healthapp/router.dart';
import 'package:healthapp/view-models/diet_provider.dart';
import 'package:healthapp/views/diet_recorder/diet_card_list.dart';
import 'package:provider/provider.dart';


class DietHistory extends StatelessWidget {
  const DietHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dietProvider = Provider.of<DietProvider>(context);

    return ListView.builder(
      itemCount: dietProvider.diets.length,
      itemBuilder: (context, index) {
        return DietCardList(
          foodName: dietProvider.diets[index].mealname, 
          calories: dietProvider.diets[index].calories.toString(), 
          quantity: dietProvider.diets[index].quantity.toString(),
          dateTime: dietProvider.diets[index].dateTime.toString(),
          ontapDelete: () {
            dietProvider.deleteDiet(dietProvider.diets[index].uuid);
          },
          ontapEdit: (){
            String uuid = dietProvider.diets[index].uuid.toString();
            goRouter.go('/diet/edit/$uuid', 
            );
          },
        );
      },
    );
  }
}