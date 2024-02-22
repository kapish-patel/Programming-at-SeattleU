import 'package:flutter/material.dart';
import 'package:healthapp/models/Data_Model/diet_model.dart';
import 'package:healthapp/view-models/diet_provider.dart';
import 'package:provider/provider.dart';

class EditDietPage extends StatelessWidget {
  final String uuid;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController mealNameController; 
  final TextEditingController caloriesController; 
  final TextEditingController quantityController; 


   EditDietPage({Key? key, required this.uuid})
      : mealNameController = TextEditingController(),
        caloriesController = TextEditingController(),
        quantityController = TextEditingController(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final dietProvider = Provider.of<DietProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Diet Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: dietProvider.getDietByUuid(uuid),
          builder:(context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              mealNameController.text = snapshot.data?.mealname ?? '';
              caloriesController.text = snapshot.data?.calories.toString() ?? '';
              quantityController.text = snapshot.data?.quantity.toString() ?? '';
              return Form(
                key: formKey,
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: mealNameController,
                      decoration: const InputDecoration(
                        labelText: 'Food Name',
                      ),
                      onChanged: (value) => mealNameController.text = value,
                    ),
                    TextFormField(
                      controller: caloriesController,
                      decoration: const InputDecoration(
                        labelText: 'Calories',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) => caloriesController.text = value,
                    ),
                    TextFormField(
                      controller: quantityController,
                      decoration: const InputDecoration(
                        labelText: 'Quantity',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) => quantityController.text = value,
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {

                            FocusScope.of(context).unfocus();

                            dietProvider.updateDiet(
                              DietRecorderModel(
                                mealNameController.text,
                                int.parse(caloriesController.text),
                                int.parse(quantityController.text),
                                DateTime.now(),
                                uuid
                              )
                            );

                            // clear the text fields
                            mealNameController.clear();
                            caloriesController.clear();
                            quantityController.clear();
                            
                          }
                        },
                        child: const Text('Update'),
                      ),
                    ),
                  ],
                )
              );
            }
          },
        )
      ),
    );
  }
}
