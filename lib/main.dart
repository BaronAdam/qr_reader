import 'package:flutter/material.dart';
import 'package:qr_reader/screens/main_screen.dart';

void main() {
  runApp(QrReader());
}

class QrReader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }
}
