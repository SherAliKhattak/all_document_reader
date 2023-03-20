import 'dart:developer';
import 'dart:io';

import 'package:all_document_reader/controllers/favorites_controller.dart';
import 'package:all_document_reader/controllers/home_screen_controller.dart';
import 'package:all_document_reader/local_storage/local_db.dart';
import 'package:all_document_reader/ui/components/colors.dart';
import 'package:all_document_reader/ui/components/favorites_bottomsheet.dart';
import 'package:all_document_reader/ui/components/images.dart';
import 'package:all_document_reader/utils/home_page_utils/home_page_utils.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screens/pages/file_reader.dart';

// ignore: must_be_immutable
class FileCard extends StatefulWidget {
  List<FileSystemEntity>? files;
  int? index;
  String? title;
  String? file;
  bool isVisible = false;
  bool allChecked;
  FileCard(
      {Key? key,
      this.index,
      required this.isVisible,
      required this.allChecked,
      this.file,
      this.files,
      this.title})
      : super(key: key);

  @override
  State<FileCard> createState() => _FileCardState();
}

class _FileCardState extends State<FileCard> {
  var controller = HomeScreenController.instance;
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => FileReader(
              path: widget.file!,
            ));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 1),
        height: Get.height * 0.11,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Theme.of(context).primaryColorDark,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: const EdgeInsets.only(right: 20),
                //  padding: const EdgeInsets.all(15),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Image.asset(
                  getImage(widget.file!),
                  fit: BoxFit.fitWidth,
                  height: 50,
                  width: 50,
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: Get.width * 0.6,
                  child: AutoSizeText(
                    widget.file!.split('/').last,
                    maxFontSize: 15,
                    minFontSize: 12,
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Theme.of(context).secondaryHeaderColor,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6.0, bottom: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      File(widget.file!).existsSync()
                          ? Text(
                              ' ${HomePageUtils.formatTime(File(widget.file!).lastAccessedSync().toIso8601String())}',
                              style: TextStyle(
                                  color: Theme.of(context).secondaryHeaderColor,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12),
                            )
                          : const SizedBox(),
                      SizedBox(
                        width: Get.width * 0.03,
                      ),
                      File(widget.file!).existsSync()
                          ? Text(
                              '${HomePageUtils.getFileSize(File(widget.file!))} Kbs',
                              style: TextStyle(
                                  color: Theme.of(context).secondaryHeaderColor,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12),
                            )
                          : Container()
                    ],
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          HomePageUtils.shareFile(fileName: widget.file);
                        },
                        child: const Icon(
                          Icons.share_sharp,
                          color: kPrimaryLightcolor,
                          size: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {
                          if (widget.title == 'Favorites') {
                            BottomSheets.favoritesBottomSheet(
                                file: widget.file!);
                          } else {
                            Get.bottomSheet(Container(
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30)),
                                  color: Theme.of(context).primaryColorDark),
                              height: Get.height * 0.35,
                              child:
                                  StatefulBuilder(builder: (context, newState) {
                                return GetBuilder<FavoritesController>(
                                    builder: (homecontroller) {
                                  return Container(
                                      padding: const EdgeInsets.all(20),
                                      child: ListView(
                                        children: [
                                          SizedBox(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Image.asset(
                                                  Images.pdf,
                                                  height: 50,
                                                  width: 50,
                                                ),
                                                SizedBox(
                                                  width: Get.width * 0.03,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: Get.width * 0.7,
                                                      child: AutoSizeText(
                                                        widget.file!
                                                            .split('/')
                                                            .last,
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .secondaryHeaderColor),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxFontSize: 15,
                                                        minFontSize: 11,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            Get.height * 0.02),
                                                    File(widget.file!)
                                                            .existsSync()
                                                        ? Text(
                                                            ' ${HomePageUtils.formatTime(File(widget.file!).lastModifiedSync().toIso8601String())}',
                                                            style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .secondaryHeaderColor),
                                                          )
                                                        : Container(),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.02,
                                          ),
                                          Divider(
                                            color: Theme.of(context)
                                                .secondaryHeaderColor,
                                          ),
                                          InkWell(
                                            onTap: (() {
                                              if (homecontroller.favoriteFiles
                                                      .contains(widget.file!) ==
                                                  false) {
                                                homecontroller.addToFavorites(
                                                    widget.file);
                                                Get.back();

                                                log(homecontroller.favoriteFiles
                                                    .toString());
                                              } else {
                                                // ignore: list_remove_unrelated_type
                                                homecontroller
                                                    .removefromFavorites(
                                                        widget.file);

                                                log(homecontroller.favoriteFiles
                                                    .toString());
                                                Get.back();
                                              }

                                              Preferences().saveFavoritesList(
                                                  homecontroller.favoriteFiles);
                                            }),
                                            child: IconTextListTile(
                                              // ignore: iterable_contains_unrelated_type
                                              text: homecontroller.favoriteFiles
                                                      .contains(widget.file!)
                                                  ? 'Added to Favorites'
                                                  : 'Add to Favorites',
                                              icon: Icons.favorite,
                                              iconColor: homecontroller
                                                      .favoriteFiles
                                                      .contains(widget.file!)
                                                  ? Colors.red
                                                  : Colors.grey,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              HomePageUtils.shareFile(
                                                  fileName: widget.file);
                                              log(widget.file!);
                                            },
                                            child: const IconTextListTile(
                                              text: 'Share',
                                              icon: Icons.share,
                                            ),
                                          ),
                                          IconTextListTile(
                                            onTap: () {
                                              log('ontap called');
                                              HomePageUtils().deleteFile(
                                                  File(widget.file!), context);
                                              setState(() {
                                                controller.directory
                                                    .removeAt(widget.index!);
                                                widget.files!
                                                    .removeAt(widget.index!);
                                                widget.files!
                                                    .remove(File(widget.file!));
                                              });
                                              controller.directory
                                                  .remove(File(widget.file!));
                                              setState(() {});
                                            },
                                            icon: Icons.delete,
                                            text: 'Delete',
                                          )
                                        ],
                                      ));
                                });
                              }),
                            ));
                          }
                        },
                        child: const Icon(
                          Icons.more_vert,
                          color: kPrimaryLightcolor,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Visibility(
                visible: widget.isVisible,
                child: Expanded(
                    child: Checkbox(
                        tristate: true,
                        activeColor: kSecondaryLightColor,
                        checkColor: kPrimaryColor,
                        value: isChecked || widget.allChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = !isChecked;
                          });
                          if (!isChecked) {
                            HomeScreenController.instance.sharedFiles
                                .remove(widget.file);
                            controller.XshareFiles.remove(File(widget.file!));
                          } else {
                            HomeScreenController.instance.sharedFiles
                                .add(widget.file!);
                            controller.XshareFiles.add(File(widget.file!));
                          }
                          log(HomeScreenController.instance.sharedFiles
                              .toString());
                        })))
          ],
        ),
      ),
    );
  }
}

String getFileExtenion(String path) => path.split('.').last;
String getImage(String path) {
  String ext = getFileExtenion(path);
  if (ext == 'pdf') {
    return Images.pdf;
  } else if (ext == 'docx' || ext == 'doc') {
    return Images.doc;
  } else if (ext == 'xls') {
    return Images.xls;
  } else if (ext == 'txt') {
    return Images.txt;
  } else {
    return Images.ppt;
  }
}

class IconTextListTile extends StatelessWidget {
  final IconData? icon;
  final String? text;
  final Color? iconColor;
  final Function()? onTap;
  const IconTextListTile({
    Key? key,
    this.icon,
    this.text,
    this.iconColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: Icon(
          icon,
          color: iconColor,
        ),
        textColor: Theme.of(context).secondaryHeaderColor,
        title: Text(
          text!,
          style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
        ),
      ),
    );
  }
}
