import 'package:flutter/material.dart';

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
          Text(
            text,
            style: TextStyle(color: Colors.black, fontSize: 20),
          )
        ],
      ),
    );
  }
}
