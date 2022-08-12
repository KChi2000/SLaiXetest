import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_ui_kit/QRScanner/QRpage.dart';
import 'package:flutter_ui_kit/extensions/extensions.dart';
import 'package:flutter_ui_kit/helpers/ApiHelper.dart';
import 'package:flutter_ui_kit/model/TrangThaiChoNgoi.dart';
import 'package:flutter_ui_kit/model/tang.dart';
import 'package:flutter_ui_kit/model/tangJson.dart';
import 'package:flutter_ui_kit/other/homeConstant.dart';
import 'package:flutter_ui_kit/servicesAPI.dart';
import 'package:flutter_ui_kit/ve/banve.dart';
import 'package:flutter_ui_kit/ve/banveXeNoSoDoCho.dart';
import 'package:flutter_ui_kit/ve/banveghephu.dart';
import 'package:image_picker/image_picker.dart';
import '../model/DSHanhKhachGhePhu.dart';
import '../model/LichSuChuyenDi.dart';
import '../model/SLVe.dart';
import '../model/ThongTinHanhKhachGhe.dart';
import '../model/ThongTinThem.dart';
import '../model/chuyendiList.dart';
import '../model/chuyendiganday.dart';
import '../model/sodocho.dart';
import '../model/sodochoJson.dart';
import 'package:intl/intl.dart';

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
  String title;
  String hasTangdata = 'loading';
  List<tangData> tangList = [];
  int pos;
  var TrangThaiChoNgoiFuture;
  String checkHaschuyendiganday = 'has data';

  var chuyendigandayFuture;
  chuyendiganday chuyendiGanday;
  var LichSuChuyenDiFuture;
  LichSuChuyenDi lichsuChuyenDi;
  var tangxeFuture;
  tang tangxe;
  var sodochoFuture;
  var thongtinthemFuture;
  var thongtinhanhkhachFuture;
  ThongTinThem thongtinthem;
  String changeSodocho;
  sodocho sodoCho;
  var dshanhkhachghephuFuture;
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  SLVe slve;
  String sdt = null;
  String ten;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadLichSuChuyenDi();
  }

  void loadslve(String guidchuyendi) async {
    try {
      slve = await ApiHelper.getSLVe(guidchuyendi);
    } catch (ex) {
      print(ex);
    }
  }

  void loadThongTinKhachNgoi(String maChuyendi, guidChongoi) {
    thongtinhanhkhachFuture =
        ApiHelper.getThongTinHanhKhachGhe(maChuyendi, guidChongoi);
  }

  void loadLichSuChuyenDi() async {
    try {
      chuyendigandayFuture = ApiHelper.getchuyendiganday();
      chuyendiGanday = await chuyendigandayFuture;
      if (chuyendiGanday.status) {
        value = chuyendiGanday.data.maChuyenDi;
        changeSodocho = chuyendiGanday.data.guidChuyenDi;
        print('changesodocho $changeSodocho');
        LichSuChuyenDiFuture =
            ApiHelper.getLichSuChuyenDi(chuyendiGanday.data.guidChuyenDi);
        lichsuChuyenDi = await LichSuChuyenDiFuture;
        loadTrangThaiChoNgoi(changeSodocho);
        loadchongoi();
        loadslve(changeSodocho);
        if (this.mounted) {
          setState(() {});
        }
      } else {
        setState(() {
          checkHaschuyendiganday = 'no data';
          hasTangdata = 'no data';
        });
      }
    } catch (ex) {
      setState(() {
        checkHaschuyendiganday = 'no data';
        hasTangdata = 'no data';
      });
    }
  }

  void LichSuChuyenDiNotify() {
    List<DataLichSuChuyenDi> lichsulist = lichsuChuyenDi.data;
    var temp = lichsulist.where((element) => element.maChuyenDi == value);
    if (temp.first.guidChuyenDi != null) {
      setState(() {
        changeSodocho = temp.first.guidChuyenDi;
        loadchongoi();
        loadTrangThaiChoNgoi(changeSodocho);
      });
    }
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
        // hasTangdata = 'no data';
      });
    }
  }

  void loadTrangThaiChoNgoi(String guidChuyenDi) async {
    TrangThaiChoNgoiFuture = ApiHelper.getTrangThaiChoNgoi(guidChuyenDi);
    // trangthaichongoi = await TrangThaiChoNgoiFuture;
  }

  void loadDSGhePhu() {
    dshanhkhachghephuFuture = ApiHelper.getDSHanhKhachGhePhu(changeSodocho);
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
                      return checkHaschuyendiganday != 'no data'
                          ? FutureBuilder(
                              future: LichSuChuyenDiFuture,
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (snapshot.hasData) {
                                  LichSuChuyenDi data = snapshot.data;
                                  List<DataLichSuChuyenDi> lichsulist =
                                      data.data;

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
                                                fontFamily: 'Roboto Medium',
                                                fontSize: 20)),
                                        SizedBox(
                                          height: spaceBetween,
                                        ),
                                        Expanded(
                                          child: ListView.builder(
                                            itemBuilder: (context, index) {
                                              var time;

                                              time = DateTime.parse(
                                                      lichsulist[index]
                                                          .gioXuatBen)
                                                  .toLocal();

                                              String timeHieuLuc =
                                                  DateFormat('kk:mm')
                                                      .format(time);
                                              return GestureDetector(
                                                onTap: () {
                                                  print(title);
                                                  Navigator.pop(context);

                                                  setState(() {
                                                    choose = index;
                                                    title = lichsulist[index]
                                                        .maChuyenDi;
                                                  });
                                                  print('title  $title');
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
                                                              color: choose ==
                                                                      index
                                                                  ? selectedColor
                                                                  : unselectedColor,
                                                              fontFamily:
                                                                  'Roboto Regular',
                                                              fontSize: 14),
                                                        ),
                                                        Text(' | ',
                                                            style: TextStyle(
                                                                color: choose ==
                                                                        index
                                                                    ? selectedColor
                                                                    : unselectedColor,
                                                                fontFamily:
                                                                    'Roboto Regular',
                                                                fontSize: 14)),
                                                        Text('$timeHieuLuc',
                                                            style: TextStyle(
                                                                color: choose ==
                                                                        index
                                                                    ? selectedColor
                                                                    : unselectedColor,
                                                                fontFamily:
                                                                    'Roboto Regular',
                                                                fontSize: 14))
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
                              })
                          : Center(
                              child: Text('Không tìm thấy chuyến đi'),
                            );
                    });
                  }).whenComplete(() {
                // print(title);
                // print(value);
                if (title == null || title.isEmpty) {
                  setState(() {
                    title = chuyendiGanday.data.maChuyenDi;
                  });
                }

                setState(() {
                  value = title;
                  sodochoFuture = null;
                });
                LichSuChuyenDiNotify();
                print('value: ' + value);
              });
            },
            child: Row(
              children: [
                Text(
                  "$value",
                  style: TextStyle(
                      color: appBartextColor,
                      fontFamily: 'Roboto Regular',
                      fontSize: 14),
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
                        size: 16,
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
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => QRpage()));
                  },
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
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Roboto Regular',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              )),
                            ),
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    List<DataSLVe> listslve = slve.data;
                                    List<TrangThaiData> listTrangThai =
                                        trangthaichongoi.data;
                                    List<TrangThaiData> listtemp =
                                        trangthaichongoi.data;
                                    TrangThaiData item1 = listtemp[0];
                                    listTrangThai.removeWhere(
                                        (item) => item.idTrangThai == 1);

                                    return Container(
                                      padding: EdgeInsets.all(20),
                                      height: 225,
                                      child: ListView(
                                        children: [
                                          itemBottomSheet1(item1),
                                          ...listTrangThai
                                              .map(itemBottomSheet)
                                              .toList(),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            ' Vé bán tại bến: ${listslve.first.soLuong}',
                                            style: TextStyle(
                                                fontFamily: 'Roboto Regular',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          )
                                        ],
                                      ),
                                    );
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
        body: checkHaschuyendiganday != 'no data'
            ? Container(
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
                        } else if (hasTangdata == 'no data') {
                          return Center(
                            child: Text('Không có dữ liệu',
                                style: TextStyle(
                                    fontFamily: 'Roboto Regular',
                                    fontSize: 14)),
                          );
                        } else if (hasTangdata == 'Thành công') {
                          if (snapshot.hasData) {
                            sodocho datatemp = snapshot.data;

                            if (datatemp.status) {
                              List<sodochoData> sodoList = datatemp.data;

                              print(sodoList.length);
                              return Column(
                                children: [
                                  // Row(
                                  //   children: [Text('aaa')],
                                  // ),
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
                                                    bottomLeft:
                                                        Radius.circular(8))),
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
                                                    bottomLeft:
                                                        Radius.circular(8))),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: widthScreen - 35,
                                        height: heightScreen * 0.70,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey[400],
                                                width: 3.5),
                                            borderRadius:
                                                BorderRadius.circular(20)),
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
                                                      BorderRadius.all(
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
                                                                Radius.circular(
                                                                    20))),
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
                                                                      .circular(
                                                                          10),
                                                                  topRight: Radius
                                                                      .circular(
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
                                                                Radius.circular(
                                                                    20))),
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
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Container(
                                                width: widthScreen - 35 - 10,
                                                height: heightScreen * 0.65,
                                                color: Colors.white,
                                                child: GridView(
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 5),
                                                  children: abc(sodoList),
                                                ))
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
                                                    topRight:
                                                        Radius.circular(8),
                                                    bottomRight:
                                                        Radius.circular(8))),
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
                                                    topRight:
                                                        Radius.circular(8),
                                                    bottomRight:
                                                        Radius.circular(8))),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              );
                            }
                          }
                        }
                        return Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Xe của bạn hiện chưa có sơ đồ chỗ',
                                  style: TextStyle(
                                      fontFamily: 'Roboto Regular',
                                      fontSize: 14),
                                ),
                                Text(
                                    'Vui lòng liên hệ Công ty của bạn để được cập nhật',
                                    style: TextStyle(
                                        fontFamily: 'Roboto Regular',
                                        fontSize: 14)),
                              ]),
                        );
                      },
                    ))
                  ],
                ),
              )
            : Center(
                child: Text('Không tìm thấy chuyến đi',
                    style:
                        TextStyle(fontFamily: 'Roboto Regular', fontSize: 14)),
              ),
        floatingActionButton: checkHaschuyendiganday != 'no data'
            ? hasTangdata == 'Không tìm thấy dữ liệu'
                ? FloatingActionButton.extended(
                    elevation: 6,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => banveXeNoSoDoCho(
                                  chuyendiGanday.data.guidLoTrinh,
                                  changeSodocho)));
                    },
                    label: Text('BÁN VÉ',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                            fontFamily: 'Roboto Medium',
                            letterSpacing: 1.25)),
                    icon: SvgPicture.asset(
                      "asset/icons/v.svg",
                      width: 18,
                      height: 18,
                      color: Colors.blue,
                    ),
                    backgroundColor: Colors.white,
                  )
                : SpeedDial(
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => banveghephu(
                                        chuyendiGanday.data.guidLoTrinh,
                                        changeSodocho)));
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
                            loadDSGhePhu();
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return StatefulBuilder(
                                      builder: (context, setState) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 15),
                                      height: 300,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text('Hủy',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 15)),
                                            ),
                                          ),
                                          Text('Khách mua vé ghế phụ',
                                              style: TextStyle(
                                                fontFamily: 'Roboto Medium',
                                                fontSize: 20,
                                              )),
                                          FutureBuilder(
                                              future: dshanhkhachghephuFuture,
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                } else if (snapshot.hasError) {
                                                  return Center(
                                                    child: Text('Lỗi',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Roboto Regular',
                                                            fontSize: 14)),
                                                  );
                                                } else if (snapshot.hasData) {
                                                  DSHanhKhachGhePhu
                                                      dshanhkhachghephu =
                                                      snapshot.data;
                                                  List<DataDSHanhKhachGhePhu>
                                                      listds =
                                                      dshanhkhachghephu.data;
                                                  if (listds.length == 0) {
                                                    return Expanded(
                                                      child: Center(
                                                        child: Text(
                                                          'Không có dữ liệu để hiển thị',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Roboto Regular',
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .grey[700]),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                  return Expanded(
                                                    child: ListView.builder(
                                                        itemCount:
                                                            listds.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Row(
                                                            children: [
                                                              Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  SizedBox(
                                                                    height: 15,
                                                                  ),
                                                                  Row(
                                                                      children: [
                                                                        Text(
                                                                            'Số điện thoại: ',
                                                                            style: TextStyle(
                                                                                fontFamily: 'Roboto Regular',
                                                                                fontSize: 14,
                                                                                fontWeight: FontWeight.w400)),
                                                                        Text(
                                                                            '${listds[index].soDienThoai}',
                                                                            style:
                                                                                TextStyle(
                                                                              fontFamily: 'Roboto Medium',
                                                                              fontSize: 14,
                                                                              color: Colors.green,
                                                                            )),
                                                                      ]),
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Row(
                                                                      children: [
                                                                        Text(
                                                                            'Giá vé: ',
                                                                            style: TextStyle(
                                                                                fontFamily: 'Roboto Regular',
                                                                                fontSize: 14,
                                                                                fontWeight: FontWeight.w400)),
                                                                        Text(
                                                                            '${NumberFormat('#,###').format(listds[index].giaVe)}đ',
                                                                            style:
                                                                                TextStyle(
                                                                              fontFamily: 'Roboto Medium',
                                                                              fontSize: 14,
                                                                              color: Colors.red,
                                                                            )),
                                                                      ]),
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Row(
                                                                      children: [
                                                                        Text(
                                                                            'Điểm xuống: ',
                                                                            style: TextStyle(
                                                                                fontFamily: 'Roboto Regular',
                                                                                fontSize: 14,
                                                                                fontWeight: FontWeight.w400)),
                                                                        Text(
                                                                            '${listds[index].diemXuong}',
                                                                            style:
                                                                                TextStyle(
                                                                              fontFamily: 'Roboto Medium',
                                                                              fontSize: 14,
                                                                              color: Colors.orange,
                                                                            )),
                                                                      ]),
                                                                  Divider(
                                                                    color: Colors
                                                                        .black,
                                                                    height: 1,
                                                                    thickness:
                                                                        0.5,
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                width: 40,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons.print,
                                                                    color: Colors
                                                                        .black54,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  InkWell(
                                                                    onTap:
                                                                        () async {
                                                                      var resp =
                                                                          await ApiHelper.post(
                                                                              servicesAPI.API_DoiSoat + 'thuc-hien-xac-nhan-khach-xuong-xe-ghe-phu',
                                                                              {
                                                                            'guidXe':
                                                                                chuyendiGanday.data.guidXe,
                                                                            'maChuyenDi':
                                                                                value,
                                                                            'maDatCho':
                                                                                listds[index].maDatCho,
                                                                            'toaDo':
                                                                                ""
                                                                          });
                                                                      if (resp[
                                                                          'status']) {
                                                                        setState(
                                                                            () {
                                                                          loadDSGhePhu();
                                                                        });

                                                                        // Navigator.pop(
                                                                        //     context);
                                                                      } else {
                                                                        showDialog(
                                                                          context:
                                                                              context,
                                                                          barrierDismissible:
                                                                              false, // user must tap button!
                                                                          builder:
                                                                              (BuildContext context) {
                                                                            return AlertDialog(
                                                                              title: const Text('Lỗi',style: TextStyle(fontFamily: 'Roboto Regular',fontSize: 18,color: Colors.red)),
                                                                              content: Text('${resp['message']}',style: TextStyle(fontFamily: 'Roboto Regular',fontSize: 14)),
                                                                              actions: <Widget>[
                                                                                TextButton(
                                                                                  child: const Text('Đã hiểu',style: TextStyle(fontFamily: 'Roboto Regular',fontSize: 14)),
                                                                                  onPressed: () {
                                                                                    Navigator.of(context).pop();
                                                                                  },
                                                                                ),
                                                                              ],
                                                                            );
                                                                          },
                                                                        );
                                                                      }
                                                                    },
                                                                    child: SvgPicture.asset(
                                                                        'asset/icons/arrowdown.svg',
                                                                        width:
                                                                            20,
                                                                        height:
                                                                            20,
                                                                        color: Colors
                                                                            .black54),
                                                                  )
                                                                ],
                                                              )
                                                            ],
                                                          );
                                                        }),
                                                  );
                                                }
                                                return Expanded(
                                                  child: Center(
                                                    child: Text(
                                                      'Không có dữ liệu',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Roboto Regular',
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                          SizedBox(
                                            height: 40,
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                                });
                            print('dung hanh trinh');
                          },
                          label: 'Khách ngồi ghế phụ',
                          child: Icon(Icons.chair_alt, color: Colors.black))
                    ],
                  )
            : null);
  }

  Column seatItem1(String num, List<sodochoData> listdata, int cot, int hang) {
    return Column(children: [
      SizedBox(
        height: 15,
      ),
      Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 9,
              ),
              Container(
                height: 33,
                width: 50,
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
                        var index = listdata.indexWhere((element) =>
                            element.viTriCot == cot &&
                            element.viTriHang == hang);
                        pos = index;
                        print('index: ${listdata[index].id}');
                        print('poss: ${listdata[index].tenCho}');
                        // if (sodoList[index].trangThai.tenTrangThai ==
                        //     'Có khách') {
                        //   sodoList[index].trangThai.tenTrangThai = 'Còn trống';
                        // } else {
                        //   sodoList[index].trangThai.tenTrangThai = 'Có khách';
                        // }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => banve(
                                    chuyendiGanday.data.guidLoTrinh,
                                    chuyendiGanday.data.guidXe,
                                    changeSodocho,
                                    listdata[index].id)));
                      });
                    },
                    child: Container(
                      height: 37,
                      width: 43,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey[350]),
                          borderRadius: BorderRadius.circular(4)),
                      child: Center(
                          child: Text(
                        num,
                        style: TextStyle(
                            fontFamily: 'Roboto Regular', fontSize: 14),
                      )),
                    ),
                  ),
                  Positioned(
                      top: 30,
                      left: 7,
                      child: Container(
                        height: 7,
                        width: 27,
                        decoration: BoxDecoration(
                            color: Colors.grey[350],
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(4))),
                      )),
                ],
              )),
        ],
      ),
    ]);
  }

  Column seatItem2(String num, List<sodochoData> listdata, int cot, int hang) {
    return Column(children: [
      SizedBox(
        height: 15,
      ),
      Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 9,
              ),
              Container(
                height: 33,
                width: 50,
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
                          var index = listdata.indexWhere((element) =>
                              element.viTriCot == cot &&
                              element.viTriHang == hang);
                          // pos = index;
                          loadThongTinKhachNgoi(value, listdata[index].id);
                          print('index: ${listdata[index].id}');
                          print('poss: $value');
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return FutureBuilder<ThongTinHanhKhachGhe>(
                                    future: thongtinhanhkhachFuture,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else if (snapshot.hasData) {
                                        ThongTinHanhKhachGhe thongtin =
                                            snapshot.data;
                                        DataThongTinHanhKhachGhe data =
                                            thongtin.data;
                                        return Container(
                                          padding: EdgeInsets.all(20),
                                          height: 300,
                                          child: Column(
                                            // mainAxisAlignment:
                                            // MainAxisAlignment.spaceAround,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text('Hủy',
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontFamily:
                                                              'Roboto Regular',
                                                          fontSize: 14)),
                                                ),
                                              ),
                                              Text('Thông tin hành khách',
                                                  style: TextStyle(
                                                      fontFamily: 'Roboto Bold',
                                                      fontSize: 20)),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'asset/icons/card-account-phone-outline.svg',
                                                        color: Colors.blue,
                                                      ),
                                                      SizedBox(
                                                        width: spaceBetween,
                                                      ),
                                                      Text(
                                                        '${data.soDienThoai}',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Roboto Regular',
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Colors.blue),
                                                      ),
                                                    ],
                                                  ),
                                                  IconButton(
                                                      onPressed: () {
                                                        // print(data.)
                                                        phoneController.text =
                                                            data.soDienThoai;
                                                        nameController.text =
                                                            data.hoTen;
                                                        Navigator.pop(context);
                                                        showModalBottomSheet(
                                                            context: context,
                                                            builder: (context) {
                                                              return Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            20),
                                                                height: 400,
                                                                child: Column(
                                                                  // mainAxisAlignment:
                                                                  // MainAxisAlignment.spaceAround,
                                                                  children: [
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.topLeft,
                                                                        child: Text(
                                                                            'Hủy',
                                                                            style: TextStyle(
                                                                                color: Colors.red,
                                                                                fontFamily: 'Roboto Regular',
                                                                                fontSize: 14)),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                        'Thông tin hành khách',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize: 18)),
                                                                    Form(
                                                                        // key: formkey1,
                                                                        child: Column(
                                                                            children: [
                                                                          TextFormField(
                                                                            autofocus:
                                                                                true,
                                                                            controller:
                                                                                phoneController,
                                                                            decoration:
                                                                                InputDecoration(
                                                                              // hintText: 'nhập số điện thoại',
                                                                              labelText: 'Số điện thoại',
                                                                            ),

                                                                            // controller: sdtNhanController,
                                                                            inputFormatters: [
                                                                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                                                              FilteringTextInputFormatter.deny(RegExp(r'^[1-9]+')),
                                                                              LengthLimitingTextInputFormatter(10)
                                                                            ],
                                                                            validator:
                                                                                (sodt) {
                                                                              if (sodt == null || sodt.isEmpty) {
                                                                                return 'Điện thoại không được để trống';
                                                                              } else if (sodt.length <= 10) {
                                                                                return 'Sai định dạng số điện thoại';
                                                                              }
                                                                              return null;
                                                                            },
                                                                            onChanged:
                                                                                (vl1) {
                                                                              setState(() {
                                                                                sdt = vl1;
                                                                              });
                                                                            },
                                                                            autovalidateMode:
                                                                                AutovalidateMode.onUserInteraction,
                                                                          ),
                                                                          TextFormField(
                                                                            controller:
                                                                                nameController,
                                                                            decoration:
                                                                                InputDecoration(
                                                                              // hintText: 'nhập số điện thoại',
                                                                              labelText: 'Họ tên: ',
                                                                            ),

                                                                            // controller: sdtNhanController,
                                                                            inputFormatters: [
                                                                              // FilteringTextInputFormatter.allow(
                                                                              //     RegExp(r'[0-9]')),
                                                                              FilteringTextInputFormatter.deny(RegExp(r'[0-9]+')),
                                                                              // LengthLimitingTextInputFormatter(10)
                                                                            ],
                                                                            validator:
                                                                                (ht) {
                                                                              if (ht == null || ht.isEmpty) {
                                                                                return 'Họ tên không được để trống';
                                                                              }
                                                                              return null;
                                                                            },
                                                                            onChanged:
                                                                                (vl1) {
                                                                              setState(() {
                                                                                sdt = vl1;
                                                                              });
                                                                            },
                                                                            autovalidateMode:
                                                                                AutovalidateMode.onUserInteraction,
                                                                          ),
                                                                        ])),
                                                                    SizedBox(
                                                                      height:
                                                                          15,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            SvgPicture.asset('asset/icons/currency-usd.svg',
                                                                                width: 24,
                                                                                height: 24),
                                                                            SizedBox(
                                                                              width: spaceBetween,
                                                                            ),
                                                                            Text(
                                                                              'Thanh toán',
                                                                              style: TextStyle(
                                                                                fontFamily: 'Roboto Regular',
                                                                                fontSize: 14,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Text(
                                                                          '${data.trangThaiThanhToan.tenTrangThai}',
                                                                          style: TextStyle(
                                                                              fontFamily: 'Roboto Medium',
                                                                              fontSize: 14,
                                                                              color: Colors.black),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            Icon(
                                                                              Icons.location_on,
                                                                              size: 24,
                                                                            ),
                                                                            SizedBox(
                                                                              width: spaceBetween,
                                                                            ),
                                                                            Text(
                                                                              'Điểm xuống',
                                                                              style: TextStyle(fontFamily: 'Roboto Regular', fontSize: 14),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Text(
                                                                          '${data.tenDiemXuong}',
                                                                          style: TextStyle(
                                                                              fontFamily: 'Roboto Medium',
                                                                              fontSize: 14,
                                                                              color: Colors.black),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    FlatButton(
                                                                      onPressed:
                                                                          () async {
                                                                        var resp = await ApiHelper.post(
                                                                            servicesAPI.API_DonHang +
                                                                                'thuc-hien-sua-thong-tin-hanh-khach',
                                                                            {
                                                                              'guidChoNgoi': data.guidChoNgoi,
                                                                              'guidChuyenDi': changeSodocho,
                                                                              'guidDiemXuong': data.guidDiemXuong,
                                                                              'maDatCho': data.maDatCho,
                                                                              'soDienThoai': phoneController.text,
                                                                              'tenDiemXuong': data.tenDiemXuong,
                                                                              'tenKhachHang': nameController.text
                                                                            });
                                                                        if (resp[
                                                                            'status']) {
                                                                          loadLichSuChuyenDi();
                                                                          Navigator.pop(
                                                                              context);
                                                                        } else {
                                                                          showDialog(
                                                                            context:
                                                                                context,
                                                                            barrierDismissible:
                                                                                false, // user must tap button!
                                                                            builder:
                                                                                (BuildContext context) {
                                                                              return AlertDialog(
                                                                                title: const Text(
                                                                                  'Lỗi',
                                                                                  style: TextStyle(fontFamily: 'Roboto Regular', fontSize: 18,color: Colors.red),
                                                                                ),
                                                                                content: Text('${resp['message']}',style: TextStyle(fontFamily: 'Roboto Regular',fontSize: 14)),
                                                                                actions: <Widget>[
                                                                                  TextButton(
                                                                                    child: const Text('Đã hiểu', style: TextStyle(fontFamily: 'Roboto Regular', fontSize: 14)),
                                                                                    onPressed: () {
                                                                                      Navigator.of(context).pop();
                                                                                    },
                                                                                  ),
                                                                                ],
                                                                              );
                                                                            },
                                                                          );
                                                                        }
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        'XÁC NHẬN',
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'Roboto Medium',
                                                                            fontSize:
                                                                                14,
                                                                            letterSpacing:
                                                                                1.25,
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                      color: Colors
                                                                          .blue,
                                                                    )
                                                                  ],
                                                                ),
                                                              );
                                                            });
                                                      },
                                                      icon: Icon(
                                                        Icons.edit,
                                                        size: 20,
                                                        color: Colors.blue,
                                                      ))
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                      'asset/icons/account-circle-outline.svg'),
                                                  SizedBox(
                                                    width: spaceBetween,
                                                  ),
                                                  Text(
                                                    '${data.hoTen}',
                                                    style: TextStyle(
                                                        // fontWeight: fontStyleListItem,
                                                        fontFamily:
                                                            'Roboto Regular',
                                                        fontSize: 14),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                          'asset/icons/currency-usd.svg',
                                                          width: 24,
                                                          height: 24),
                                                      SizedBox(
                                                        width: spaceBetween,
                                                      ),
                                                      Text(
                                                        'Thanh toán',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Roboto Regular',
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    '${data.trangThaiThanhToan.tenTrangThai}',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'Roboto Regular',
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: HexColor.fromHex(
                                                            '#00FF00')),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        size: 24,
                                                      ),
                                                      SizedBox(
                                                        width: spaceBetween,
                                                      ),
                                                      Text(
                                                        'Điểm xuống',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Roboto Regular',
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    '${data.tenDiemXuong}',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'Roboto Regular',
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.black),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Divider(
                                                height: 2,
                                                thickness: 0.3,
                                                color: Colors.black,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  FlatButton(
                                                      onPressed: () {
                                                        // formTTHK.currentState.validate();
                                                      },
                                                      child: Text(
                                                        'IN VÉ',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Roboto Medium',
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Colors.blue),
                                                      )),
                                                  FlatButton(
                                                    onPressed: () async {
                                                      var resp = await ApiHelper.post(
                                                          servicesAPI
                                                                  .API_DoiSoat +
                                                              'thuc-hien-xac-nhan-khach-xuong-xe',
                                                          {
                                                            'guidXe':
                                                                chuyendiGanday
                                                                    .data
                                                                    .guidXe,
                                                            'maChuyenDi':
                                                                data.maChuyenDi,
                                                            'maDatCho':
                                                                data.maDatCho,
                                                            'tenCho':
                                                                listdata[index]
                                                                    .tenCho,
                                                            'toaDo': ''
                                                          });
                                                      if (resp['status']) {
                                                        loadLichSuChuyenDi();

                                                        Navigator.pop(context);
                                                      } else {
                                                        showDialog(
                                                          context: context,
                                                          barrierDismissible:
                                                              false, // user must tap button!
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: const Text(
                                                                  'Lỗi',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Roboto Regular',
                                                                      fontSize:
                                                                          18,color: Colors.red)),
                                                              content: Text(
                                                                  '${resp['message']}',style: TextStyle(fontFamily: 'Roboto Regular',fontSize: 14)),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  child: const Text(
                                                                      'Đã hiểu',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Roboto Regular',
                                                                          fontSize:
                                                                              14)),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      }
                                                    },
                                                    child: Text(
                                                      'XUỐNG XE',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Roboto Medium',
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.white,
                                                          letterSpacing: 1.25),
                                                    ),
                                                    color: Colors.blue,
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Center(
                                          child: Text('Lỗi',
                                              style: TextStyle(
                                                  fontFamily: 'Roboto Regular',
                                                  fontSize: 14)),
                                        );
                                      }
                                      return Center(
                                        child: Text('Không có dữ liệu',
                                            style: TextStyle(
                                                fontFamily: 'Roboto Regular',
                                                fontSize: 14)),
                                      );
                                    });
                              });
                        });
                      },
                      child: Container(
                        height: 37,
                        width: 43,
                        decoration: BoxDecoration(
                            color: Colors.blue[600],
                            // border: Border.all(color: Colors.grey[350]),
                            borderRadius: BorderRadius.circular(4)),
                        child: Center(
                            child: SvgPicture.asset(
                          'asset/icons/account-check.svg',
                          color: Colors.white,
                        )),
                      )),
                  Positioned(
                      top: 30,
                      left: 7,
                      child: Container(
                        height: 7,
                        width: 27,
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

  List<Widget> abc(List<sodochoData> listparam) {
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
            if (tmp.first.trangThai.idTrangThai == 1) {
              list.add(seatItem1('${tmp.first.tenCho}', listparam, vtC, vtH));
            } else {
              list.add(seatItem2('${tmp.first.tenCho}', listparam, vtC, vtH));
            }
          }
        } else {
          list.add(Text(''));
        }
      }
    }

    // print('abc.list.length = ${list.length}');
    return list;
  }
}

Row seatItemLX(String num) {
  return Row(
    children: [
      SizedBox(
        width: 5,
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
                        height: 9,
                      ),
                      Container(
                        height: 33,
                        width: 50,
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
                              height: 37,
                              width: 43,
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
                                height: 7,
                                width: 27,
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
              bottom: 40,
              left: 12,
              child: Image.asset(
                'asset/images/volant.png',
                width: 21,
                height: 21,
              ))
        ],
      ),
    ],
  );
}

Container itemBottomSheet(TrangThaiData data) {
  return Container(
    padding: EdgeInsets.all(3),
    child: Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: 5),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
            color: HexColor.fromHex(data.maMau),
            // border: border
            //     ? Border.all(color: Colors.black, width: 0.3)
            //     : Border.all(color: Colors.white, width: 0.0)
          ),
          child: Center(
              child: Text(
            data.soLuong.toString(),
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Roboto Regular',
                fontSize: 14,
                fontWeight: FontWeight.w400),
          )),
        ),
        Text(
          '${data.tenTrangThai}: ',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Roboto Regular',
              fontSize: 14,
              fontWeight: FontWeight.w400),
        ),
        Text(
          data.soLuong.toString(),
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Roboto Regular',
              fontSize: 14,
              fontWeight: FontWeight.w400),
        ),
      ],
    ),
  );
}

Container itemBottomSheet1(TrangThaiData data) {
  return Container(
    padding: EdgeInsets.all(3),
    child: Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: 5),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
              color: HexColor.fromHex(data.maMau),
              border: Border.all(color: Colors.black, width: 0.3)),
          child: Center(
              child: Text(
            data.soLuong.toString(),
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Roboto Regular',
                fontSize: 14,
                fontWeight: FontWeight.w400),
          )),
        ),
        Text(
          '${data.tenTrangThai}: ',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Roboto Regular',
              fontSize: 14,
              fontWeight: FontWeight.w400),
        ),
        Text(
          data.soLuong.toString(),
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Roboto Regular',
              fontSize: 14,
              fontWeight: FontWeight.w400),
        ),
      ],
    ),
  );
}
