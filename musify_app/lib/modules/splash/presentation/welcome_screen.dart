import 'package:flutter/material.dart';
import 'package:musify_app/core/extentions/buildcontect_extention.dart';
import 'package:musify_app/widgets/buttons/bouncing_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = context.loc;
    return Scaffold(
      body: Container(),
      bottomNavigationBar: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BouncingButton(
              onPressed: () {},
              title: localization.continue_txt,
            ),
          ],
        ),
      ),
    );
  }
}
