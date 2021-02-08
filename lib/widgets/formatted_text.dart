import 'package:flutter/material.dart';

class FormattedText extends StatelessWidget {
  final String text;
  final double fontSize;

  const FormattedText({
    Key key,
    @required this.text,
    @required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.black,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
