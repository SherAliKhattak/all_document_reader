import 'dart:developer';

import 'package:all_document_reader/controllers/favorites_controller.dart';
import 'package:all_document_reader/controllers/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  saveThemeStatus() async {
    var controller = HomeScreenController.instance;
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('theme', controller.isLightTheme.value);
  }

  getThemeStatus() async {
    var controller = HomeScreenController.instance;
    var isLight =
        SharedPreferences.getInstance().then((SharedPreferences prefs) async {
      return prefs.getBool('theme') ?? true;
    }).obs;
    controller.isLightTheme.value = await isLight.value;
    Get.changeThemeMode(
        controller.isLightTheme.value ? ThemeMode.dark : ThemeMode.light);
  }

  selectedLanguage(String? value) async {
    log(value.toString(), name: 'language');
  }

  Future<String?> getSelectedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getString('language') ?? 'English';
    return result;
  }

  saveFavoritesList(
    List<String> path,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setStringList('favorites', path);

    log('The list is saved');
  }

  getFavoritesList() async {
    var controller = FavoritesController.instance;
    SharedPreferences preferences = await SharedPreferences.getInstance();

    List<String> result = preferences.getStringList('favorites')!;

    controller.favoriteFiles.addAll(result);

    log('$result got the result');
  }

  setisOnboarding() async {
    int isviewed = 1;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt("initScreen", isviewed);
  }

  Future<int?> getIsOnboarding() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt('initScreen');
  }
}
