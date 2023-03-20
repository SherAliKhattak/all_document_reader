import 'package:all_document_reader/controllers/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListTypeCard extends StatelessWidget {
  final Function() onPressed;
  final String title;
  final String subtitle;
  final String image;
  const ListTypeCard(
      {Key? key,
      required this.onPressed,
      required this.title,
      required this.image,
      required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(5),
      elevation: 2,
      child: GestureDetector(
        onTap: onPressed,
        child: ListTile(
            tileColor: Theme.of(context).primaryColorDark,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            title: Text(
              title,
              style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
            ),
            subtitle: GetBuilder<HomeScreenController>(builder: (controller) {
              return Text(
                '$subtitle Files',
                style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
              );
            }),
            leading: Image.asset(
              image,
              height: 40,
              width: 40,
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: Theme.of(context).secondaryHeaderColor,
            )),
      ),
    );
  }
}
