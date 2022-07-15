import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_ui_kit/extensions/extensions.dart';
import 'package:flutter_ui_kit/helpers/ApiHelper.dart';
import 'package:flutter_ui_kit/model/TrangThaiChoNgoi.dart';
import 'package:flutter_ui_kit/model/tang.dart';
import 'package:flutter_ui_kit/model/tangJson.dart';
import 'package:flutter_ui_kit/other/homeConstant.dart';
import 'package:flutter_ui_kit/ve/banve.dart';
import 'package:flutter_ui_kit/ve/banveghephu.dart';
import 'package:image_picker/image_picker.dart';
import '../model/LichSuChuyenDi.dart';
import '../model/ThongTinThem.dart';
import '../model/chuyendiList.dart';
import '../model/chuyendiganday.dart';
import '../model/sodocho.dart';
import '../model/sodochoJson.dart';
import 'package:intl/intl.dart';

List<String> trangthai = ['Còn trống', 'Có khách'];

class Ve extends StatefulWidget {
  @override
  VeState createState() {
    return VeState();
  }
}

class VeState extends State<Ve> {
  double spacebetween = 20;
  double spaceRow = 20;
  double marginRowLeft = 15;
  bool flag = false;
  int choose = 0;
  String value = '';
  bool seat = false;
  bool activefab = false;
  String title = '';
  String hasTangdata = 'loading';
  List<tangData> tangList = [];
  int pos;
  var TrangThaiChoNgoiFuture;

  var chuyendigandayFuture;
  chuyendiganday chuyendiGanday;
  var LichSuChuyenDiFuture;
  LichSuChuyenDi lichsuChuyenDi;
  var tangxeFuture;
  tang tangxe;
  var sodochoFuture;
  var thongtinthemFuture;
  ThongTinThem thongtinthem;
  String changeSodocho;
  sodocho sodoCho;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadLichSuChuyenDi();
  }

  void loadLichSuChuyenDi() async {
    chuyendigandayFuture = ApiHelper.getchuyendiganday();
    chuyendiGanday = await chuyendigandayFuture;
    if (chuyendiGanday != null) {
      value = chuyendiGanday.data.maChuyenDi;
      changeSodocho = chuyendiGanday.data.guidChuyenDi;
      print('changesodocho $changeSodocho');
      LichSuChuyenDiFuture = ApiHelper.getLichSuChuyenDi(
          'http://vedientu.nguyencongtuyen.local:19666/api/ChuyenDi/lay-danh-sach-lich-su-chuyen-di-cua-lai-xe?GuidChuyenDi=${chuyendiGanday.data.guidChuyenDi}');
      lichsuChuyenDi = await LichSuChuyenDiFuture;
      loadTrangThaiChoNgoi(changeSodocho);
      loadchongoi();
      if (this.mounted) {
        setState(() {});
      }
    }
  }

  void LichSuChuyenDiNotify() {
    List<DataLichSuChuyenDi> lichsulist = lichsuChuyenDi.data;
    var temp = lichsulist.where((element) => element.maChuyenDi == value);
    setState(() {
      changeSodocho = temp.first.guidChuyenDi;
      loadchongoi();
      loadTrangThaiChoNgoi(changeSodocho);
    });
  }

  void loadchongoi() async {
    tangxeFuture = ApiHelper.gettang(changeSodocho);
    tangxe = await tangxeFuture;
    hasTangdata = tangxe.message;
    if (tangxe.status) {
      tangList = tangxe.data;
      List<tangData> datatemp = tangxe.data ?? [];
      sodochoFuture = ApiHelper.getsodocho(changeSodocho, datatemp[0].idTang);
      sodoCho = await sodochoFuture;
      setState(() {});
    } else {
      setState(() {
        sodochoFuture = null;
      });
    }
  }

  void loadTrangThaiChoNgoi(String guidChuyenDi) async {
    TrangThaiChoNgoiFuture = ApiHelper.getTrangThaiChoNgoi(guidChuyenDi);
    // trangthaichongoi = await TrangThaiChoNgoiFuture;
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
                      return FutureBuilder(
                          future: LichSuChuyenDiFuture,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasData) {
                              LichSuChuyenDi data = snapshot.data;
                              List<DataLichSuChuyenDi> lichsulist = data.data;

                              return Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: paddingVertical,
                                    horizontal: paddingHori),
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
                                          var time;

                                          time = DateTime.parse(
                                                  lichsulist[index].gioXuatBen)
                                              .toLocal();

                                          String timeHieuLuc =
                                              DateFormat('kk:mm').format(time);
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                choose = index;
                                                title = lichsulist[index]
                                                    .maChuyenDi;
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
                                                      width:
                                                          iconSizeBottomSheet,
                                                      height:
                                                          iconSizeBottomSheet,
                                                    ),
                                                    Text(
                                                      ' ${lichsulist[index].maChuyenDi}',
                                                      style: TextStyle(
                                                          color: choose == index
                                                              ? selectedColor
                                                              : unselectedColor),
                                                    ),
                                                    Text(' | ',
                                                        style: TextStyle(
                                                            color: choose ==
                                                                    index
                                                                ? selectedColor
                                                                : unselectedColor)),
                                                    Text('$timeHieuLuc',
                                                        style: TextStyle(
                                                            color: choose ==
                                                                    index
                                                                ? selectedColor
                                                                : unselectedColor))
                                                  ],
                                                )),
                                          );
                                        },
                                        itemCount: lichsulist.length,
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }
                            return Center(
                              child: Text('Lỗi'),
                            );
                          });
                    });
                  }).whenComplete(() {
                setState(() {
                  value = title;
                  sodochoFuture = null;
                  print('value: ' + title);
                });
                LichSuChuyenDiNotify();
              });
            },
            child: Row(
              children: [
                Text(
                  "$value",
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
                FutureBuilder(
                  future: TrangThaiChoNgoiFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      TrangThaiChoNgoi trangthaichongoi = snapshot.data;
                      if (trangthaichongoi.status) {
                        return GestureDetector(
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
                                    List<TrangThaiData> listTrangThai =
                                        trangthaichongoi.data;
                                    return Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 25, vertical: 30),
                                        height: 250,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            itemBottomSheet(
                                                HexColor.fromHex(
                                                    listTrangThai[0].maMau),
                                                '${listTrangThai[0].tenTrangThai}: ',
                                                '${listTrangThai[0].soLuong}',
                                                '${listTrangThai[0].soLuong}',
                                                true,
                                                Colors.black),
                                            itemBottomSheet(
                                                HexColor.fromHex(
                                                    listTrangThai[1].maMau),
                                                '${listTrangThai[1].tenTrangThai}: ',
                                                '${listTrangThai[1].soLuong}',
                                                '${listTrangThai[1].soLuong}',
                                                false,
                                                Colors.white),
                                            itemBottomSheet(
                                                HexColor.fromHex(
                                                    listTrangThai[2].maMau),
                                                '${listTrangThai[2].tenTrangThai}: ',
                                                '${listTrangThai[2].soLuong}',
                                                '${listTrangThai[2].soLuong}',
                                                false,
                                                Colors.white),
                                            itemBottomSheet(
                                                HexColor.fromHex(
                                                    listTrangThai[3].maMau),
                                                '${listTrangThai[3].tenTrangThai}: ',
                                                '${listTrangThai[3].soLuong}',
                                                '${listTrangThai[3].soLuong}',
                                                false,
                                                Colors.white),
                                          ],
                                        ));
                                  });
                            });
                      } else
                        return Text('');
                    }
                    return Text('');
                  },
                )
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
            children: [
              SizedBox(
                height: 10,
              ),
              // Text('Sơ đồ chỗ xe khách',
              //     style: TextStyle(
              //         fontWeight: FontWeight.bold,
              //         color: Colors.black,
              //         fontSize: 18)),
              Expanded(
                  child: FutureBuilder<sodocho>(
                future: sodochoFuture,
                builder: (context, snapshot) {
                  if (hasTangdata == 'loading') {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (hasTangdata == 'Thành công') {
                    if (snapshot.hasData) {
                      sodocho datatemp = snapshot.data;

                      if (datatemp.status) {
                        List<sodochoData> sodoList = datatemp.data;
                        
                        print(sodoList.length);
                        return Column(
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
                                      border: Border.all(
                                          color: Colors.grey[400], width: 3.5),
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30))),
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
                                                  borderRadius:
                                                      BorderRadius.all(
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
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10)))),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              height: 15,
                                              width: 15,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
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
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 5),
                                            itemBuilder: (context, index) {
                                              return abc(
                                                  index, sodoList)[index];
                                            },
                                            itemCount: abc(0, sodoList).length),
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
                        );
                      }
                      //   return Center(
                      //   child: Column(children: [
                      //     Text('Xe của bạn hiện chưa có sơ đồ chỗ'),
                      //     Text(
                      //         'Vui lòng liên hệ Công ty của bạn để được cập nhật'),
                      //   ]),
                      // );
                    }
                  }
                  return Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Xe của bạn hiện chưa có sơ đồ chỗ'),
                          Text(
                              'Vui lòng liên hệ Công ty của bạn để được cập nhật'),
                        ]),
                  );
                },
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

  Column seatItem(String num,List<sodochoData> listdata,int index) {
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
                        // var index = listdata.indexWhere((element) =>
                        //     element.viTriCot == cot &&
                        //     element.viTriHang == hang);
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
                            MaterialPageRoute(builder: (context) => banve(chuyendiGanday.data.guidLoTrinh)));
                      });
                    },
                    child: listdata[index].trangThai.idTrangThai==4
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

  List<Widget> abc(int index, List<sodochoData> listparam) {
    // print(tangList.first.soHang);
    // print(tangList.first.soCot);
    List<Widget> list = [];
  
    for (int vtH = 1; vtH <= tangList.first.soHang; vtH++) {
      for (int vtC = 1; vtC <= tangList.first.soCot; vtC++) {
        var tmp =
            listparam.where((vt) => vt.viTriHang == vtH && vt.viTriCot == vtC);
        if (tmp.length >= 1) {
          if (tmp.first.viTriCot == 1 && tmp.first.viTriHang == 1) {
            list.add(seatItemLX('${tmp.first.tenCho}'));
          } else {
            list.add(seatItem('${tmp.first.tenCho}', listparam, index));
          }
        } else {
          list.add(Text(''));
        }
      }
    }

    // print('abc.list.length = ${list.length}');
    return list;
  }

  // Container checkStatus(int ind, String num) {
  //   if (temp[ind].trangThai.tenTrangThai == null) {
  //     return Container(
  //       height: 35,
  //       width: 39,
  //     );
  //   } else if (temp[ind].trangThai.tenTrangThai == 'Có khách') {
  //     return Container(
  //       height: 35,
  //       width: 39,
  //       decoration: BoxDecoration(
  //           color: Colors.blue[600],
  //           // border: Border.all(color: Colors.grey[350]),
  //           borderRadius: BorderRadius.circular(4)),
  //       child: Center(
  //           child: SvgPicture.asset(
  //         'asset/icons/account-check.svg',
  //         color: Colors.white,
  //       )),
  //     );
  //   } else {
  //     Container(
  //       height: 35,
  //       width: 39,
  //       decoration: BoxDecoration(
  //           color: Colors.white,
  //           border: Border.all(color: Colors.grey[350]),
  //           borderRadius: BorderRadius.circular(4)),
  //       child: Center(child: Text(num)),
  //     );
  //   }
  // }
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

Row itemBottomSheet(Color color, String title, String value1, String value2,
    bool border, Color LetterColor) {
  return Row(
    children: [
      Container(
        margin: EdgeInsets.only(right: 5),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
            color: color,
            border: border
                ? Border.all(color: Colors.black, width: 0.3)
                : Border.all(color: Colors.white, width: 0.0)),
        child: Center(
            child: Text(
          value2,
          style: TextStyle(color: LetterColor),
        )),
      ),
      Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
      Text(
        value1,
        style: TextStyle(color: Colors.black),
      ),
    ],
  );
}




// fetch all items from api trang thai ghe
// ListView.builder(
//                 itemCount: listTrangThai.length,
//                 itemBuilder: (context, index) {
//                     return itemBottomSheet(HexColor.fromHex(listTrangThai[index].maMau), listTrangThai[index].tenTrangThai, '${listTrangThai[index].soLuong}', '${listTrangThai[index].soLuong}');
                
//               })