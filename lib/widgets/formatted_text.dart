import 'package:flutter/material.dart';

class FormattedText extends StatefulWidget {
  final String text;
  final double fontSize;

  const FormattedText({
    Key key,
    @required this.text,
    @required this.fontSize,
  }) : super(key: key);

  @override
  _FormattedTextState createState() => _FormattedTextState();
}

class _FormattedTextState extends State<FormattedText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: TextStyle(
        color: Colors.black,
        fontSize: widget.fontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
