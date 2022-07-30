import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRpage extends StatefulWidget {
  const QRpage({Key key}) : super(key: key);

  @override
  State<QRpage> createState() => _QRpageState();
}

class _QRpageState extends State<QRpage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;
  void reassemble()async {
    super.reassemble();
    if (Platform.isAndroid) {
     await controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
          QRView(
            overlay: QrScannerOverlayShape(
              borderColor: Colors.white,
              borderRadius: 10,
              borderLength: 20,
              borderWidth: 10,
                cutOutSize: MediaQuery.of(context).size.width * 0.8),
                
            key: qrKey,
            onQRViewCreated: _onQRViewCreated),
            Positioned(
              bottom: 80,
              left: 150,
              child: Container(
                padding: EdgeInsets.all(3),
              color: Colors.grey,
              child: Center(child:result ==null? Text('Scan QR',style: TextStyle(fontSize: 18),):Text('${result.code}',style: TextStyle(fontSize: 18)),),))
        ],));
  }

  void _onQRViewCreated(QRViewController controller) {
   setState(() {
     this.controller = controller;
   }); 
   controller.scannedDataStream.listen((event) {
    setState(() {
      result = event;
    });
    });
   
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
