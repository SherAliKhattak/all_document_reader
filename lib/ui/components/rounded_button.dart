import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color color;
  final Color textcolor;
  final String title;
  final VoidCallback onPressed;
  const RoundedButton(
      {Key? key,
      required this.title,
      required this.onPressed,
      required this.color,
      required this.textcolor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(30)),
          child: Center(
            child: Text(
              title,
              style: TextStyle(fontSize: 20, color: textcolor),
              textAlign: TextAlign.center,
            ),
          )),
    );
  }
}
