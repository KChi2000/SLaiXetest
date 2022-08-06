import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../other/homeConstant.dart';

class QRpage extends StatefulWidget {
  const QRpage({Key key}) : super(key: key);

  @override
  State<QRpage> createState() => _QRpageState();
}

class _QRpageState extends State<QRpage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: Container(
              width: screen.width,
              height: screen.height,
              child: Stack(
                children: [
                  QRView(
                      overlay: QrScannerOverlayShape(
                          borderColor: Colors.white,
                          borderRadius: 10,
                          borderLength: 20,
                          borderWidth: 10,
                          cutOutSize: MediaQuery.of(context).size.width * 0.8),
                      key: qrKey,
                      //type 2
                      onQRViewCreated: (QRViewController controller) {
                       
                          this.controller = controller;
                        
                        controller.scannedDataStream.listen((event) {
                          if(mounted){
                            controller.dispose();
                            Navigator.pop(context,event);
                          }
                        });
                      }),
                  Positioned(
                      child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: SvgPicture.asset(
                      'asset/icons/close.svg',
                      color: Colors.white,
                      width: appbarIconSize,
                      height: appbarIconSize,
                    ),
                  )),
                ],
              ))),
    );
  }

// like this type 1
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
// Column(
//                 children: [
//                   Align(
//                       alignment: Alignment.topLeft,
//                       child: IconButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         icon: SvgPicture.asset(
//                           'asset/icons/close.svg',
//                           color: Colors.black,
//                           width: appbarIconSize,
//                           height: appbarIconSize,
//                         ),
//                       )),
//                   SizedBox(
//                     height: 0,
//                   ),
//                   Container(
//                     height: screen.height*0.85,
//                     width: screen.width,
//                     child: QRView(
//                         overlay: QrScannerOverlayShape(
//                             borderColor: Colors.white,
//                             borderRadius: 10,
//                             borderLength: 20,
//                             borderWidth: 10,
//                             cutOutSize: MediaQuery.of(context).size.width * 0.8),
//                         key: qrKey,
//                         onQRViewCreated: _onQRViewCreated),
//                   ),
//                 ],
//               )