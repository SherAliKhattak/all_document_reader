import 'dart:async';
// import 'package:all_document_reader/controllers/home_screen_controller.dart';
import 'package:all_document_reader/local_storage/local_db.dart';
import 'package:all_document_reader/main.dart';
import 'package:all_document_reader/ui/components/colors.dart';
import 'package:all_document_reader/ui/components/images.dart';
import 'package:all_document_reader/ui/screens/home_screen.dart';
import 'package:all_document_reader/ui/screens/onboarding_screen/onboarding_screen.dart';
import 'package:flutter/material.dart';

import '../../../controllers/home_screen_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool visible = false;
  @override
  void initState() {
    Preferences().setisOnboarding();
    Future.delayed(const Duration(microseconds: 100), () {
      setState(() {
        visible = !visible;
      });
    });

    Timer(
        const Duration(seconds: 6),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => initscreen == 0 || initscreen == null
                    ? const OnBoardingScreen()
                    : const HomeScreen())));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    HomeScreenController.instance.callFileFunctions(context);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: AnimatedOpacity(
              duration: const Duration(seconds: 4),
              opacity: visible ? 1.0 : 0.0,
              child: ClipRRect(
                  child: Image.asset(
                Images.logo,
                height: 200,
              )),
            ),
          ),
        ],
      ),
      bottomNavigationBar: AnimatedOpacity(
        duration: const Duration(seconds: 6),
        opacity: visible ? 1.0 : 0.0,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'All ',
                style: TextStyle(
                    fontSize: 25,
                    color: Theme.of(context).secondaryHeaderColor),
              ),
              Text('document ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).secondaryHeaderColor)),
              const Text('Reader',
                  style: TextStyle(color: kSecondaryLightColor, fontSize: 25))
            ],
          ),
        ),
      ),
    );
  }
}
