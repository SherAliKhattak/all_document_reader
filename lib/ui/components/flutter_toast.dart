import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast({String? label, Color? backgroundColor, Color? textColor}) {
  Fluttertoast.showToast(
      msg: label!,
      textColor: textColor,
      gravity: ToastGravity.CENTER,
      backgroundColor: backgroundColor);
}

showdeleteToast({String? label, Color? backgroundColor, Color? textColor}) {
  Fluttertoast.showToast(
      msg: label!,
      textColor: textColor,
      backgroundColor: backgroundColor,
      gravity: ToastGravity.CENTER);
}
