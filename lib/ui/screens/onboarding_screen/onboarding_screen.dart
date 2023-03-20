import 'dart:developer';

import 'package:all_document_reader/ui/screens/home_screen.dart';
import 'package:all_document_reader/utils/home_page_utils/home_page_utils.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../language_Constants/language_constants.dart';
import '../../../local_storage/local_db.dart';
import '../../components/colors.dart';
import '../../components/images.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: Get.height * 0.35,
                width: Get.width * 1.1,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(Images.onboardImage))),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Container(
                margin: const EdgeInsets.only(left: 25, right: 20),
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Welcome To',
                          style: GoogleFonts.nunito(
                              color: Theme.of(context).secondaryHeaderColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 23),
                          children: <InlineSpan>[
                            WidgetSpan(
                                alignment: PlaceholderAlignment.baseline,
                                baseline: TextBaseline.alphabetic,
                                child: SizedBox(width: Get.width * 0.02)),
                          ]),
                      TextSpan(
                        children: <InlineSpan>[
                          WidgetSpan(
                              alignment: PlaceholderAlignment.baseline,
                              baseline: TextBaseline.alphabetic,
                              child: SizedBox(width: Get.width * 0.03)),
                        ],
                        text: 'D-Office',
                        style: GoogleFonts.nunito(
                            color: Theme.of(context).secondaryHeaderColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 23),
                      ),
                      TextSpan(
                          text: translation(context).reader,
                          style: GoogleFonts.nunito(
                              color: kSecondaryLightColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 23)),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.04,
              ),
              SizedBox(
                width: Get.width * 0.8,
                child: AutoSizeText(
                  'Read any PDF, Word, Excel, PPTx, Txt File in a simple and Easy way',
                  style: GoogleFonts.nunito(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                  maxLines: 2,
                  overflow: TextOverflow.fade,
                  maxFontSize: 18,
                  minFontSize: 15,
                ),
              ),
              SizedBox(
                height: Get.height * 0.07,
              ),
              TextButton(
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all<Size>(
                          Size(Get.width * 0.8, 40)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          kSecondaryLightColor)),
                  onPressed: () async {
                    await Preferences().setisOnboarding();
                    Get.to(() => const HomeScreen());
                  },
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  )),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Container(
                margin: const EdgeInsets.only(left: 25, right: 20),
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: 'By tapping "Continue", you indicate ',
                          style: GoogleFonts.nunito(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                          children: <InlineSpan>[
                            WidgetSpan(
                                alignment: PlaceholderAlignment.baseline,
                                baseline: TextBaseline.alphabetic,
                                child: SizedBox(width: Get.width * 0.01)),
                          ]),
                      TextSpan(
                        children: <InlineSpan>[
                          WidgetSpan(
                              alignment: PlaceholderAlignment.baseline,
                              baseline: TextBaseline.alphabetic,
                              child: SizedBox(width: Get.width * 0.01)),
                        ],
                        text: 'that you have read our',
                        style: GoogleFonts.nunito(
                            color: Colors.grey, fontSize: 15),
                      ),
                      TextSpan(
                          text: 'Privacy and Policy',
                          style: GoogleFonts.nunito(
                              color: kSecondaryLightColor,
                              textStyle: const TextStyle(
                                  decoration: TextDecoration.underline)),
                          children: <InlineSpan>[
                            WidgetSpan(
                                alignment: PlaceholderAlignment.baseline,
                                baseline: TextBaseline.alphabetic,
                                child: SizedBox(width: Get.width * 0.03)),
                          ],
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              HomePageUtils().launchUrlbrowser();
                              log('pressed');
                            }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
