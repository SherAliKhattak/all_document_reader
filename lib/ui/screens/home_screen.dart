import 'package:all_document_reader/controllers/home_screen_controller.dart';
import 'package:all_document_reader/ui/screens/pages/files_screen.dart';
import 'package:flutter/material.dart';
import 'package:all_document_reader/ui/components/colors.dart';
import 'package:all_document_reader/ui/components/images.dart';
import 'package:all_document_reader/ui/screens/pages/home_page.dart';
import 'package:all_document_reader/ui/screens/pages/settings.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Permission.manageExternalStorage.request();
    Permission.storage.request();
    super.didChangeDependencies();
  }

  int selectedcolor = 1;
  Color _homeColor = kSecondaryLightColor;
  void iconColor() {
    if (selectedcolor == 0) {
      _homeColor = kSecondaryColor;
    } else if (selectedcolor == 2) {
      _homeColor = kSecondaryColor;
    } else if (selectedcolor == 1) {
      _homeColor = kSecondaryLightColor;
    }
  }

  final pageController = PageController(initialPage: 1);
  final List<Widget> _pages = [
    FilesScreen(
      files: HomeScreenController.instance.recentFiles,
      title: 'Recent Files',
    ),
    const HomePage(),
    const SettingScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  child: PageView.builder(
                      onPageChanged: (value) {
                        selectedcolor = value;
                        setState(() {
                          iconColor();
                        });
                      },
                      controller: pageController,
                      itemCount: _pages.length,
                      itemBuilder: (context, index) {
                        return _pages[index];
                      })),
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GestureDetector(
                      onTap: () {
                        pageController.jumpToPage(0);
                        setState(() {
                          iconColor();
                        });
                      },
                      child: Image.asset(
                        Images.recent,
                        height: 20,
                        width: 20,
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    GestureDetector(
                      onTap: () {
                        pageController.jumpToPage(2);
                        setState(() {
                          iconColor();
                        });
                      },
                      child: Image.asset(
                        Images.setting,
                        height: 20,
                        width: 20,
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: GestureDetector(
          onTap: () {
            pageController.jumpToPage(1);
            setState(() {
              iconColor();
            });
          },
          child: Container(
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
              color: _homeColor,
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                  color: kPrimaryLightcolor,
                  blurRadius: 5.0,
                  spreadRadius: 1.0,
                  offset: Offset(0.0, 0.0),
                )
              ],
            ),
            child: Align(
              alignment: Alignment.center,
              child: Image.asset(
                Images.home,
                height: 30,
                width: 30,
                color: kPrimaryColor,
              ),
            ),
          ),
        ));
  }
}
