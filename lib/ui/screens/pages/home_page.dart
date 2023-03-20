import 'package:all_document_reader/controllers/favorites_controller.dart';
import 'package:all_document_reader/controllers/home_screen_controller.dart';
import 'package:all_document_reader/language_Constants/language_constants.dart';
import 'package:all_document_reader/ui/components/colors.dart';
import 'package:all_document_reader/ui/components/list_file_type_card.dart';
import 'package:all_document_reader/ui/screens/pages/files_screen.dart';
import 'package:flutter/material.dart';

import 'package:all_document_reader/ui/components/file_type_card.dart';
import 'package:all_document_reader/ui/components/images.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    FavoritesController.instance.favoriteFiles;
    super.initState();
  }

  String? selectedextension;

  bool iconsState = true;

  @override
  Widget build(BuildContext context) {
    // controller instance
    var controller = HomeScreenController.instance;
    // list filering to mentioned extension
    HomeScreenController.instance.list = HomeScreenController.instance.directory
        .where((element) =>
            element.path.split('/').last.endsWith(selectedextension!));

    //

    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(
                    text: translation(context).all,
                    style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontSize: 20),
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
                    text: translation(context).document,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).secondaryHeaderColor,
                        fontSize: 20)),
                TextSpan(
                    text: translation(context).reader,
                    style: const TextStyle(
                        color: kSecondaryLightColor,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          actions: [
            IconButton(
                splashRadius: 25,
                alignment: Alignment.center,
                onPressed: () {
                  setState(() {
                    iconsState = !iconsState;
                  });
                  // print(iconsState);
                },
                icon: iconsState
                    ? Image.asset(
                        Images.list,
                        height: 20,
                        width: 20,
                        color: Theme.of(context).secondaryHeaderColor,
                      )
                    : Image.asset(
                        Images.box,
                        height: 20,
                        width: 20,
                        color: Theme.of(context).secondaryHeaderColor,
                      )),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                  splashRadius: 25,
                  onPressed: () {
                    setState(() {
                      selectedextension = '';
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FilesScreen(
                                    image: Images.word,
                                    title: translation(context).allFiles,
                                    files: controller.list!.toList(),
                                  )));
                    });
                  },
                  icon: Image.asset(
                    Images.searching,
                    height: 20,
                    width: 20,
                    color: Theme.of(context).secondaryHeaderColor,
                  )),
            )
          ],
        ),
        body: GetBuilder<HomeScreenController>(builder: (homeScreenController) {
          return Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  Images.imagetoPdf,
                  // height: 200,
                  fit: BoxFit.fill,
                ),
              ),
              iconsState
                  ? Expanded(
                      child: GridView.count(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      childAspectRatio: 2,
                      crossAxisCount: 2,
                      children: [
                        GetBuilder<HomeScreenController>(builder: (controller) {
                          return FileTypeCard(
                            title: translation(context).allFiles,
                            image: Images.word,
                            onPressed: () {
                              setState(() {
                                selectedextension = '';
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => FilesScreen(
                                              image: Images.word,
                                              title:
                                                  translation(context).allFiles,
                                              files: controller.list!.toList(),
                                            ))));
                              });
                            },
                            subtitle:
                                '${controller.directory.where((element) => element.path.endsWith('.pdf') || element.path.endsWith('.docx') || element.path.endsWith('.xls') || element.path.endsWith('.txt') || element.path.endsWith('.pptx')).length} Files',
                          );
                        }),
                        GetBuilder<HomeScreenController>(builder: (controller) {
                          return FileTypeCard(
                            title: translation(context).pdfFiles,
                            image: Images.pdf,
                            onPressed: () {
                              setState(() {
                                selectedextension = '.pdf';
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => FilesScreen(
                                              image: Images.pdf,
                                              title:
                                                  translation(context).pdfFiles,
                                              files: controller.list!.toList(),
                                              extension: '.pdf',
                                            ))));
                              });
                            },
                            subtitle:
                                '${controller.directory.where((element) => element.path.endsWith('.pdf')).length} Files',
                          );
                        }),
                        GetBuilder<HomeScreenController>(builder: (controller) {
                          return FileTypeCard(
                            title: translation(context).word,
                            image: Images.doc,
                            onPressed: () {
                              setState(() {
                                selectedextension = '.docx';
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => FilesScreen(
                                              image: Images.doc,
                                              title: translation(context).word,
                                              files: controller.list!.toList(),
                                              extension: '.docx',
                                            ))));
                              });
                            },
                            subtitle:
                                '${controller.directory.where((element) => element.path.endsWith('.docx')).length} Files',
                          );
                        }),
                        GetBuilder<HomeScreenController>(builder: (controller) {
                          return FileTypeCard(
                            title: translation(context).excelFiles,
                            image: Images.xls,
                            onPressed: () {
                              setState(() {
                                selectedextension = '.xls';
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => FilesScreen(
                                              image: Images.xls,
                                              title: translation(context)
                                                  .excelFiles,
                                              files: controller.list!.toList(),
                                              extension: '.xls',
                                            ))));
                              });
                            },
                            subtitle:
                                '${controller.directory.where((element) => element.path.endsWith('.xls')).length} Files',
                          );
                        }),
                        GetBuilder<HomeScreenController>(builder: (controller) {
                          return FileTypeCard(
                            title: translation(context).pptFiles,
                            image: Images.ppt,
                            onPressed: () {
                              selectedextension = '.pptx';
                              setState(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => FilesScreen(
                                              image: Images.ppt,
                                              title:
                                                  translation(context).pptFiles,
                                              files: controller.list!.toList(),
                                              extension: '.pptx',
                                            ))));
                              });
                            },
                            subtitle:
                                '${controller.directory.where((element) => element.path.endsWith('.pptx')).length} Files',
                          );
                        }),
                        GetBuilder<HomeScreenController>(builder: (controller) {
                          return FileTypeCard(
                            title: translation(context).txtFiles,
                            image: Images.txt,
                            onPressed: () {
                              setState(() {
                                selectedextension = '.txt';
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => FilesScreen(
                                              image: Images.txt,
                                              title:
                                                  translation(context).txtFiles,
                                              files: controller.list!.toList(),
                                            ))));
                              });
                            },
                            subtitle:
                                '${controller.directory.where((element) => element.path.endsWith('.txt')).length} Files',
                          );
                        }),
                        Material(
                          borderRadius: BorderRadius.circular(5),
                          elevation: 2,
                          child: ListTile(
                            textColor: Theme.of(context).secondaryHeaderColor,
                            onTap: (() {
                              Get.to(() => FilesScreen(
                                    title: 'Favorites',
                                    favoriteFiles: FavoritesController
                                        .instance.favoriteFiles,
                                    image: Images.favorite,
                                  ));
                            }),
                            tileColor: Theme.of(context).primaryColorDark,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            title: const Text('Favorites'),
                            subtitle: GetBuilder<FavoritesController>(
                                builder: (controller) {
                              return Text(
                                  '${controller.favoriteFiles.length.toString()} Files');
                            }),
                            trailing: RotationTransition(
                              turns: const AlwaysStoppedAnimation(30 / 360),
                              child: Image.asset(
                                Images.favorite,
                                height: 40,
                                width: 40,
                              ),
                            ),
                          ),
                        )
                      ],
                    ))
                  : Expanded(
                      child: GridView.count(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        childAspectRatio: 4.5,
                        crossAxisCount: 1,
                        children: [
                          ListTypeCard(
                              onPressed: () {
                                setState(() {
                                  selectedextension = '';
                                  Get.to(() => FilesScreen(
                                        image: Images.doc,
                                        title: translation(context).allFiles,
                                        files: controller.list!.toList(),
                                      ));
                                });
                              },
                              title: translation(context).allFiles,
                              image: Images.word,
                              subtitle:
                                  '${controller.directory.where((element) => element.path.endsWith('.pdf') || element.path.endsWith('.docx') || element.path.endsWith('.xls') || element.path.endsWith('.txt') || element.path.endsWith('.pptx')).length}'),
                          ListTypeCard(
                              onPressed: () {
                                setState(() {
                                  selectedextension = '.pdf';
                                  Get.to(() => FilesScreen(
                                        image: Images.pdf,
                                        title: translation(context).pdfFiles,
                                        files: controller.list!.toList(),
                                      ));
                                });
                              },
                              title: translation(context).pdfFiles,
                              image: Images.pdf,
                              subtitle:
                                  '${controller.directory.where((element) => element.path.endsWith('.pdf')).length}'),
                          ListTypeCard(
                            onPressed: () {
                              setState(() {
                                selectedextension = '.docx';
                                Get.to(() => FilesScreen(
                                      image: Images.word,
                                      title: translation(context).word,
                                      files: controller.list!.toList(),
                                    ));
                              });
                            },
                            title: translation(context).word,
                            image: Images.doc,
                            subtitle:
                                '${controller.directory.where((element) => element.path.endsWith('.docx')).length}',
                          ),
                          ListTypeCard(
                              onPressed: () {
                                setState(() {
                                  selectedextension = '.xls';
                                  Get.to(() => FilesScreen(
                                        image: Images.xls,
                                        title: translation(context).excelFiles,
                                        files: controller.list!.toList(),
                                      ));
                                });
                              },
                              title: translation(context).excelFiles,
                              image: Images.xls,
                              subtitle:
                                  '${controller.directory.where((element) => element.path.endsWith('.xls')).length}'),
                          ListTypeCard(
                              onPressed: () {
                                setState(() {
                                  selectedextension = '.pptx';
                                  Get.to(() => FilesScreen(
                                        image: Images.ppt,
                                        title: translation(context).pptFiles,
                                        files: controller.list!.toList(),
                                      ));
                                });
                              },
                              title: translation(context).pptFiles,
                              image: Images.ppt,
                              subtitle:
                                  '${controller.directory.where((element) => element.path.endsWith('.pptx')).length}'),
                          ListTypeCard(
                              onPressed: () {
                                setState(() {
                                  selectedextension = '.txt';
                                  Get.to(() => FilesScreen(
                                        image: Images.txt,
                                        title: translation(context).txtFiles,
                                        files: controller.list!.toList(),
                                      ));
                                });
                              },
                              title: translation(context).txtFiles,
                              image: Images.txt,
                              subtitle:
                                  '${controller.directory.where((element) => element.path.endsWith('.txt')).length}'),
                          GetBuilder<FavoritesController>(builder: (favorites) {
                            return ListTypeCard(
                                onPressed: () {
                                  setState(() {
                                    Get.to(() => FilesScreen(
                                          image: Images.favorite,
                                          title: translation(context).favorites,
                                          favoriteFiles:
                                              favorites.favoriteFiles,
                                        ));
                                  });
                                },
                                title: translation(context).favorites,
                                image: Images.favorite,
                                subtitle:
                                    favorites.favoriteFiles.length.toString());
                          })
                        ],
                      ),
                    )
            ],
          );
        }));
  }
}
