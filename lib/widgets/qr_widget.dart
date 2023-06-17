import 'package:flutter/cupertino.dart';
import 'package:qr_flutter/qr_flutter.dart';

Widget generateQRCode(String data) {
  return QrImage(
    data: data,
    version: QrVersions.auto,
    size: 200.0,
  );
}
