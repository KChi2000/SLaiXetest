import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_ui_kit/details/cookinfo.dart';

import '../browsing/browsing.dart';
import '../filters/filters.dart';
import '../model/lenhModel.dart';
import '../uikit.dart';

class TodayStoryTabPage extends StatefulWidget {

  @override
  TodayStoryTabPageState createState() {
    return TodayStoryTabPageState();
  }
}

class TodayStoryTabPageState extends State<TodayStoryTabPage> {
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
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: MediaQuery.of(context).size.height * 0.2,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color.fromARGB(255, 175, 211, 241), Colors.blue],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      child: Image.asset(
                        'asset/images/logo.png',
                        width: 45,
                        height: 45,
                      ),
                      backgroundColor: Colors.white,
                      minRadius: 10,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Nguyễn Công Tuyến',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18),
                    ),
                  ],
                ),
                InkWell(
                  child: Ink(
                      width: 40,
                      height: 40,
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
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.grey[400].withOpacity(0.7),
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[400].withOpacity(0.7),
                                    offset: Offset(5, 5),
                                    blurRadius: 3,
                                    spreadRadius: 0.6)
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
                                          width: 18, height: 18),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '${lenhList[index].time} ${lenhList[index].date}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Chờ bến đi ký',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset('asset/icons/sohieu.svg',
                                      width: 18, height: 18),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '${lenhList[index].sohieu}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                      'asset/icons/buslocation.svg',
                                      width: 19,
                                      height: 19),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '${lenhList[index].diemdi} - ${lenhList[index].diemden}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset('asset/icons/customer.svg',
                                      width: 18, height: 18),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '${lenhList[index].khach} khách',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Align(
                                  alignment: Alignment.bottomRight,
                                  child: SizedBox(
                                      height: 35,
                                      width: 150,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>UIKitPage(2)));

                                          },
                                          child: Text('XEM LỆNH'))))
                            ],
                          ),
                        );
                      }),
                )
              : Expanded(
                  child: Center(
                  child: Text('Không có dữ liệu !'),
                ))
        ],
      ),
    ));
  }
}
