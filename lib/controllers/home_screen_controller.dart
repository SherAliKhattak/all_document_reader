// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:all_document_reader/utils/home_page_utils/home_page_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController implements GetxService {
  late TextEditingController renameController;
  List<FileSystemEntity> directory = [];
  Iterable<FileSystemEntity>? list;
  RxBool isLightTheme = false.obs;
  List<String> sharedFiles = [];
  List<FileSystemEntity> recentFiles = [];

  bool storageLoading = true;

  // ignore: non_constant_identifier_names
  List<FileSystemEntity> XshareFiles = [];

  static HomeScreenController get instance => Get.put(HomeScreenController());

  @override
  void onInit() {
    renameController = TextEditingController();
    super.onInit();
  }

  callFileFunctions(BuildContext context) async {
    await HomePageUtils().whatsappDirectory(context);
    await HomePageUtils().getAllFiles();
    await HomePageUtils().recentFiles();
    update();
  }
}
