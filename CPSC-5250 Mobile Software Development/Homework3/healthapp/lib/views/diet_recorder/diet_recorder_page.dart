import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthapp/view-models/diet_provider.dart';
import 'package:healthapp/view-models/switcher_provider.dart';
import 'package:healthapp/views/custom_bottom_sheet.dart';
import 'package:healthapp/views/custom_bottom_sheet_ios.dart';
import 'package:healthapp/views/diet_recorder/diet_history.dart';
import 'package:healthapp/views/diet_recorder/diet_recorder_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:healthapp/views/switcher.dart';
import 'package:provider/provider.dart';

class DietRecorderPage extends StatelessWidget {
  const DietRecorderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSwitched = context.watch<SwitcherProvider>().isSwitched;
    return Scaffold(
      appBar: AppBar(
        title: Text('${AppLocalizations.of(context)!.diet} ${AppLocalizations.of(context)!.recorder}'),
        actions: [
          const Switcher(),
          IconButton(
            onPressed: () {
              isSwitched ?
              showCupertinoModalPopup(
                context: context, 
                builder: (context) {
                  return const CustomBottomSheetIos();
                }
              )
              :
              showModalBottomSheet(
                context: context, 
                builder: (context) => const CustomBottomSheet()
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Container(
      child: Column(
        children: <Widget>[
          const DietRecorderForm(),
          Expanded(
            child: FutureBuilder(
              future: Provider.of<DietProvider>(context, listen: false).getDiets(), 
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return const DietHistory();
                }
              },
            )
          ),
        ],
      ),
    )
    );
  }
}
