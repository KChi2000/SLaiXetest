import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_ui_kit/helpers/ApiHelper.dart';
import 'package:flutter_ui_kit/servicesAPI.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import '../other/homeConstant.dart';
import 'package:http/http.dart' as http;

class AnhLenh extends StatefulWidget {
  String guidlenh;
  AnhLenh(this.guidlenh);

  @override
  State<AnhLenh> createState() => _AnhLenhState();
}

class _AnhLenhState extends State<AnhLenh> {
  var picLenhFuture;
  String urlPDFPath;
  var runFututre;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.guidlenh);
   runFututre= loadPic();
  }

  Future<File> getFileFromUrl(String url, {name}) async {
    var fileName = 'testonline';
    if (name != null) {
      fileName = name;
    }
    try {
      var data = await http.get(Uri.parse(url));
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/" + fileName + ".pdf");
      print('frqewr ${dir.path}');
      File urlFile = await file.writeAsBytes(bytes);
      print('done');
      return urlFile;
    } catch (e) {
      throw Exception("Error opening url file");
    }
  }

  Future loadPic() async {
    try {
      picLenhFuture = await ApiHelper.get(servicesAPI.API_LenhDienTu +
          'lay-link-xem-ban-the-hien-lenh?GuidLenh=${widget.guidlenh}');
      if(picLenhFuture['data']!=null){
          getFileFromUrl(picLenhFuture['data']).then((value) {
          
            setState(() {
              urlPDFPath = value.path;
            });
          
        });
      }else{
        print('failed');
      }
    } catch (ex) {
      // setState(() {
      //   picLenh['status'] = false;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: FutureBuilder(
              future: runFututre,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    color: Colors.black,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: SvgPicture.asset(
                                'asset/icons/close.svg',
                                color: appbarIconColor,
                                width: appbarIconSize,
                                height: appbarIconSize,
                              ),
                            ),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: Image.asset(
                                  'asset/images/pagernotFound.png',
                                  fit: BoxFit.contain))
                        ]),
                  );
                }  else if (urlPDFPath != null) {
                  // Map<String, dynamic> picLenh = snapshot.data;
                  // var imageUrl = picLenh['data'];
                  print('has data');
                  return Container(
                    color: Colors.black,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: SvgPicture.asset(
                            'asset/icons/close.svg',
                            color: appbarIconColor,
                            width: appbarIconSize,
                            height: appbarIconSize,
                          ),
                        ),
                      ),
                      SizedBox(height: 60,),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: PDFView(
                              filePath: urlPDFPath,
                              swipeHorizontal: false,
                              autoSpacing: true,
                              pageFling: false))
                    ]),
                  );
                }
               return Container(
                    color: Colors.black,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: SvgPicture.asset(
                                'asset/icons/close.svg',
                                color: appbarIconColor,
                                width: appbarIconSize,
                                height: appbarIconSize,
                              ),
                            ),
                          ),
                          SizedBox(height: 60,),
                          Container(
                              width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.6,
                              child: Image.asset(
                                  'asset/images/pagernotFound.png',
                                  fit: BoxFit.cover))
                        ]),
                  );
              })),
    );
  }
}
