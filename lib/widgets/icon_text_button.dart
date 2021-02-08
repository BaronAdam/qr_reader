import 'package:flutter/material.dart';
import 'package:qr_reader/widgets/formatted_text.dart';

class IconTextButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: null,
      minWidth: minWidth,
      child: Row(
        children: [
          icon,
          SizedBox(
            width: 10,
          ),
          FormattedText(
            text: text,
            fontSize: 20,
          ),
        ],
      ),
    );
  }
}
