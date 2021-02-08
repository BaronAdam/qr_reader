import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:qr_reader/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(QrReader(savedThemeMode: savedThemeMode));
}

class QrReader extends StatelessWidget {
  final savedThemeMode;

  const QrReader({Key key, this.savedThemeMode}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        primaryColorDark: Colors.white,
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        accentColor: Colors.amber,
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        primaryColorDark: Colors.black,
        backgroundColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        cardColor: Colors.black,
        shadowColor: Colors.white70,
        accentColor: Colors.amber,
      ),
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      builder: (theme, themeDark) => MaterialApp(
        theme: theme,
        darkTheme: themeDark,
        home: MainScreen(),
      ),
    );
  }
}
