import 'dart:developer';

import 'package:all_document_reader/dependencies/init.dart';
import 'package:all_document_reader/local_storage/local_db.dart';
import 'package:all_document_reader/ui/components/colors.dart';
import 'package:all_document_reader/ui/screens/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'language_Constants/language_constants.dart';

int? initscreen;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  initscreen = await Preferences().getIsOnboarding();

  log(initscreen.toString());

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    Preferences().getFavoritesList();
    Preferences().getThemeStatus();

    getLocale().then((locale) => setLocale(locale));
    // ignore: todo
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: _locale,
        themeMode: ThemeMode.system,
        theme: Styles.lightTheme,
        darkTheme: Styles.darkTheme,
        initialBinding: HomeBinding(),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        // theme: ThemeData(fontFamily: GoogleFonts.nunito().fontFamily),
        home: const SplashScreen());
  }
}
