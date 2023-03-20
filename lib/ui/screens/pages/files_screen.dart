// ignore_for_file: file_names

import 'dart:io';
import 'package:all_document_reader/controllers/favorites_controller.dart';
import 'package:all_document_reader/controllers/home_screen_controller.dart';
import 'package:all_document_reader/ui/components/images.dart';
import 'package:all_document_reader/utils/home_page_utils/home_page_utils.dart';
import 'package:flutter/material.dart';
import 'package:all_document_reader/ui/components/colors.dart';
import 'package:all_document_reader/ui/components/file_card.dart';
import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../language_Constants/language_constants.dart';

// ignore: must_be_immutable
class FilesScreen extends StatefulWidget {
  final String? extension;
  final String? image;
  // ignore: prefer_typing_uninitialized_variables
  List<FileSystemEntity>? files;
  List<String>? favoriteFiles;
  final String title;
  FilesScreen(
      {Key? key,
      required this.title,
      this.extension,
      this.files,
      this.image,
      this.favoriteFiles})
      : super(key: key);

  @override
  State<FilesScreen> createState() => _FilesScreenState();
}

class _FilesScreenState extends State<FilesScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    super.initState();
    _tabController.addListener(handleTabSelection);
  }

  @override
  void didChangeDependencies() {
    if (widget.title == 'Favorites') {
    } else {
      searchFiles.addAll(widget.files!.toList());
    }
    super.didChangeDependencies();
  }

  List<FileSystemEntity> searchFiles = [];
  TextEditingController searchController = TextEditingController();
  String searchText = '';
/////////////////////////////////////////////////
  /// Search Function
  searchFile(String path) {
    List<FileSystemEntity> results = [];
    List<String> favorites = [];
    if (path.isEmpty) {
      if (widget.title == 'Favorites') {
        favorites.addAll(widget.favoriteFiles!);
      } else {
        results.addAll(widget.files!);
      }
    } else {
      if (widget.title == 'Recent Files') {
        favorites = widget.favoriteFiles!
            .where((value) => value
                .toString()
                .toLowerCase()
                .trim()
                .replaceAll(' ', '')
                .contains(path))
            .toList();
      } else {
        results = HomeScreenController.instance.list!
            .where((value) => value.path
                .toString()
                .toLowerCase()
                .trim()
                .replaceAll(' ', '')
                .contains(path.toString()))
            .toList();
      }
    }
    setState(() {
      searchFiles = results;
    });
  }

  /////////////////////////////////
  bool isSelected = false;
  bool isSelectionMode = false;
  handleTabSelection() {
    if (_tabController.indexIsChanging) {
      switch (_tabController.index) {
        case 0:
          searchFiles = widget.files!
              .where((element) => element.path.endsWith('.pdf'))
              .toList();
          break;
        case 1:
          searchFiles = widget.files!
              .where((element) => element.path.endsWith('.docx'))
              .toList();
          break;
        case 2:
          searchFiles = widget.files!
              .where((element) => element.path.endsWith('.xls'))
              .toList();
          break;
        case 3:
          searchFiles = widget.files!
              .where((element) => element.path.endsWith('.pptx'))
              .toList();
          break;
        case 4:
          searchFiles = widget.files!
              .where((element) => element.path.endsWith('.txt'))
              .toList();
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> sort = [
      {
        'title': translation(context).lastModifies,
        'image': Images.calendar,
        'selectedSort': true
      },
      {
        'title': translation(context).name,
        'image': Images.name,
        'selectedSort': true,
      },
      {
        'title': translation(context).fileSize,
        'image': Images.size,
        'selectedSort': true,
      },
      {
        'title': translation(context).fromNewtoOld,
        'image': Images.sortdown,
        'selectedSort': true
      },
      {
        'title': translation(context).fromoldtoNew,
        'image': Images.sortup,
        'selectedSort': true
      }
    ];
    return DefaultTabController(
      length: 5,
      initialIndex: 0,
      animationDuration: const Duration(seconds: 1),
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBarWithSearchSwitch(
          fieldHintText: translation(context).search,
          //  leading:IconButton(onPressed: (){}, icon: null,),
          bottom: TabBar(
              controller: _tabController,
              indicatorColor: kSecondaryLightColor,
              tabs: <Widget>[
                Tab(
                  icon: Text(
                    'PDF',
                    style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor),
                  ),
                ),
                Tab(
                  icon: Text(
                    'Word',
                    style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor),
                  ),
                ),
                Tab(
                  icon: Text(
                    'Excel',
                    style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor),
                  ),
                ),
                Tab(
                  icon: Text(
                    'PPT',
                    style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor),
                  ),
                ),
                Tab(
                  icon: Text(
                    'TXT',
                    style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor),
                  ),
                )
              ]),

          keepAppBarColors: false,
          iconTheme: IconThemeData(
            color: Theme.of(context).secondaryHeaderColor,
          ),
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColorDark,

          customTextEditingController: searchController,
          onChanged: (text) {
            setState(() {
              searchFile(text);
            });
          },

          appBarBuilder: (context) {
            return AppBar(
                leading: isSelected
                    ? IconButton(
                        splashRadius: 25,
                        onPressed: () {
                          setState(() {
                            isSelected = !isSelected;
                          });
                        },
                        icon: Image.asset(
                          Images.backleading,
                          height: 20,
                          width: 20,
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                      )
                    : IconButton(
                        splashRadius: 25,
                        onPressed: () {
                          Get.back();
                        },
                        icon: Image.asset(
                          Images.backleading,
                          height: 20,
                          width: 20,
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                      ),
                iconTheme: IconThemeData(
                    color: Theme.of(context).secondaryHeaderColor),
                automaticallyImplyLeading: false,
                elevation: 0,
                backgroundColor: Theme.of(context).primaryColorDark,
                title: isSelected
                    ? Text(translation(context).selected,
                        style: TextStyle(
                            color: Theme.of(context).secondaryHeaderColor))
                    : Text(
                        widget.title,
                        style: TextStyle(
                            color: Theme.of(context).secondaryHeaderColor),
                      ),
                actions: isSelected
                    ? [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: IconButton(
                              splashRadius: 25,
                              onPressed: () {
                                setState(() {
                                  isSelected = !isSelected;
                                });
                                //print(isSelected);
                              },
                              icon: Image.asset(Images.select,
                                  height: 20,
                                  width: 20,
                                  color:
                                      Theme.of(context).secondaryHeaderColor)),
                        ),
                        IconButton(
                            splashRadius: 25,
                            onPressed: () {
                              // ignore: deprecated_member_use
                              Share.shareFiles(
                                  HomeScreenController.instance.sharedFiles);
                            },
                            icon: Image.asset(
                              Images.share,
                              height: 20,
                              width: 20,
                              color: Theme.of(context).secondaryHeaderColor,
                            )),
                      ]
                    : [
                        IconButton(
                            splashRadius: 25,
                            onPressed: () {
                              setState(() {
                                isSelected = !isSelected;
                              });
                            },
                            icon: Image.asset(Images.select,
                                height: 20,
                                width: 20,
                                color: Theme.of(context).secondaryHeaderColor)),
                        IconButton(
                            splashRadius: 25,
                            onPressed: () {
                              showModalBottomSheet<void>(
                                // shape: ShapeBorder(),
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (BuildContext context) =>
                                    StatefulBuilder(
                                  builder: (BuildContext context, newtState) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              topRight: Radius.circular(30))),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15, top: 10),
                                            child: Text(
                                              translation(context).sortBy,
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  color: Theme.of(context)
                                                      .secondaryHeaderColor),
                                            ),
                                          ),
                                          for (int i = 0; i < sort.length; i++)
                                            ListTile(
                                              textColor: Theme.of(context)
                                                  .secondaryHeaderColor,
                                              onTap: () {
                                                List<FileSystemEntity> sorted =
                                                    HomePageUtils().sortList(
                                                        searchFiles, i);

                                                setState(() {
                                                  searchFiles = sorted;
                                                });
                                                isSelectionMode =
                                                    !sort[i]["selectedSort"];

                                                newtState(() {
                                                  sort[i]["selectedSort"] =
                                                      isSelectionMode;
                                                });
                                              },
                                              title: Text(
                                                sort[i]['title'],
                                              ),
                                              leading: Image.asset(
                                                sort[i]['image'],
                                                height: 20,
                                                width: 20,
                                                color: Theme.of(context)
                                                    .secondaryHeaderColor,
                                              ),
                                              trailing: sort[i]["selectedSort"]
                                                  ? null
                                                  : Icon(
                                                      Icons.done,
                                                      color: Theme.of(context)
                                                          .secondaryHeaderColor,
                                                    ),
                                            ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  kPrimaryLightcolor),
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                      child:
                                                          const Text('Cancel')),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  kSecondaryLightColor),
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                      child: const Text('Ok')),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                            icon: Image.asset(
                              Images.sort,
                              height: 20,
                              width: 20,
                              color: Theme.of(context).secondaryHeaderColor,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: AppBarSearchButton(
                            searchActiveButtonColor:
                                Theme.of(context).secondaryHeaderColor,
                          ),
                        ),
                      ]);
          },
        ),
        body: widget.title == 'Recent Files'
            ? SizedBox(
                child: GetBuilder<HomeScreenController>(builder: (controller) {
                  return ListView.builder(
                      itemCount: controller.recentFiles.length,
                      itemBuilder: ((context, index) {
                        var file = widget.files![index];
                        if (index <= 5) {
                          return FileCard(
                            index: index,
                            title: widget.title,
                            file: file.path,
                            isVisible: isSelected,
                            allChecked: false,
                          );
                        } else {
                          return Container();
                        }
                      }));
                }),
              )
            : widget.title == 'Favorites'
                ? SizedBox(
                    child:
                        GetBuilder<FavoritesController>(builder: (controller) {
                      return ListView.builder(
                          itemCount: controller.favoriteFiles.length,
                          itemBuilder: ((context, index) {
                            var file = widget.favoriteFiles![index];
                            if (searchFiles.isEmpty) {
                              return FileCard(
                                index: index,
                                title: widget.title,
                                file: file,
                                isVisible: isSelected,
                                allChecked: false,
                              );
                            } else if (file
                                .toLowerCase()
                                .trim()
                                .replaceAll(' ', '')
                                .contains(searchController.text)) {
                              return FileCard(
                                index: index,
                                title: widget.title,
                                file: file,
                                isVisible: isSelected,
                                allChecked: false,
                              );
                            } else {
                              return Container();
                            }
                          }));
                    }),
                  )
                : searchFiles.isNotEmpty
                    ? SizedBox(
                        height: double.infinity,
                        width: double.infinity,
                        child: GetBuilder<HomeScreenController>(
                            builder: (controller) {
                          return ListView.builder(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            itemCount: searchFiles.length,
                            itemBuilder: (context, index) {
                              var file = searchFiles.elementAt(index);
                              if (searchFiles.isEmpty) {
                                return Dismissible(
                                  onDismissed: (DismissDirection direction) {
                                    setState(() {
                                      searchFiles.removeAt(index);
                                    });
                                    HomePageUtils().deleteFile(
                                      File(file.path),
                                      context,
                                    );
                                    HomeScreenController.instance.update();
                                  },
                                  background: Container(
                                    color: Colors.green,
                                  ),
                                  key: ValueKey<FileSystemEntity>(
                                      searchFiles[index]),
                                  child: FileCard(
                                    files: searchFiles,
                                    index: index,
                                    title: widget.title,
                                    file: file.path,
                                    isVisible: isSelected,
                                    allChecked: false,
                                  ),
                                );
                              } else if (file.path
                                  .toLowerCase()
                                  .trim()
                                  .replaceAll(' ', '')
                                  .contains(searchController.text)) {
                                return Dismissible(
                                  onDismissed: (DismissDirection direction) {
                                    HomeScreenController.instance.directory
                                        .remove(file);
                                    setState(() {
                                      searchFiles.removeAt(index);
                                    });
                                    HomePageUtils().deleteFile(
                                      File(file.path),
                                      context,
                                    );
                                    HomeScreenController.instance.update();
                                  },
                                  background: Container(
                                    color: Colors.green,
                                    child: Icon(
                                      Icons.delete,
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                    ),
                                  ),
                                  key: ValueKey<FileSystemEntity>(
                                      searchFiles[index]),
                                  child: FileCard(
                                    files: searchFiles,
                                    index: index,
                                    title: widget.title,
                                    file: file.path,
                                    isVisible: isSelected,
                                    allChecked: false,
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            },
                          );
                        }))
                    : Center(
                        child: SizedBox(
                          child: Text(
                            'No Files to show',
                            style: TextStyle(
                                color: Theme.of(context).secondaryHeaderColor),
                          ),
                        ),
                      ),
      ),
    );
  }
}
