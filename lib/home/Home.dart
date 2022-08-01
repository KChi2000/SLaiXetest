
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_ui_kit/QRScanner/QRpage.dart';
import 'package:flutter_ui_kit/helpers/ApiHelper.dart';
import 'package:flutter_ui_kit/helpers/LoginHelper.dart';
import 'package:flutter_ui_kit/other/homeConstant.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../model/KhachTrenXe.dart';
import '../model/LenhHienTai.dart';
import '../model/lenhModel.dart';
import '../uikit.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  
  var lenhHienTaiFuture;
  var khachTrenXeFuture;
  LenhHienTai lenhhientai;
  String checklenh= 'has data';
  var datetime;
  String timeXuatBen;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadLenhHienTai();
  }

  void loadLenhHienTai() async {
    lenhHienTaiFuture = ApiHelper.getLenhHienTai(
        'http://113.176.29.57:19666/api/Driver/lay-lenh-hien-tai-cua-lai-xe');
    lenhhientai = await lenhHienTaiFuture;

    if(lenhhientai.data.maLenh != null){
      convertDateTime();
    if (lenhhientai != null) {
      khachTrenXeFuture = ApiHelper.getKhachTrenXe(
          'http://113.176.29.57:19666/api/QuanLyThongTin/lay-thong-tin-chuyen-di-theo-lenh?idLenhDienTu=${lenhhientai.data.idLenh}');
    }
    }
    else{
      checklenh = 'no data';
    }
    setState(() {});
  }

  void convertDateTime() {
    print('timeee: ${lenhhientai.data.thoiGianXuatBenKeHoach}');

    datetime =
        DateTime.parse(lenhhientai.data.thoiGianXuatBenKeHoach).toLocal();
    timeXuatBen = DateFormat('kk:mm dd-MM-yyyy ').format(datetime);
    print('timeee: ${timeXuatBen}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: padding),
            height: MediaQuery.of(context).size.height * itemListHeight,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color.fromARGB(255, 175, 211, 241), Colors.blue],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(itemListRadius),
                    bottomRight: Radius.circular(itemListRadius))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      child: Image.asset(
                        'asset/images/logo.png',
                        width: sizeLogoImage,
                        height: sizeLogoImage,
                      ),
                      backgroundColor: Colors.white,
                      minRadius: 10,
                    ),
                    SizedBox(
                      width: spaceBetween,
                    ),
                    SizedBox(
                      width: 200,
                      child: Text(
                        '${LoginHelper.Default.userToken.given_name}',
                        style: TextStyle(
                            fontFamily: 'Roboto Italic',
                            // fontWeight: FontWeight.bold,
                            color: mainColor,
                            fontSize: 14),
                            maxLines: 2,
                      ),
                    ),
                  ],
                ),
                InkWell(
                  child: Ink(
                      width: ScannerQRSize,
                      height: ScannerQRSize,
                      // color: Colors.pink,
                      child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: SvgPicture.asset(
                            'asset/icons/scan.svg',
                            color: Colors.white,
                          ))),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> QRpage()));
                  },
                )
              ],
            ),
          ),
         checklenh != 'no data' ? FutureBuilder<KhachTrenXe>(
              future: khachTrenXeFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Expanded(
                    child: Center(
                      child: Text('Lỗi'),
                    ),
                  );
                } else if (snapshot.hasData) {
                  KhachTrenXe data = snapshot.data;
                  return Container(
                    margin: EdgeInsets.all(padding),
                    padding: EdgeInsets.all(padding),
                    decoration: BoxDecoration(
                        color: mainColor,
                        border: Border.all(
                          color: borderColor,
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: borderColor,
                              offset: Offset(offsetX, offsetY),
                              blurRadius: blurRadius,
                              spreadRadius: spreadRadius)
                        ]),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset('asset/icons/clock.svg',
                                    width: sizeListIcon, height: sizeListIcon),
                                SizedBox(
                                  width: spaceBetween,
                                ),
                                Text(
                                  '$timeXuatBen',
                                  style: TextStyle(
                                    fontFamily: 'Roboto Bold',
                                    fontSize: 14,
                                    
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '${lenhhientai.data.trangThai}',
                              style: TextStyle(
                                  fontFamily: 'Roboto Bold',
                                    fontSize: 14,
                                  color: statusText),
                            )
                          ],
                        ),
                        SizedBox(
                          height: spaceListItem,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset('asset/icons/sohieu.svg',
                                width: sizeListIcon, height: sizeListIcon),
                            SizedBox(
                              width: spaceBetween,
                            ),
                            Text(
                              '${lenhhientai.data.bienKiemSoat} (${lenhhientai.data.maLenh})',
                              style: TextStyle(fontFamily: 'Roboto Bold',
                                    fontSize: 14,),
                            )
                          ],
                        ),
                        SizedBox(
                          height: spaceListItem,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset('asset/icons/buslocation.svg',
                                width: sizeListIcon, height: sizeListIcon),
                            SizedBox(
                              width: spaceBetween,
                            ),
                            Text(
                              '${lenhhientai.data.tenTuyen}\n(${lenhhientai.data.maTuyen})',
                              style: TextStyle(
                                  fontFamily: 'Roboto Bold',
                                    fontSize: 14,),
                            )
                          ],
                        ),
                        SizedBox(
                          height: spaceListItem,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset('asset/icons/customer.svg',
                                width: sizeListIcon, height: sizeListIcon),
                            SizedBox(
                              width: spaceBetween,
                            ),
                            Text(
                              '${data.data.soKhachTrenXe} khách',
                              style: TextStyle(fontFamily: 'Roboto Bold',
                                    fontSize: 14,),
                            )
                          ],
                        ),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: SizedBox(
                                height: buttomHeight,
                                width: buttomWidth,
                                child: ElevatedButton(
                                    onPressed: () {
                                      // UIKitPage ui = new UIKitPage(2);
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UIKitPage(2)));
                                    },
                                    child: Text('XEM LỆNH',style: TextStyle(fontFamily: 'Roboto Medium',fontSize: 14,letterSpacing: 1.25),))))
                      ],
                    ),
                  );
                }
                return Expanded(
                  child: Center(
                    child: Text('Không có dữ liệu'),
                  ),
                );
              }): Expanded(child: Center(child: Text('Không có dữ liệu'),))
        ],
      ),
    )
    );
  }
}
