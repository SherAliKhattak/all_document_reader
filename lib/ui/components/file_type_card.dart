import 'package:all_document_reader/controllers/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FileTypeCard extends StatelessWidget {
  final String? subtitle;
  final VoidCallback onPressed;
  final String title;
  final String image;
  const FileTypeCard(
      {Key? key,
      required this.title,
      required this.image,
      required this.onPressed,
      required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(5),
      elevation: 2,
      child: ListTile(
        textColor: Theme.of(context).secondaryHeaderColor,
        onTap: onPressed,
        tileColor: Theme.of(context).primaryColorDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        title: Text(title),
        subtitle: GetBuilder<HomeScreenController>(builder: (controller) {
          return Text(subtitle!);
        }),
        trailing: RotationTransition(
          turns: const AlwaysStoppedAnimation(30 / 360),
          child: Image.asset(
            image,
            height: 40,
            width: 40,
          ),
        ),
      ),
    );
  }
}
