import 'package:flutter/material.dart';
import 'package:qr_reader/widgets/formatted_text.dart';

class IconTextButton extends StatefulWidget {
  final onPressed;
  final String text;
  final Icon icon;
  final double minWidth;

  const IconTextButton({
    Key key,
    @required this.onPressed,
    @required this.text,
    @required this.icon,
    this.minWidth = 0,
  }) : super(key: key);

  @override
  _IconTextButtonState createState() => _IconTextButtonState();
}

class _IconTextButtonState extends State<IconTextButton> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: widget.onPressed,
      minWidth: widget.minWidth,
      child: Row(
        children: [
          widget.icon,
          SizedBox(
            width: 10,
          ),
          FormattedText(
            text: widget.text,
            fontSize: 20,
          ),
        ],
      ),
    );
  }
}
