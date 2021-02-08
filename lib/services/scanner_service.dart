import 'package:barras/barras.dart';
import 'package:injectable/injectable.dart';
import 'package:qr_reader/interfaces/i_scanner_service.dart';

@Injectable(as: IScannerService)
class ScannerService implements IScannerService {
  Future<String> scan(context) async {
    String barcodeScanResult;

    try {
      barcodeScanResult = await Barras.scan(context);
    } on Exception catch (e) {
      print('Exception while scanning code: $e');
    }

    return barcodeScanResult;
  }
}
