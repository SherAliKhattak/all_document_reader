import 'package:all_document_reader/controllers/home_screen_controller.dart';
import 'package:all_document_reader/local_storage/local_db.dart';
import 'package:all_document_reader/utils/home_page_utils/home_page_utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:all_document_reader/ui/components/colors.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../../../language_Constants/language_constants.dart';
import '../../../language_model.dart';
import '../../../main.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  Language selected = Language(1, 'English', 'en');
  @override
  void initState() {
    selectedLang();
    super.initState();
  }

  selectedLang() async {
    selected.name = await Preferences().getSelectedLanguage() ?? 'English';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Language> languagesList = <Language>[
      Language(1, 'English', 'en'),
      Language(2, "French", 'fr'),
      Language(3, 'Urdu', 'ur'),
      Language(4, 'Chinese', 'zh'),
    ];
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          translation(context).settings,
          style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
        ),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(
              FontAwesomeIcons.thumbsUp,
              color: Theme.of(context).secondaryHeaderColor,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: ListView(
          children: [
            GestureDetector(
              onTap: () {
                Share.share('com.officereader.documents',
                    subject: 'My new app i just created');
              },
              child: ListTile(
                tileColor: Theme.of(context).primaryColorDark,
                textColor: Theme.of(context).secondaryHeaderColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    15.0,
                  ),
                ),
                leading: Icon(
                  Icons.share_sharp,
                  color: Theme.of(context).primaryColorLight,
                  size: 20,
                ),
                title: Text(
                  translation(context).shareApp,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Divider(
              height: 0,
            ),
            ListTile(
              textColor: Theme.of(context).secondaryHeaderColor,
              tileColor: Theme.of(context).primaryColorDark,
              leading: Icon(
                Icons.language,
                color: Theme.of(context).primaryColorLight,
                size: 20,
              ),
              title: Text(
                translation(context).languageOptions,
              ),
              trailing: TextButton(
                  onPressed: () => languageSelector(context, languagesList),
                  child: SizedBox(
                    height: 20,
                    width: 80,
                    child: Row(
                      children: [
                        Text(selected.name!,
                            style: TextStyle(
                                color: Theme.of(context).secondaryHeaderColor)),
                        const Icon(Icons.keyboard_arrow_down,
                            color: kPrimaryLightcolor)
                      ],
                    ),
                  )),
            ),
            const Divider(
              height: 0,
            ),
            ObxValue(
                (data) => ListTile(
                    tileColor: Theme.of(context).primaryColorDark,
                    textColor: Theme.of(context).secondaryHeaderColor,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15))),
                    leading: Icon(
                      Icons.dark_mode,
                      color: Theme.of(context).primaryColorLight,
                      size: 20,
                    ),
                    title: Text(
                      translation(context).darkMode,
                    ),
                    trailing: Switch(
                        value: HomeScreenController.instance.isLightTheme.value,
                        activeColor: Theme.of(context).secondaryHeaderColor,
                        onChanged: (bool value) {
                          HomeScreenController.instance.isLightTheme.value =
                              value;
                          Get.changeThemeMode(
                              HomeScreenController.instance.isLightTheme.value
                                  ? ThemeMode.dark
                                  : ThemeMode.light);
                          Preferences().saveThemeStatus();
                        })),
                false.obs),
            const SizedBox(
              height: 5,
            ),
            ListTile(
              tileColor: Theme.of(context).primaryColorDark,
              textColor: Theme.of(context).secondaryHeaderColor,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              leading: Icon(
                Icons.textsms,
                color: Theme.of(context).primaryColorLight,
                size: 20,
              ),
              title: Text(
                translation(context).feedBack,
              ),
            ),
            const Divider(
              height: 0,
            ),
            GestureDetector(
              onTap: () {
                HomePageUtils().launchUrlbrowser();
              },
              child: ListTile(
                tileColor: Theme.of(context).primaryColorDark,
                textColor: Theme.of(context).secondaryHeaderColor,
                leading: Icon(
                  Icons.gpp_maybe,
                  color: Theme.of(context).primaryColorLight,
                  size: 20,
                ),
                title: Text(
                  translation(context).privacyPolicy,
                ),
              ),
            ),
            const Divider(
              height: 0,
            ),
            ListTile(
              tileColor: Theme.of(context).primaryColorDark,
              textColor: Theme.of(context).secondaryHeaderColor,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              leading: Icon(
                Icons.error,
                color: Theme.of(context).primaryColorLight,
                size: 20,
              ),
              title: Text(
                translation(context).version,
              ),
              trailing: Text(
                '1.3.2B',
                style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> languageSelector(
      BuildContext context, List<Language> languageList) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) =>
          StatefulBuilder(builder: (context, newState) {
        return AlertDialog(
          backgroundColor: Theme.of(context).primaryColorDark,
          title: Text(
            'Select Language',
            style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                for (int i = 0; i < languageList.length; i++)
                  ListTile(
                      iconColor: Theme.of(context).secondaryHeaderColor,
                      textColor: Theme.of(context).secondaryHeaderColor,
                      onTap: () {
                        newState(() {
                          setState(() {
                            selected = languageList[i];
                          });
                        });
                      },
                      title: Text(languageList[i].name!),
                      trailing: Radio<Language>(
                          hoverColor: Theme.of(context).secondaryHeaderColor,
                          activeColor: Theme.of(context).secondaryHeaderColor,
                          value: languageList[i],
                          groupValue: selected,
                          focusColor: Theme.of(context).secondaryHeaderColor,
                          onChanged: (Language? value) async {
                            if (value != null) {
                              Preferences().selectedLanguage(value.name);
                              Locale locale =
                                  await setLocale(value.languageCode!);
                              // ignore: use_build_context_synchronously
                              MyApp.setLocale(context, locale);
                            }
                            newState(() {
                              setState(() {
                                selected = value!;
                              });
                            });
                          })),
              ],
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryLightcolor),
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel')),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kSecondaryLightColor),
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('Ok')),
                  )
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
