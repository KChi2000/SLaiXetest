import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_ui_kit/model/tang.dart';
import 'package:flutter_ui_kit/model/tangJson.dart';
import 'package:flutter_ui_kit/other/homeConstant.dart';
import 'package:flutter_ui_kit/ve/banve.dart';
import 'package:flutter_ui_kit/ve/banveghephu.dart';
import 'package:image_picker/image_picker.dart';
import '../model/chuyendiList.dart';
import '../model/sodocho.dart';
import '../model/sodochoJson.dart';

final moveList = [
  chuyendiList('HNA.22.05.001', '8.00'),
  chuyendiList('HNA.22.05.002', '9.00'),
  chuyendiList('HNA.22.05.003', '10.00'),
  chuyendiList('HNA.22.05.004', '11.00'),
  chuyendiList('HNA.22.05.005', '12.00'),
  chuyendiList('HNA.22.05.006', '13.00'),
  chuyendiList('HNA.22.05.007', '14.00'),
  chuyendiList('HNA.22.05.007', '14.00'),
  chuyendiList('HNA.22.05.007', '14.00'),
];
List<String> trangthai = ['Còn trống', 'Có khách'];

class Ve extends StatefulWidget {
  @override
  VeState createState() {
    return VeState();
  }
}

class VeState extends State<Ve> {
  var _articleTitle = ['Knife Skills', 'Everyday basics', 'Some beautiful'];
  double spacebetween = 20;
  double spaceRow = 20;
  double marginRowLeft = 15;
  bool flag = false;
  int choose = 0;
  bool seat = false;
  bool activefab = false;
  String title = moveList.first.name;
  List<sodocho> sodoList = [];
  List<tang> tangList = [tang.fromJson(tangJson)];
  int pos;
  List<sodocho> temp = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    sodo.forEach((element) {
      sodoList.add(sodocho.fromJson(element));
      // print(sodoList.first.tenCho);
    });
    test();
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(builder: (context, setState) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                            vertical: paddingVertical, horizontal: paddingHori),
                        height: bottomSheetHeight,
                        child: Column(
                          children: [
                            Text(titleBottomSheet,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: fontStyle,
                                    fontSize: fontSize)),
                            SizedBox(
                              height: spaceBetween,
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        choose = index;
                                        title = moveList[index].name;
                                        print(title);
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Container(
                                        height: 45,
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              iconBottomSheet,
                                              color: choose == index
                                                  ? selectedColor
                                                  : unselectedColor,
                                              width: iconSizeBottomSheet,
                                              height: iconSizeBottomSheet,
                                            ),
                                            Text(
                                              ' ${moveList[index].name}',
                                              style: TextStyle(
                                                  color: choose == index
                                                      ? selectedColor
                                                      : unselectedColor),
                                            ),
                                            Text(' | ',
                                                style: TextStyle(
                                                    color: choose == index
                                                        ? selectedColor
                                                        : unselectedColor)),
                                            Text('${moveList[index].time}',
                                                style: TextStyle(
                                                    color: choose == index
                                                        ? selectedColor
                                                        : unselectedColor))
                                          ],
                                        )),
                                  );
                                },
                                itemCount: moveList.length,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                              ),
                            )
                          ],
                        ),
                      );
                    });
                  });
            },
            child: Row(
              children: [
                Text(
                  "PTH.22.06.0009",
                  style: TextStyle(
                    color: appBartextColor,
                    fontWeight: fontStyleappBar,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Icon(
                        arrowDown,
                        size: arrowDownSize,
                        color: arrowDownColor,
                      ),
                    ))
              ],
            ),
          ),
          backgroundColor: Colors.blue,
          elevation: 0,
          actions: <Widget>[
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.qr_code_scanner_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
                GestureDetector(
                    child: Container(
                      margin: EdgeInsets.only(right: 5),
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black54),
                      child: Center(
                          child: Text(
                        '0',
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 30),
                                height: 250,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    itemBottomSheet(
                                        Colors.green, 'Đang thanh toán: ', '0'),
                                    itemBottomSheet(
                                        Colors.amber[800], 'Đã đặt chỗ: ', '0'),
                                    itemBottomSheet(
                                        Colors.blue, 'Có người ngồi: ', '0'),
                                    itemBottomSheet(
                                        Colors.grey[700], 'Đã mua vé: ', '0'),
                                  ],
                                ));
                          });
                    })
              ],
            )
          ],
          actionsIconTheme: IconThemeData(
            color: Colors.grey,
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Text('Sơ đồ chỗ xe khách',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18)),
              Expanded(
                  child: Column(
                children: [
                  Row(
                    children: [Text('aaa')],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 50,
                            width: 6,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8))),
                          ),
                          SizedBox(
                            height: 230,
                          ),
                          Container(
                            height: 50,
                            width: 6,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8))),
                          ),
                        ],
                      ),
                      Container(
                        width: widthScreen - 35,
                        height: heightScreen * 0.65,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.grey[400], width: 3.5),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 2,
                            ),
                            Container(
                              width: widthScreen - 35 - 20,
                              height: 20,
                              decoration: BoxDecoration(
                                  color: Colors.grey[350],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    height: 15,
                                    width: 15,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                      height: 15,
                                      width: 20,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10)))),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    height: 15,
                                    width: 15,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                      height: 13,
                                      width: 20,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                            ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            Container(
                              width: widthScreen - 35 - 20 - 20,
                              height: heightScreen * 0.65 - 50,
                              color: Colors.white,
                              child: GridView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 5),
                                  itemBuilder: (context, index) {
                                    // print('jdskfj: ${temp[index].tenCho}');

                                    print('index: $index');
                                    print('${temp.length}');
                                    return abc(index)[index];
                                    // test();
                                    // return seatItem(temp[index].tenCho);
                                  },
                                  itemCount: abc(0).length),
                            )
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            height: 50,
                            width: 6,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8))),
                          ),
                          SizedBox(
                            height: 230,
                          ),
                          Container(
                            height: 50,
                            width: 6,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8))),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ))
            ],
          ),
        ),
        floatingActionButton: SpeedDial(
          overlayColor: Colors.grey,
          backgroundColor: activeColor,
          activeBackgroundColor: inactiveColor,
          activeIcon: activeIcon,
          animationAngle: 3.14 / 2,
          buttonSize: activefab
              ? Size(activeButtonSize, activeButtonSize)
              : Size(inactiveButtonSize, inactiveButtonSize),
          icon: inactiveIcon,
          onOpen: () {
            setState(() {
              activefab = true;
            });
          },
          onClose: () {
            setState(() {
              activefab = false;
            });
          },
          children: [
            SpeedDialChild(
                backgroundColor: chuyendoilenhButtonColor,
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => banveghephu()));
                },
                label: 'Bán vé ghế phụ',
                child: SvgPicture.asset(
                  'asset/icons/ticket.svg',
                  width: 20,
                  height: 20,
                )),
            SpeedDialChild(
                // backgroundColor: Colors.red,
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          padding: EdgeInsets.all(15),
                          height: 250,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text('Hủy',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 15)),
                                ),
                              ),
                              Text('Khách mua vé ghế phụ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                              Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(children: [
                                        Text('Số điện thoại: ',
                                            style: TextStyle(fontSize: 13)),
                                        Text('0595757463',
                                            style: TextStyle(fontSize: 16)),
                                      ]),
                                      Row(children: [
                                        Text('Giá vé: ',
                                            style: TextStyle(fontSize: 13)),
                                        Text('15000đ',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.red)),
                                      ]),
                                      Row(children: [
                                        Text('Điểm xuống: ',
                                            style: TextStyle(fontSize: 13)),
                                        Text('Yên Nghĩa',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.orange)),
                                      ]),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 40,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.print),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      SvgPicture.asset(
                                        'asset/icons/arrowdown.svg',
                                        width: 20,
                                        height: 20,
                                      )
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 40,
                              ),
                            ],
                          ),
                        );
                      });
                  print('dung hanh trinh');
                },
                label: 'Khách ngồi ghế phụ',
                child: Icon(Icons.chair_alt, color: Colors.black))
          ],
        ));
  }

  Column seatItem(String num, int ind, int cot, int hang) {
    return Column(children: [
      SizedBox(
        height: 15,
      ),
      Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 7,
              ),
              Container(
                height: 32,
                width: 45,
                decoration: BoxDecoration(
                  color: Colors.grey[350],
                ),
              ),
            ],
          ),
          Positioned(
              left: 3,
              child: Stack(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        var index = sodoList.indexWhere((element) =>
                            element.viTriCot == cot &&
                            element.viTriHang == hang);
                        // pos = index;
                        // print('index: $index');
                        //  print('poss: $pos');
                        // if (sodoList[index].trangThai.tenTrangThai ==
                        //     'Có khách') {
                        //   sodoList[index].trangThai.tenTrangThai = 'Còn trống';
                        // } else {
                        //   sodoList[index].trangThai.tenTrangThai = 'Có khách';
                        // }
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => banve()));
                      });
                    },
                    child: seat
                        ? Container(
                            height: 35,
                            width: 39,
                            decoration: BoxDecoration(
                                color: Colors.blue[600],
                                // border: Border.all(color: Colors.grey[350]),
                                borderRadius: BorderRadius.circular(4)),
                            child: Center(
                                child: SvgPicture.asset(
                              'asset/icons/account-check.svg',
                              color: Colors.white,
                            )),
                          )
                        : Container(
                            height: 35,
                            width: 39,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey[350]),
                                borderRadius: BorderRadius.circular(4)),
                            child: Center(child: Text(num)),
                          ),
                  ),
                  Positioned(
                      top: 30,
                      left: 7,
                      child: Container(
                        height: 5,
                        width: 24,
                        decoration: BoxDecoration(
                            color: Colors.grey[350],
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(3),
                                topRight: Radius.circular(3))),
                      )),
                ],
              )),
        ],
      ),
    ]);
  }

  List<Widget> abc(int index) {
    print(tangList.first.soHang);
    print(tangList.first.soCot);
    List<Widget> list = [];

    for (int vtH = 1; vtH <= tangList.first.soHang; vtH++) {
      for (int vtC = 1; vtC <= tangList.first.soCot; vtC++) {
        var tmp =
            sodoList.where((vt) => vt.viTriHang == vtH && vt.viTriCot == vtC);
        if (tmp.length >= 1) {
          if (tmp.first.viTriCot == 1 && tmp.first.viTriHang == 1) {
            list.add(seatItemLX('${tmp.first.tenCho}'));
          } else {
            list.add(seatItem('${tmp.first.tenCho}', index, vtC, vtH));
          }
        } else {
          list.add(Text(''));
        }
      }
    }

    print('abc.list.length = ${list.length}');
    return list;
  }

  void test() {
    for (int vtH = 1; vtH <= tangList.first.soHang; vtH++) {
      for (int vtC = 1; vtC <= tangList.first.soCot; vtC++) {
        var tmp =
            sodoList.where((vt) => vt.viTriHang == vtH && vt.viTriCot == vtC);
        if (tmp.length >= 1) {
          if (tmp.first.viTriCot == 1 && tmp.first.viTriHang == 1) {
            sodocho sdc = sodocho(
                tmp.first.id,
                tmp.first.idTang,
                tmp.first.kieuCho,
                tmp.first.loaiCho,
                tmp.first.viTriHang,
                tmp.first.viTriCot,
                tmp.first.tenCho,
                tmp.first.giaTien,
                tmp.first.trangThai,
                tmp.first.soDienThoaiKhachHang,
                tmp.first.kichHoatGhePhu);
            temp.add(sdc);
          } else {
            sodocho sdc = sodocho(
                tmp.first.id,
                tmp.first.idTang,
                tmp.first.kieuCho,
                tmp.first.loaiCho,
                tmp.first.viTriHang,
                tmp.first.viTriCot,
                tmp.first.tenCho,
                tmp.first.giaTien,
                tmp.first.trangThai,
                tmp.first.soDienThoaiKhachHang,
                tmp.first.kichHoatGhePhu);
            temp.add(sdc);
          }
        } else {
          sodocho sdc = sodocho(
              null, null, null, null, 1, 1, 'abc', null, null, null, null);
          temp.add(sdc);
        }
      }
    }
  }

  Container checkStatus(int ind, String num) {
    if (temp[ind].trangThai.tenTrangThai == null) {
      return Container(
        height: 35,
        width: 39,
      );
    } else if (temp[ind].trangThai.tenTrangThai == 'Có khách') {
      return Container(
        height: 35,
        width: 39,
        decoration: BoxDecoration(
            color: Colors.blue[600],
            // border: Border.all(color: Colors.grey[350]),
            borderRadius: BorderRadius.circular(4)),
        child: Center(
            child: SvgPicture.asset(
          'asset/icons/account-check.svg',
          color: Colors.white,
        )),
      );
    } else {
      Container(
        height: 35,
        width: 39,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey[350]),
            borderRadius: BorderRadius.circular(4)),
        child: Center(child: Text(num)),
      );
    }
  }
}

Row seatItemLX(String num) {
  return Row(
    children: [
      SizedBox(
        width: 10,
      ),
      Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 35,
                        width: 45,
                        decoration: BoxDecoration(
                          color: Colors.grey[350],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                      left: 3,
                      child: Stack(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                              height: 35,
                              width: 39,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.grey[350]),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Center(child: Text(num)),
                            ),
                          ),
                          Positioned(
                              top: 30,
                              left: 7,
                              child: Container(
                                height: 5,
                                width: 24,
                                decoration: BoxDecoration(
                                    color: Colors.grey[350],
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(3),
                                        topRight: Radius.circular(3))),
                              )),
                        ],
                      )),
                ],
              )
            ],
          ),
          Positioned(
              bottom: 42,
              left: 12,
              child: Image.asset(
                'asset/images/volant.png',
                width: 20,
                height: 20,
              ))
        ],
      ),
    ],
  );
}

Row itemBottomSheet(Color color, String title, String value) {
  return Row(
    children: [
      Container(
        margin: EdgeInsets.only(right: 5),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
            color: color),
        child: Center(
            child: Text(
          '0',
          style: TextStyle(color: Colors.white),
        )),
      ),
      Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
      Text(
        value,
        style: TextStyle(color: Colors.black),
      ),
    ],
  );
}
