import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:barras/barras.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:qr_reader/widgets/formatted_text.dart';
import 'package:qr_reader/widgets/icon_text_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:validated/validated.dart' as validate;

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'QR Reader',
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.wb_incandescent),
            onPressed: () {
              AdaptiveTheme.of(context).toggleThemeMode();
            },
          ),
          IconTextButton(
            onPressed: _scanCode,
            text: 'Scan',
            icon: Icon(
              Icons.qr_code_scanner,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (_barcodeScanResult != '')
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Card(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: FormattedText(
                              text: 'Scan Result:',
                              fontSize: 25,
                            ),
                          ),
                          Spacer(),
                          IconTextButton(
                            onPressed: _copyToClipboard,
                            text: 'Copy',
                            icon: Icon(
                              Icons.copy,
                            ),
                          ),
                          if (validate.isURL(_barcodeScanResult))
                            IconTextButton(
                              onPressed: _launchURL,
                              text: 'Open',
                              icon: Icon(
                                Icons.open_in_browser,
                              ),
                            )
                          else
                            SizedBox(),
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: FormattedText(
                                text: _barcodeScanResult,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            else
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconTextButton(
                    onPressed: _scanCode,
                    text: 'Scan QR code',
                    icon: Icon(
                      Icons.qr_code_scanner,
                    ),
                    minWidth: double.infinity,
                    isCentered: true,
                  )),
          ],
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ),
    );
  }

  Future<void> _launchURL() async {
    String url = _barcodeScanResult;
    try {
      if (await canLaunch(url)) {
        await launch(url);
      }
    } on Exception catch (e) {
      print('Exception while opening browser: $e');
    }
  }

  String _barcodeScanResult = '';

  Future<void> _scanCode() async {
    String barcodeScanResult = '';
    try {
      barcodeScanResult = await Barras.scan(context);
    } on Exception catch (e) {
      print('Exception while scanning code: $e');
    }

    if (barcodeScanResult == null) barcodeScanResult = '';

    setState(() {
      _barcodeScanResult = barcodeScanResult;
    });
  }

  void _copyToClipboard() {
    Clipboard.setData(
      new ClipboardData(text: _barcodeScanResult),
    );
    showToast(
      'Copied!',
      context: context,
      textStyle: TextStyle(
        fontSize: 21,
        color:
            AdaptiveTheme.of(context).isDefault ? Colors.white : Colors.black,
      ),
      backgroundColor:
          AdaptiveTheme.of(context).isDefault ? Colors.black54 : Colors.white,
      borderRadius: BorderRadius.circular(20),
    );
  }
}
