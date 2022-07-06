import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_ui_kit/helpers/ApiHelper.dart';
import 'package:flutter_ui_kit/helpers/LoginHelper.dart';
import 'package:flutter_ui_kit/other/homeConstant.dart';
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
        'http://lenh.nguyencongtuyen.local:19666/api/Driver/lay-lenh-hien-tai-cua-lai-xe');
    lenhhientai = await lenhHienTaiFuture;

    convertDateTime();
    if (lenhhientai != null) {
      khachTrenXeFuture = ApiHelper.getKhachTrenXe(
          'http://vedientu.nguyencongtuyen.local:19666/api/QuanLyThongTin/lay-thong-tin-chuyen-di-theo-lenh?idLenhDienTu=${lenhhientai.data.idLenh}');
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
                    Text(
                      '${LoginHelper.Default.userToken.given_name}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: mainColor,
                          fontSize: fontSize),
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
                    print('inkwell');
                  },
                )
              ],
            ),
          ),
          FutureBuilder<KhachTrenXe>(
              future: khachTrenXeFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
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
                                    fontWeight: fontStyleListItem,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '${lenhhientai.data.trangThai}',
                              style: TextStyle(
                                  fontWeight: fontStyleListStatus,
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
                              style: TextStyle(fontWeight: fontStyleListItem),
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
                                  fontWeight: fontStyleListItem, fontSize: 14),
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
                              style: TextStyle(fontWeight: fontStyleListItem),
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
                                    child: Text('XEM LỆNH'))))
                      ],
                    ),
                  );
                }
                return Expanded(
                  child: Center(
                    child: Text('Không có dữ liệu'),
                  ),
                );
              })
        ],
      ),
    ));
  }
}
