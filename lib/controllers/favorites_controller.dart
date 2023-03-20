import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ui/components/flutter_toast.dart';

class FavoritesController extends GetxController implements GetxService {
  final favoriteFiles = <String>[].obs;

  void removefromFavorites(String? path) {
    showToast(label: 'File removed Favorites', backgroundColor: Colors.red);
    // ignore: list_remove_unrelated_type
    favoriteFiles.remove(path);
    update();
  }

  void addToFavorites(String? path) {
    favoriteFiles.add(path!);
    showToast(label: 'File Added to Favorites', backgroundColor: Colors.green);
    update();
  }

  int updateLengthofList() {
    int len = favoriteFiles.length;
    update();
    log(len.toString());
    return len;
  }

  static FavoritesController get instance => Get.put(FavoritesController());
}
