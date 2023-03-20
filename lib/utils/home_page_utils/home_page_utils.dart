// ignore_for_file: deprecated_member_use

import 'dart:developer' as string;
import 'dart:core';
import 'dart:io';
import 'package:all_document_reader/ui/components/flutter_toast.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controllers/home_screen_controller.dart';

class HomePageUtils {
  var controller = HomeScreenController.instance;

  static String formatTime(String iso) {
    DateTime date = DateTime.parse(iso);
    DateTime now = DateTime.now();
    DateTime yDay = DateTime.now().subtract(const Duration(days: 1));
    DateTime dateFormat = DateTime.parse(
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}T00:00:00.000Z');
    DateTime today = DateTime.parse(
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}T00:00:00.000Z');
    DateTime yesterday = DateTime.parse(
        '${yDay.year}-${yDay.month.toString().padLeft(2, '0')}-${yDay.day.toString().padLeft(2, '0')}T00:00:00.000Z');

    if (dateFormat == today) {
      return 'Today ${DateFormat('HH:mm').format(DateTime.parse(iso))}';
    } else if (dateFormat == yesterday) {
      return 'Yesterday ${DateFormat('HH:mm').format(DateTime.parse(iso))}';
    } else {
      return DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(iso));
    }
  }

  static String getFileSize(File file) {
    int sizeInBytes = file.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    double kb = sizeInMb * 1024;
    return kb.toStringAsFixed(2);
  }

  whatsappDirectory(
    context,
  ) async {
    Fluttertoast.showToast(
        msg: 'Fetching Files ',
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        textColor: Theme.of(context).primaryColorDark);
    Directory whatsApp =
        Directory('/storage/emulated/0/Android/media/com.whatsapp/');

    var dir = whatsApp.listSync(recursive: true).whereType<File>().where(
        (element) =>
            element.path.split('/').last.endsWith('.pdf') ||
            element.path.split('/').last.endsWith('.docx') ||
            element.path.split('/').last.endsWith('.pptx') ||
            element.path.split('/').last.endsWith('.txt') ||
            element.path.split('/').last.endsWith('.xls'));

    controller.directory.addAll(dir);

    Fluttertoast.showToast(
      msg: 'Fetching Files Complete',
      toastLength: Toast.LENGTH_LONG,
    );
  }

  // for filtering Android directory
  Directory removeDataDirectory(String path) {
    return Directory(path.split('Android')[0]);
  }

  Future<List<Directory>> getStorageList() async {
    List<Directory> paths = (await getExternalStorageDirectories())!;
    List<Directory> filteredPaths = <Directory>[];
    for (Directory dir in paths) {
      filteredPaths.add(removeDataDirectory(dir.path));
    }
    return filteredPaths;
  }

  Future<List<FileSystemEntity>> getFilesInPath(String path) async {
    Directory dir = Directory(path);
    return dir
        .listSync(recursive: true)
        .where((element) =>
            element.path.endsWith('.pdf') ||
            element.path.endsWith('.xls') ||
            element.path.endsWith('.txt') ||
            element.path.endsWith('.docx') ||
            element.path.endsWith('.pptx'))
        .toList();
  }

  Future<List<FileSystemEntity>> getAllFilesInPath(
    String path,
  ) async {
    List<FileSystemEntity> files = <FileSystemEntity>[];
    Directory d = Directory(path);

    List<FileSystemEntity> l = d.listSync();
    for (FileSystemEntity file in l) {
      if (FileSystemEntity.isFileSync(file.path) ||
          file.path.split('/').last.endsWith('.pdf') ||
          file.path.split('/').last.endsWith('.docx') ||
          file.path.split('/').last.endsWith('.txt') ||
          file.path.split('/').last.endsWith('.pptx') ||
          file.path.split('/').last.endsWith('.xls')) {
        files.add(file);
      } else {
        if (!file.path.contains('/storage/emulated/0/Android')) {
          files.addAll(await getAllFilesInPath(
            file.path,
          ));
        }
      }
    }

    string.log(files.toString());
    return files;
  }

  Future<List<FileSystemEntity>> getAllFiles() async {
    List<Directory> storages = await getStorageList();
    List<FileSystemEntity> files = <FileSystemEntity>[];
    for (Directory dir in storages) {
      List<FileSystemEntity> allFilesInPath = [];
      try {
        allFilesInPath = await getAllFilesInPath(dir.path);
      } catch (e) {
        allFilesInPath = [];
        (e.toString());
      }
      files = allFilesInPath
          .where((element) =>
              element.path.endsWith('.pdf') ||
              element.path.endsWith('.docx') ||
              element.path.endsWith('.pptx') ||
              element.path.endsWith('.txt') ||
              element.path.endsWith('.xls'))
          .toList();

      controller.directory.addAll(files);
      string.log(controller.directory.length.toString());
    }
    return files;
  }

  recentFiles() async {
    showToast(label: 'getting recent files');
    var controller = HomeScreenController.instance;
    List<FileSystemEntity> recent = controller.directory;
    recent.sort((a, b) => File(a.path)
        .lastAccessedSync()
        .compareTo(File(b.path).lastAccessedSync()));
    var result = recent.reversed.toList();
    controller.recentFiles.addAll(result);
    string.log('recent files received');
  }

  sortList(List<FileSystemEntity> list, int sort) {
    switch (sort) {
      case 0:
        list.sort((FileSystemEntity f1, FileSystemEntity f2) => File(f2.path)
            .lastModifiedSync()
            .compareTo(File(f1.path).lastModifiedSync()));
        break;
      case 1:
        list.sort((FileSystemEntity f1, FileSystemEntity f2) => File(f1.path)
            .toString()
            .toLowerCase()
            .compareTo(File(f2.path).toString().toLowerCase()));
        break;
      case 2:
        list.sort((FileSystemEntity f1, FileSystemEntity f2) => File(f1.path)
            .statSync()
            .size
            .compareTo(File(f2.path).statSync().size));
        break;
      case 3:
        list.sort((FileSystemEntity f1, FileSystemEntity f2) => File(f2.path)
            .lastAccessedSync()
            .compareTo(File(f1.path).lastAccessedSync()));
        break;
      case 4:
        list.sort((FileSystemEntity f1, FileSystemEntity f2) => File(f1.path)
            .lastAccessedSync()
            .compareTo(File(f2.path).lastAccessedSync()));
        break;
      default:
        list;
    }
    return list;
  }

  deleteFile(
    File filename,
    context,
  ) async {
    try {
      if (await filename.exists()) {
        filename.delete();
        showToast(
            label: 'File deleted Successfully', backgroundColor: Colors.black);
        HomeScreenController.instance.update();
      }
    } catch (e) {
      e.toString();
    }
  }

  static shareFile({required String? fileName}) async {
    try {
      Share.shareXFiles([XFile(fileName!)], text: fileName.split('/').last);
    } catch (e) {
      return e.toString();
    }
  }

  static deleteMultipleFiles() {
    var controller = HomeScreenController.instance;
    try {
      for (var i in controller.XshareFiles) {
        i.delete();
        controller.directory.remove(i);
      }
    } on FileSystemException catch (error) {
      showToast(label: error.toString(), backgroundColor: Colors.red);
    } catch (e) {
      showToast(
        label: 'Error occured',
        backgroundColor: Colors.black,
      );
    }
  }

  launchUrlbrowser() async {
    var url = Uri.parse(
        'https://docs.google.com/document/d/1yk-7r6Z3yY7jERdsM6dv3mG76xiaX27HFCJR2-7Lf0Q/edit?usp=sharing');

    if (await canLaunchUrl(
      url,
    )) {
      await launchUrl(
        url,
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
