import 'package:barras/barras.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
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
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        actions: [
          FlatButton(
            onPressed: _scanCode,
            child: Row(
              children: [
                Icon(
                  Icons.camera_alt,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Scan',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                )
              ],
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (_barcodeScanResult != '')
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Scan Result:',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Spacer(),
                          FlatButton(
                            onPressed: _copyToClipboard,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.copy,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Copy',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          if (validate.isURL(_barcodeScanResult))
                            FlatButton(
                              onPressed: _launchURL,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.open_in_browser,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Open',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                ],
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
                              child: Text(
                                _barcodeScanResult,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
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
                child: FlatButton(
                  minWidth: double.infinity,
                  onPressed: _scanCode,
                  child: Row(
                    children: [
                      Icon(
                        Icons.camera_alt,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Scan QR Code',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),
              ),
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
        color: Colors.black,
      ),
      backgroundColor: Colors.black12,
      borderRadius: BorderRadius.circular(20),
    );
  }
}
