import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_ui_kit/other/homeConstant.dart';
import '../model/lenhModel.dart';
import '../uikit.dart';

class Home extends StatefulWidget {

  @override
  HomeState createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  final List<lenhModel> lenhList = [
    lenhModel('08:00', '11/07/2022', '20B-00111(LVC-0000187/SPCT)',
        'Bến xe Thái Nguyên', 'Bến xe Việt Trì\n(1920.1111.A)', 1, false),
    lenhModel('08:00', '11/07/2022', '20B-00111(LVC-0000187/SPCT)',
        'Bến xe Thái Nguyên', 'Bến xe Việt Trì\n(1920.1111.A)', 1, false),
  ];
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
                      'Nguyễn Công Tuyến',
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
          lenhList.length != 0
              ? Expanded(
                  child: ListView.builder(
                      itemCount: lenhList.length,
                      itemBuilder: (context, index) {
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset('asset/icons/clock.svg',
                                          width: sizeListIcon, height: sizeListIcon),
                                      SizedBox(
                                        width: spaceBetween,
                                      ),
                                      Text(
                                        '${lenhList[index].time} ${lenhList[index].date}',
                                        style: TextStyle(
                                          fontWeight: fontStyleListItem,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Chờ bến đi ký',
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
                                    '${lenhList[index].sohieu}',
                                    style:
                                        TextStyle(fontWeight: fontStyleListItem),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: spaceListItem,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                      'asset/icons/buslocation.svg',
                                      width: sizeListIcon,
                                      height: sizeListIcon),
                                  SizedBox(
                                    width: spaceBetween,
                                  ),
                                  Text(
                                    '${lenhList[index].diemdi} - ${lenhList[index].diemden}',
                                    style:
                                        TextStyle(fontWeight: fontStyleListItem),
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
                                    '${lenhList[index].khach} khách',
                                    style:
                                        TextStyle(fontWeight: fontStyleListItem),
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
                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> UIKitPage(2)));

                                          },
                                          child: Text('XEM LỆNH'))))
                            ],
                          ),
                        );
                      }),
                )
              : Expanded(
                  child: Center(
                  child: Text(noDataText),
                ))
        ],
      ),
    ));
  }
}
