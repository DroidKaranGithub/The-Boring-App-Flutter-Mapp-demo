import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/random_activity_provider.dart';
import '../widgets/custom_elevated_button_widget.dart';
import '../widgets/random_activity_widget.dart';

class RandomActivityPage extends StatelessWidget {
  const RandomActivityPage({Key? key}) : super(key: key);

  final int itemsNumber = 10;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const RandomActivityWidget(),
          CustomElevatedButtonWidget(
            buttonColor: Colors.orangeAccent,
            textColor: Colors.white,
            iconColor: Colors.white,
            callback: () {
              Provider.of<RandomActivityProvider>(context, listen: false)
                  .eitherFailureOrActivity();
            },
          ),
        ],
      ),
    );
  }
}
