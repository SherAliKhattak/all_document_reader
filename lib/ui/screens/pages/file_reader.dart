import 'package:flutter/material.dart';
import 'package:flutter_filereader/flutter_filereader.dart';
import 'package:get/get.dart';

class FileReader extends StatefulWidget {
  final String? path;
  const FileReader({super.key, this.path});

  @override
  State<FileReader> createState() => _FileReaderState();
}

class _FileReaderState extends State<FileReader> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColorDark,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back,
            color: Theme.of(context).secondaryHeaderColor,
          ),
        ),
        centerTitle: true,
        title: Text(
          widget.path!.split('/').last,
          style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
        ),
      ),
      body: FileReaderView(filePath: widget.path),
    );
  }
}
