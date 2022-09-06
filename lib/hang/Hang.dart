import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_ui_kit/components/chooseImage.dart';
import 'package:flutter_ui_kit/components/printpopup.dart';
import 'package:flutter_ui_kit/helpers/ApiHelper.dart';
import 'package:flutter_ui_kit/model/chuyendiList.dart';
import 'package:flutter_ui_kit/servicesAPI.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/DSHHTheoChuyenDi.dart';
import '../model/DSTrangThai.dart';
import '../model/LichSuChuyenDi.dart';
import '../model/ThongTinThem.dart';
import '../model/chuyendiganday.dart';
import '../model/printModel.dart';
import '../other/homeConstant.dart';
import 'hangDetail.dart';
import 'hangDetail.dart';
import 'layhangInfo.dart';
import '../model/hangList.dart';
import 'package:intl/intl.dart';

class Hang extends StatefulWidget {
  @override
  HangState createState() {
    return HangState();
  }
}

class HangState extends State<Hang> {
  int choose = 0;
  String title;
  String value;
  String chooseChuyenDi;
  String search = '';
  XFile imageitem;
  List<XFile> image = [];
  String checkHaschuyendiganday = 'has data';
  int count, itemclick;
  var chuyendigandayFuture;
  chuyendiganday chuyendiGanday;
  var dshhTheoChuyenDiFuture;
  DSHHTheoChuyenDi dshhTheoChuyenDi;
  var thongtinthemFuture;
  ThongTinThem thongtinthem;
  var dsTrangThaiFuture;
  DSTrangThai dsTrangThai;
  int trangthaiCount = 0;
  int tongtien = 0;
  String giaoStatus;
  var LichSuChuyenDiFuture;
  LichSuChuyenDi lichsuChuyenDi;
  bool isIOS;
  bool isAndroid;
  @override
  void initState() {
    // TODO: implement initState
    if (Platform.isAndroid) {
      setState(() {
        isAndroid = true;
        isIOS = false;
      });
    } else if (Platform.isIOS) {
      setState(() {
        isAndroid = false;
        isIOS = true;
      });
    }

    super.initState();
    loadchuyendiganday();
  }

  void loadchuyendiganday() async {
    try {
      chuyendigandayFuture = ApiHelper.getchuyendiganday(
          );
      chuyendiGanday = await chuyendigandayFuture;
      if (chuyendiGanday.status) {
        setState(() {
          chooseChuyenDi = chuyendiGanday.data.guidChuyenDi;
          loadshh(chooseChuyenDi, search);
          loadThongTinThem();
          loadDSTrangThai();
        });
      } else {
        setState(() {
          checkHaschuyendiganday = 'no data';
        });
      }
    } catch (ex) {
      setState(() {
        checkHaschuyendiganday = 'no data';
      });
    }
  }

  void loadDSTrangThai() async {
    dsTrangThaiFuture = ApiHelper.getDSTrangThai(chooseChuyenDi);
    dsTrangThai = await dsTrangThaiFuture;
    setState(() {
      for (int i = 0; i < dsTrangThai.data.length; i++) {
        trangthaiCount += dsTrangThai.data[i].soLuong;
      }
    });
  }

  void loadThongTinThem() async {
    thongtinthemFuture = ApiHelper.getThongTinThem(chooseChuyenDi);
    thongtinthem = await thongtinthemFuture;
    if (thongtinthem != null) {
      setState(() {
        value = thongtinthem.data.maChuyenDi;
      });
    }
  }

  void loadLichSuChuyenDi() async {
    LichSuChuyenDiFuture =
        ApiHelper.getLichSuChuyenDi(chuyendiGanday.data.guidChuyenDi);
    lichsuChuyenDi = await LichSuChuyenDiFuture;
  }

  void loadshh(String vl, String s) async {
    tongtien = 0;
    try {
      dshhTheoChuyenDiFuture = ApiHelper.getDSHHTheoChuyenDi(vl,s);
      dshhTheoChuyenDi = await dshhTheoChuyenDiFuture;
      for (int k = 0; k < dshhTheoChuyenDi.data.length; k++) {
        tongtien += dshhTheoChuyenDi.data[k].donGia;
      }
    } catch (ex) {
      // trangthaiCount=0
    }
  }

  void showDSHangTheoChuyenDi() {
    print('value: ' + value);
    List<DataLichSuChuyenDi> lichsulist = lichsuChuyenDi.data;
    var temp = lichsulist.where((element) => element.maChuyenDi == value);
    setState(() {
      chooseChuyenDi = temp.first.guidChuyenDi;
      loadshh(chooseChuyenDi, search);
      loadThongTinThem();
      // loadDSTrangThai();
    });

    print('saaa $chooseChuyenDi');
  }

  @override
  Widget build(BuildContext context) {
    return isAndroid
        ? SafeArea(
            child: Scaffold(
            body: Container(
              padding: EdgeInsets.only(right: 15, top: 15, left: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          height: itemListHeightHang,
                          width: MediaQuery.of(context).size.width *
                              itemListwidthtHang,
                          child: TextFormField(
                            //  controller: searchController,
                            initialValue: search,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(0),
                                prefixIcon: Icon(searchIcon),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(searchBoxRadius)),
                                  borderSide: const BorderSide(
                                    color: searchBoxColor,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                                hintText: 'nhập để tìm kiếm'),
                            onChanged: (vl) {
                              setState(() {
                                search = vl;
                                print('search: $search');
                              });
                              loadshh(chooseChuyenDi, search);
                            },
                          )),
                      GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(right: 5),
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue),
                            child: Center(
                                child: Text(
                              '${trangthaiCount}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Roboto Regular',
                                  fontSize: 14),
                            )),
                          ),
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return checkHaschuyendiganday != 'no data'
                                      ? Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 25, vertical: 30),
                                          height: 200,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              itemBottomSheet(
                                                  Colors.orange,
                                                  '${dsTrangThai.data[0].tenTrangThai}: ',
                                                  '${dsTrangThai.data[0].soLuong}'),
                                              itemBottomSheet(
                                                  Colors.green,
                                                  '${dsTrangThai.data[1].tenTrangThai}: ',
                                                  '${dsTrangThai.data[1].soLuong}'),
                                              itemBottomSheet(
                                                  Colors.red,
                                                  '${dsTrangThai.data[2].tenTrangThai}: ',
                                                  '${dsTrangThai.data[2].soLuong}'),
                                            ],
                                          ))
                                      : Center(
                                          child: Text(
                                            'Không có dữ liệu',
                                            style: TextStyle(
                                                fontFamily: "Roboto Regular",
                                                fontSize: 14),
                                          ),
                                        );
                                });
                          })
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          loadLichSuChuyenDi();
                          // print('you tapped me');
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(
                                    builder: (context, setstate) {
                                  return FutureBuilder(
                                      future: LichSuChuyenDiFuture,
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return Center(
                                              child: Text(
                                            'Không có dữ liệu',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: "Roboto Regular",
                                                fontSize: 14),
                                          ));
                                        } else if (snapshot.hasError) {
                                          return Center(
                                            child: Text('Lỗi',
                                                style: TextStyle(
                                                    fontFamily:
                                                        "Roboto Regular",
                                                    fontSize: 14)),
                                          );
                                        } else if (snapshot.hasData) {
                                          LichSuChuyenDi data = snapshot.data;
                                          List<DataLichSuChuyenDi> lichsulist =
                                              data.data;
                                          return Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 30),
                                            height: 350,
                                            child: Column(
                                              children: [
                                                Text('Lịch sử chuyến đi',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily:
                                                          "Roboto Medium",
                                                      fontSize: 20,
                                                    )),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Expanded(
                                                  child: ListView.builder(
                                                    itemBuilder:
                                                        (context, index) {
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
                                                          setState(() {
                                                            choose = index;
                                                            title = lichsulist[
                                                                    index]
                                                                .maChuyenDi;
                                                            print(title);
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Container(
                                                            height: 45,
                                                            child: Row(
                                                              children: [
                                                                SvgPicture
                                                                    .asset(
                                                                  iconBottomSheet,
                                                                  color: choose ==
                                                                          index
                                                                      ? Colors
                                                                          .blue
                                                                      : Colors
                                                                          .black,
                                                                  width: 17,
                                                                  height: 17,
                                                                ),
                                                                Text(
                                                                  ' ${lichsulist[index].maChuyenDi}',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Roboto Regular",
                                                                      fontSize:
                                                                          14,
                                                                      color: choose ==
                                                                              index
                                                                          ? selectedColor
                                                                          : unselectedColor),
                                                                ),
                                                                Text(' | ',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Roboto Regular",
                                                                        fontSize:
                                                                            14,
                                                                        color: choose ==
                                                                                index
                                                                            ? selectedColor
                                                                            : unselectedColor)),
                                                                Text(
                                                                    '$timeHieuLuc',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Roboto Regular",
                                                                        fontSize:
                                                                            14,
                                                                        color: choose ==
                                                                                index
                                                                            ? selectedColor
                                                                            : unselectedColor))
                                                              ],
                                                            )),
                                                      );
                                                    },
                                                    itemCount:
                                                        lichsulist.length,
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    shrinkWrap: true,
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      });
                                });
                              }).whenComplete(() {
                            if (title == null || title.isEmpty) {
                              setState(() {
                                title = chuyendiGanday.data.maChuyenDi;
                              });
                            }
                            setState(() {
                              value = title;
                              tongtien = 0;
                              trangthaiCount = 0;
                            });
                            showDSHangTheoChuyenDi();
                            loadDSTrangThai();
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(),
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            Text(value != null ? '$value' : '',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Roboto Regular",
                                    fontSize: 14)),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 5),
                              child: RotatedBox(
                                  quarterTurns: 3,
                                  child: Icon(
                                    arrowDown,
                                    size: arrowDownSizehang,
                                  )),
                            )
                          ]),
                        ),
                      ),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: 'Tổng: ',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Roboto Regular",
                                fontSize: 14)),
                        TextSpan(
                            text: '$tongtienđ',
                            style: TextStyle(
                                color: tongtienColor,
                                fontFamily: "Roboto Medium",
                                fontSize: 14)),
                      ]))
                    ],
                  ),
                  checkHaschuyendiganday != 'no data'
                      ? FutureBuilder(
                          future: dshhTheoChuyenDiFuture,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Expanded(
                                child: Center(
                                  child: Text('Không có dữ liệu',
                                      style: TextStyle(
                                          fontFamily: "Roboto Regular",
                                          fontSize: 14)),
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Expanded(
                                child: Center(
                                  child: Text('Lỗi',
                                      style: TextStyle(
                                          fontFamily: "Roboto Regular",
                                          fontSize: 14)),
                                ),
                              );
                            } else if (snapshot.hasData) {
                              DSHHTheoChuyenDi data = snapshot.data;
                              List<DataDSHH> list = data.data;
                              if (!data.status) {
                                return Expanded(
                                  child: Center(
                                    child: Text('Không có hàng trên xe',
                                        style: TextStyle(
                                            fontFamily: "Roboto Regular",
                                            fontSize: 14)),
                                  ),
                                );
                              }
                              return Expanded(
                                  child: ListView.builder(
                                      itemCount: list.length,
                                      itemBuilder: (context, index) {
                                        giaoStatus =
                                            list[index].thoiGianGiaoHangThucTe;
                                        var datetime;
                                        if (list[index]
                                                .thoiGianGiaoHangThucTe ==
                                            null) {
                                          datetime = DateTime.parse(list[index]
                                                  .thoiGianDuKienGiaoHang)
                                              .toLocal();
                                        } else {
                                          datetime = DateTime.parse(list[index]
                                                  .thoiGianGiaoHangThucTe)
                                              .toLocal();
                                        }
                                        String timeHieuLuc =
                                            DateFormat('kk:mm dd/MM/yyyy ')
                                                .format(datetime);
                                        return Container(
                                          margin: EdgeInsets.only(
                                              top: marginItemList),
                                          decoration: BoxDecoration(
                                              color: itemListColor,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 5,
                                                    blurRadius: 7,
                                                    offset: Offset(0, 0))
                                              ],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          padding: EdgeInsets.only(
                                              top: 10,
                                              left: 10,
                                              right: 10,
                                              bottom: 0),
                                          child: Banner(
                                            message: giaoStatus != null
                                                ? 'Đã thu'
                                                : 'Chưa thu',
                                            location: bannerLocation,
                                            color: giaoStatus != null
                                                ? Colors.green
                                                : bannerColorhang,
                                            child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          print('imageeeee');
                                                        },
                                                        child: Image.asset(
                                                          'asset/images/logo.png',
                                                          width:
                                                              imageItemListWidth,
                                                          height: 80,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            itemclick = index;
                                                          });
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => hangDetail(
                                                                      itemclick,
                                                                      list[index]
                                                                          .idNhatKy)));
                                                          print(itemclick);
                                                        },
                                                        child: Container(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              itemListHang(
                                                                  'Trả tại: ',
                                                                  '${list[index].tenDiemNhan}',
                                                                  Colors.black,
                                                                  null),
                                                              itemListHang(
                                                                  'Cước: ',
                                                                  '${list[index].donGia}đ',
                                                                  Colors.orange,
                                                                  null),
                                                              itemListHangPhoneCall(
                                                                  'Người nhận: ',
                                                                  '${list[index].soDienThoaiNguoiNhan}',
                                                                  Colors.blue,
                                                                  TextDecoration
                                                                      .underline,
                                                                  () => _callNumber(
                                                                      list[index]
                                                                          .soDienThoaiNguoiNhan)),
                                                              RichText(
                                                                  text: TextSpan(
                                                                      children: [
                                                                    TextSpan(
                                                                        text:
                                                                            '${list[index].trangThaiVanChuyen} ',
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'Roboto Medium',
                                                                            fontSize:
                                                                                14,
                                                                            color: giaoStatus != null
                                                                                ? Colors.green
                                                                                : bannerColorhang)),
                                                                    giaoStatus !=
                                                                            null
                                                                        ? TextSpan(
                                                                            text:
                                                                                '($timeHieuLuc)',
                                                                            style: TextStyle(
                                                                                fontFamily:
                                                                                    'Roboto Italic',
                                                                                fontSize:
                                                                                    12,
                                                                                color: Colors
                                                                                    .green))
                                                                        : TextSpan(
                                                                            text:
                                                                                '(Dự kiến: $timeHieuLuc)',
                                                                            style: TextStyle(
                                                                                fontFamily: 'Roboto Italic',
                                                                                fontSize: 12,
                                                                                color: Colors.red)),
                                                                  ]))
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Divider(
                                                    thickness: 1.5,
                                                    height: 1,
                                                  ),
                                                  IntrinsicHeight(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                                                      children: [
                                                        FlatButton(
                                                          onPressed: () {},
                                                          child: Text(
                                                              'IN PHIẾU',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Roboto Medium',
                                                                  fontSize: 14,
                                                                  letterSpacing:
                                                                      1.25,
                                                                  color: Colors
                                                                      .blue)),
                                                          height: 20,
                                                          // color: Colors.black,
                                                        ),
                                                        VerticalDivider(
                                                          width: 2,
                                                          thickness: 1.5,
                                                        ),
                                                        FlatButton(
                                                            onPressed:
                                                                giaoStatus !=
                                                                        null
                                                                    ? null
                                                                    : () {
                                                                        showModalBottomSheet(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (context) {
                                                                              return StatefulBuilder(builder: (context, setState) {
                                                                                return Container(
                                                                                  padding: EdgeInsets.all(15),
                                                                                  height: 300,
                                                                                  child: Column(
                                                                                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                    children: [
                                                                                      Align(
                                                                                        alignment: Alignment.topLeft,
                                                                                        child: GestureDetector(
                                                                                            onTap: () {
                                                                                              Navigator.pop(context);
                                                                                            },
                                                                                            child: Text(
                                                                                              'Thoát',
                                                                                              style: TextStyle(
                                                                                                fontSize: 14,
                                                                                                color: Colors.red,
                                                                                                fontFamily: 'Roboto Regular',
                                                                                              ),
                                                                                            )),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: 15,
                                                                                      ),
                                                                                      Text('Xác nhận trả hàng',
                                                                                          style: TextStyle(
                                                                                            fontFamily: 'Roboto Medium',
                                                                                            fontSize: 20,
                                                                                          )),
                                                                                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                                                        Text('Ảnh: ${image.length}/2',
                                                                                            style: TextStyle(
                                                                                              fontFamily: 'Roboto Regular',
                                                                                              fontSize: 14,
                                                                                            )),
                                                                                        Row(children: [
                                                                                          Checkbox(value: false, onChanged: (a) {}),
                                                                                          Text('In phiếu',
                                                                                              style: TextStyle(
                                                                                                fontFamily: 'Roboto Regular',
                                                                                                fontSize: 14,
                                                                                              )),
                                                                                        ]),
                                                                                      ]),
                                                                                      SizedBox(
                                                                                        width: double.infinity,
                                                                                        height: 100,
                                                                                        child: ListView(
                                                                                          scrollDirection: Axis.horizontal,
                                                                                          children: [
                                                                                            ...image.map(
                                                                                              (e) {
                                                                                                return itemImage(e, () {
                                                                                                  setState(
                                                                                                    () {
                                                                                                      image.remove(e);
                                                                                                      count = image.length;
                                                                                                    },
                                                                                                  );
                                                                                                });
                                                                                              },
                                                                                            ),
                                                                                            SizedBox(
                                                                                              width: 5,
                                                                                            ),
                                                                                            image.length < 2
                                                                                                ? Column(
                                                                                                    children: [
                                                                                                      SizedBox(
                                                                                                        height: 10,
                                                                                                      ),
                                                                                                     chooseImage(65, 75, imageitem, image, setState),
                                                                                                    ],
                                                                                                  )
                                                                                                : Text(''),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: 10,
                                                                                      ),
                                                                                      Divider(
                                                                                        thickness: 1.5,
                                                                                        height: 1,
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: 10,
                                                                                      ),
                                                                                      Align(
                                                                                          alignment: Alignment.bottomRight,
                                                                                          child: SizedBox(
                                                                                              height: 28,
                                                                                              child: ElevatedButton(
                                                                                                  onPressed: () async {
                                                                                                    var res = await ApiHelper.postMultipart(servicesAPI.API_HangHoa + 'HangHoa/thuc-hien-giao-tra-hang-hoa', {
                                                                                                      'idNhatKy': '${list[index].idNhatKy}',
                                                                                                      'toaDo': ''
                                                                                                    });
                                                                                                    if (res == 'Uploadd') {
                                                                                                      trangthaiCount = 0;
                                                                                                      loadchuyendiganday();
                                                                                                      Navigator.of(context).pop();
                                                                                                    } else {
                                                                                                      showDialog(
                                                                                                        context: context, barrierDismissible: false, // user must tap button!
                                                                                                        builder: (BuildContext context) {
                                                                                                          return AlertDialog(
                                                                                                            title: const Text('Lỗi',
                                                                                                                style: TextStyle(
                                                                                                                  fontFamily: 'Roboto Medium',
                                                                                                                  fontSize: 18,color: Colors.red
                                                                                                                )),
                                                                                                            content: Text('Lỗi kết nối',
                                                                                                                style: TextStyle(
                                                                                                                  fontFamily: 'Roboto Regular',
                                                                                                                  fontSize: 14,
                                                                                                                )),
                                                                                                            actions: <Widget>[
                                                                                                              TextButton(
                                                                                                                child: const Text(
                                                                                                                  'Đã hiểu',
                                                                                                                  style: TextStyle(
                                                                                                                    fontFamily: 'Roboto Regular',
                                                                                                                    fontSize: 14,
                                                                                                                  ),
                                                                                                                ),
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
                                                                                                  child: Text(
                                                                                                    'XÁC NHẬN',
                                                                                                    style: TextStyle(
                                                                                                      fontFamily: 'Roboto Medium',
                                                                                                      fontSize: 14,
                                                                                                      letterSpacing: 1.25,
                                                                                                    ),
                                                                                                  ))))
                                                                                    ],
                                                                                  ),
                                                                                );
                                                                              });
                                                                            });
                                                                      },
                                                            child: Text(
                                                                'TRẢ HÀNG',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Roboto Medium',
                                                                    fontSize:
                                                                        14,
                                                                    letterSpacing:
                                                                        1.25,
                                                                    color: giaoStatus !=
                                                                            null
                                                                        ? Colors
                                                                            .grey
                                                                        : Colors
                                                                            .blue)),
                                                            height: 20)
                                                      ],
                                                    ),
                                                  )
                                                ]),
                                          ),
                                        );
                                      }));
                            }
                            return Expanded(
                              child: Center(child: CircularProgressIndicator()),
                            );
                          })
                      : Expanded(
                          child: Center(
                          child: Text('Không tìm thấy chuyến đi',
                              style: TextStyle(
                                  fontFamily: "Roboto Regular", fontSize: 14)),
                        ))
                ],
              ),
            ),
            floatingActionButton: checkHaschuyendiganday != 'no data'
                ? FloatingActionButton.extended(
                    elevation: 6,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => layhangInfo(
                                  chuyendiGanday.data.guidLoTrinh,
                                  chooseChuyenDi)));
                    },
                    label: Text('LẤY HÀNG',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontFamily: 'Roboto Medium',
                            letterSpacing: 1.25)),
                    icon: SvgPicture.asset(
                      "asset/icons/goods.svg",
                      width: 16,
                      height: 16,
                      color: Colors.black,
                    ),
                    backgroundColor: Colors.white,
                  )
                : null,
          ))
        : SafeArea(
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(40.0),
                child: AppBar(
                  title: Container(
                      margin: EdgeInsets.only(right: 10),
                      height: itemListHeightHang,
                      width: MediaQuery.of(context).size.width *
                          itemListwidthtHang,
                      child: TextFormField(
                        //  controller: searchController,
                        initialValue: search,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            prefixIcon: Icon(searchIcon),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(searchBoxRadius)),
                              borderSide: const BorderSide(
                                color: searchBoxColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            hintText: 'nhập để tìm kiếm'),
                        onChanged: (vl) {
                          setState(() {
                            search = vl;
                            print('search: $search');
                          });
                          loadshh(chooseChuyenDi, search);
                        },
                      )),
                  centerTitle: true,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  actions: <Widget>[
                    GestureDetector(
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          width: 40,
                          // height: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue),
                          child: Center(
                              child: Text(
                            '${trangthaiCount}',
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return checkHaschuyendiganday != 'no data'
                                    ? Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 25, vertical: 30),
                                        height: 200,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            itemBottomSheet(
                                                Colors.orange,
                                                '${dsTrangThai.data[0].tenTrangThai}: ',
                                                '${dsTrangThai.data[0].soLuong}'),
                                            itemBottomSheet(
                                                Colors.green,
                                                '${dsTrangThai.data[1].tenTrangThai}: ',
                                                '${dsTrangThai.data[1].soLuong}'),
                                            itemBottomSheet(
                                                Colors.red,
                                                '${dsTrangThai.data[2].tenTrangThai}: ',
                                                '${dsTrangThai.data[2].soLuong}'),
                                          ],
                                        ))
                                    : Center(
                                        child: Text(
                                          'Không có dữ liệu',
                                          style: TextStyle(
                                              fontFamily: "Roboto Regular",
                                              fontSize: 14),
                                        ),
                                      );
                              });
                        })
                  ],
                  actionsIconTheme: IconThemeData(
                    color: Colors.pink,
                  ),
                ),
              ),
              body: Container(
                padding: EdgeInsets.only(right: 15, top: 15, left: 15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            loadLichSuChuyenDi();
                            // print('you tapped me');
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return StatefulBuilder(
                                      builder: (context, setstate) {
                                    return FutureBuilder(
                                        future: LichSuChuyenDiFuture,
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return Center(
                                                child: Text(
                                              'Không có dữ liệu',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "Roboto Regular",
                                                  fontSize: 14),
                                            ));
                                          } else if (snapshot.hasError) {
                                            return Center(
                                              child: Text('Lỗi',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          "Roboto Regular",
                                                      fontSize: 14)),
                                            );
                                          } else if (snapshot.hasData) {
                                            LichSuChuyenDi data = snapshot.data;
                                            List<DataLichSuChuyenDi>
                                                lichsulist = data.data;
                                            return Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 15, horizontal: 30),
                                              height: 350,
                                              child: Column(
                                                children: [
                                                  Text('Lịch sử chuyến đi',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily:
                                                            "Roboto Medium",
                                                        fontSize: 20,
                                                      )),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Expanded(
                                                    child: ListView.builder(
                                                      itemBuilder:
                                                          (context, index) {
                                                        var time;

                                                        time = DateTime.parse(
                                                                lichsulist[
                                                                        index]
                                                                    .gioXuatBen)
                                                            .toLocal();

                                                        String timeHieuLuc =
                                                            DateFormat('kk:mm')
                                                                .format(time);
                                                        return GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              choose = index;
                                                              title = lichsulist[
                                                                      index]
                                                                  .maChuyenDi;
                                                              print(title);
                                                            });
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Container(
                                                              height: 45,
                                                              child: Row(
                                                                children: [
                                                                  SvgPicture
                                                                      .asset(
                                                                    iconBottomSheet,
                                                                    color: choose ==
                                                                            index
                                                                        ? Colors
                                                                            .blue
                                                                        : Colors
                                                                            .black,
                                                                    width: 17,
                                                                    height: 17,
                                                                  ),
                                                                  Text(
                                                                    ' ${lichsulist[index].maChuyenDi}',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Roboto Regular",
                                                                        fontSize:
                                                                            14,
                                                                        color: choose ==
                                                                                index
                                                                            ? selectedColor
                                                                            : unselectedColor),
                                                                  ),
                                                                  Text(' | ',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              "Roboto Regular",
                                                                          fontSize:
                                                                              14,
                                                                          color: choose == index
                                                                              ? selectedColor
                                                                              : unselectedColor)),
                                                                  Text(
                                                                      '$timeHieuLuc',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              "Roboto Regular",
                                                                          fontSize:
                                                                              14,
                                                                          color: choose == index
                                                                              ? selectedColor
                                                                              : unselectedColor))
                                                                ],
                                                              )),
                                                        );
                                                      },
                                                      itemCount:
                                                          lichsulist.length,
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      shrinkWrap: true,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          }
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        });
                                  });
                                }).whenComplete(() {
                              if (title == null || title.isEmpty) {
                                setState(() {
                                  title = chuyendiGanday.data.maChuyenDi;
                                });
                              }
                              setState(() {
                                value = title;
                                tongtien = 0;
                                trangthaiCount = 0;
                              });
                              showDSHangTheoChuyenDi();
                              loadDSTrangThai();
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(),
                            child:
                                Row(mainAxisSize: MainAxisSize.min, children: [
                              Text(value != null ? '$value' : '',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Roboto Regular",
                                      fontSize: 14)),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                child: RotatedBox(
                                    quarterTurns: 3,
                                    child: Icon(
                                      arrowDown,
                                      size: arrowDownSizehang,
                                    )),
                              )
                            ]),
                          ),
                        ),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: 'Tổng: ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Roboto Regular",
                                  fontSize: 14)),
                          TextSpan(
                              text: '$tongtienđ',
                              style: TextStyle(
                                  color: tongtienColor,
                                  fontFamily: "Roboto Medium",
                                  fontSize: 14)),
                        ]))
                      ],
                    ),
                    checkHaschuyendiganday != 'no data'
                        ? FutureBuilder(
                            future: dshhTheoChuyenDiFuture,
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Expanded(
                                  child: Center(
                                    child: Text('Không có dữ liệu',
                                        style: TextStyle(
                                            fontFamily: "Roboto Regular",
                                            fontSize: 14)),
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return Expanded(
                                  child: Center(
                                    child: Text('Lỗi',
                                        style: TextStyle(
                                            fontFamily: "Roboto Regular",
                                            fontSize: 14)),
                                  ),
                                );
                              } else if (snapshot.hasData) {
                                DSHHTheoChuyenDi data = snapshot.data;
                                List<DataDSHH> list = data.data;
                                if (!data.status) {
                                  return Expanded(
                                    child: Center(
                                      child: Text('Không có hàng trên xe',
                                          style: TextStyle(
                                              fontFamily: "Roboto Regular",
                                              fontSize: 14)),
                                    ),
                                  );
                                }
                                return Expanded(
                                    child: ListView.builder(
                                        itemCount: list.length,
                                        itemBuilder: (context, index) {
                                          giaoStatus = list[index]
                                              .thoiGianGiaoHangThucTe;
                                          var datetime;
                                          if (list[index]
                                                  .thoiGianGiaoHangThucTe ==
                                              null) {
                                            datetime = DateTime.parse(
                                                    list[index]
                                                        .thoiGianDuKienGiaoHang)
                                                .toLocal();
                                          } else {
                                            datetime = DateTime.parse(
                                                    list[index]
                                                        .thoiGianGiaoHangThucTe)
                                                .toLocal();
                                          }
                                          String timeHieuLuc =
                                              DateFormat('kk:mm dd/MM/yyyy ')
                                                  .format(datetime);
                                          return Container(
                                            margin: EdgeInsets.only(
                                                top: marginItemList),
                                            decoration: BoxDecoration(
                                                color: itemListColor,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 5,
                                                      blurRadius: 7,
                                                      offset: Offset(0, 0))
                                                ],
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            padding: EdgeInsets.only(
                                                top: 10,
                                                left: 10,
                                                right: 10,
                                                bottom: 0),
                                            child: Banner(
                                              message: giaoStatus != null
                                                  ? 'Đã thu'
                                                  : 'Chưa thu',
                                              location: bannerLocation,
                                              color: giaoStatus != null
                                                  ? Colors.green
                                                  : bannerColorhang,
                                              child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            print('image');
                                                          },
                                                          child: Image.asset(
                                                            'asset/images/logo.png',
                                                            width:
                                                                imageItemListWidth,
                                                            height: 80,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              itemclick = index;
                                                            });
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => hangDetail(
                                                                        itemclick,
                                                                        list[index]
                                                                            .idNhatKy)));
                                                            print(itemclick);
                                                          },
                                                          child: Container(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                itemListHang(
                                                                    'Trả tại: ',
                                                                    '${list[index].tenDiemNhan}',
                                                                    Colors
                                                                        .black,
                                                                    null),
                                                                itemListHang(
                                                                    'Cước: ',
                                                                    '${list[index].donGia}đ',
                                                                    Colors
                                                                        .orange,
                                                                    null),
                                                                itemListHangPhoneCall(
                                                                    'Người nhận: ',
                                                                    '${list[index].soDienThoaiNguoiNhan}',
                                                                    Colors.blue,
                                                                    TextDecoration
                                                                        .underline,
                                                                    () => _callNumber(
                                                                        list[index]
                                                                            .soDienThoaiNguoiNhan)),
                                                                RichText(
                                                                    text: TextSpan(
                                                                        children: [
                                                                      TextSpan(
                                                                          text:
                                                                              '${list[index].trangThaiVanChuyen} ',
                                                                          style: TextStyle(
                                                                              fontFamily: 'Roboto Medium',
                                                                              fontSize: 14,
                                                                              color: giaoStatus != null ? Colors.green : bannerColorhang)),
                                                                      giaoStatus !=
                                                                              null
                                                                          ? TextSpan(
                                                                              text: '($timeHieuLuc)',
                                                                              style: TextStyle(fontFamily: 'Roboto Italic', fontSize: 12, color: Colors.green))
                                                                          : TextSpan(text: '(Dự kiến: $timeHieuLuc)', style: TextStyle(fontFamily: 'Roboto Italic', fontSize: 12, color: Colors.red)),
                                                                    ]))
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Divider(
                                                      thickness: 1.5,
                                                      height: 1,
                                                    ),
                                                    IntrinsicHeight(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        // crossAxisAlignment: CrossAxisAlignment.stretch,
                                                        children: [
                                                          FlatButton(
                                                            onPressed: () {
                                                              printpopup.showpopup(context, listprint);
                                                            },
                                                            child: Text(
                                                                'IN PHIẾU',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Roboto Medium',
                                                                    fontSize:
                                                                        14,
                                                                    letterSpacing:
                                                                        1.25,
                                                                    color: Colors
                                                                        .blue)),
                                                            height: 20,
                                                            // color: Colors.black,
                                                          ),
                                                          VerticalDivider(
                                                            width: 2,
                                                            thickness: 1.5,
                                                          ),
                                                          FlatButton(
                                                              onPressed:
                                                                  giaoStatus !=
                                                                          null
                                                                      ? null
                                                                      : () {
                                                                          showModalBottomSheet(
                                                                              context: context,
                                                                              builder: (context) {
                                                                                return StatefulBuilder(builder: (context, setState) {
                                                                                  return Container(
                                                                                    padding: EdgeInsets.all(15),
                                                                                    height: 300,
                                                                                    child: Column(
                                                                                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                      children: [
                                                                                        Align(
                                                                                          alignment: Alignment.topLeft,
                                                                                          child: GestureDetector(
                                                                                              onTap: () {
                                                                                                Navigator.pop(context);
                                                                                              },
                                                                                              child: Text(
                                                                                                'Thoát',
                                                                                                style: TextStyle(
                                                                                                  fontSize: 14,
                                                                                                  color: Colors.red,
                                                                                                  fontFamily: 'Roboto Regular',
                                                                                                ),
                                                                                              )),
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: 15,
                                                                                        ),
                                                                                        Text('Xác nhận trả hàng',
                                                                                            style: TextStyle(
                                                                                              fontFamily: 'Roboto Medium',
                                                                                              fontSize: 20,
                                                                                            )),
                                                                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                                                          Text('Ảnh: ${image.length}/2',
                                                                                              style: TextStyle(
                                                                                                fontFamily: 'Roboto Regular',
                                                                                                fontSize: 14,
                                                                                              )),
                                                                                          Row(children: [
                                                                                            Checkbox(value: false, onChanged: (a) {}),
                                                                                            Text('In phiếu',
                                                                                                style: TextStyle(
                                                                                                  fontFamily: 'Roboto Regular',
                                                                                                  fontSize: 14,
                                                                                                )),
                                                                                          ]),
                                                                                        ]),
                                                                                        SizedBox(
                                                                                          width: double.infinity,
                                                                                          height: 100,
                                                                                          child: ListView(
                                                                                            scrollDirection: Axis.horizontal,
                                                                                            children: [
                                                                                              ...image.map(
                                                                                                (e) {
                                                                                                  return itemImage(e, () {
                                                                                                    setState(
                                                                                                      () {
                                                                                                        image.remove(e);
                                                                                                        count = image.length;
                                                                                                      },
                                                                                                    );
                                                                                                  });
                                                                                                },
                                                                                              ),
                                                                                              SizedBox(
                                                                                                width: 5,
                                                                                              ),
                                                                                              image.length < 2
                                                                                                  ? Column(
                                                                                                      children: [
                                                                                                        SizedBox(
                                                                                                          height: 10,
                                                                                                        ),
                                                                                                        chooseImage(65, 75, imageitem, image, setState),
                                                                                                      ],
                                                                                                    )
                                                                                                  : Text(''),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: 10,
                                                                                        ),
                                                                                        Divider(
                                                                                          thickness: 1.5,
                                                                                          height: 1,
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: 10,
                                                                                        ),
                                                                                        Align(
                                                                                            alignment: Alignment.bottomRight,
                                                                                            child: SizedBox(
                                                                                                height: 28,
                                                                                                child: ElevatedButton(
                                                                                                    onPressed: () async {
                                                                                                      var res = await ApiHelper.postMultipart(servicesAPI.API_HangHoa + 'HangHoa/thuc-hien-giao-tra-hang-hoa', {
                                                                                                        'idNhatKy': '${list[index].idNhatKy}',
                                                                                                        'toaDo': ''
                                                                                                      });
                                                                                                      if (res == 'Uploadd') {
                                                                                                        trangthaiCount = 0;
                                                                                                        loadchuyendiganday();
                                                                                                        Navigator.of(context).pop();
                                                                                                        printpopup.showpopup(context, listprint);
                                                                                                      } else {
                                                                                                        showDialog(
                                                                                                          context: context, barrierDismissible: false, // user must tap button!
                                                                                                          builder: (BuildContext context) {
                                                                                                            return AlertDialog(
                                                                                                              title: const Text('Lỗi',
                                                                                                                  style: TextStyle(
                                                                                                                    fontFamily: 'Roboto Medium',
                                                                                                                    fontSize: 18,color: Colors.red
                                                                                                                  )),
                                                                                                              content: Text('Lỗi kết nối',
                                                                                                                  style: TextStyle(
                                                                                                                    fontFamily: 'Roboto Regular',
                                                                                                                    fontSize: 14,
                                                                                                                  )),
                                                                                                              actions: <Widget>[
                                                                                                                TextButton(
                                                                                                                  child: const Text(
                                                                                                                    'Đã hiểu',
                                                                                                                    style: TextStyle(
                                                                                                                      fontFamily: 'Roboto Regular',
                                                                                                                      fontSize: 14,
                                                                                                                    ),
                                                                                                                  ),
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
                                                                                                    child: Text(
                                                                                                      'XÁC NHẬN',
                                                                                                      style: TextStyle(
                                                                                                        fontFamily: 'Roboto Medium',
                                                                                                        fontSize: 14,
                                                                                                        letterSpacing: 1.25,
                                                                                                      ),
                                                                                                    ))))
                                                                                      ],
                                                                                    ),
                                                                                  );
                                                                                });
                                                                              });
                                                                        },
                                                              child: Text(
                                                                  'TRẢ HÀNG',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Roboto Medium',
                                                                      fontSize:
                                                                          14,
                                                                      letterSpacing:
                                                                          1.25,
                                                                      color: giaoStatus !=
                                                                              null
                                                                          ? Colors
                                                                              .grey
                                                                          : Colors
                                                                              .blue)),
                                                              height: 20)
                                                        ],
                                                      ),
                                                    )
                                                  ]),
                                            ),
                                          );
                                        }));
                              }
                              return Expanded(
                                child:
                                    Center(child: CircularProgressIndicator()),
                              );
                            })
                        : Expanded(
                            child: Center(
                            child: Text('Không tìm thấy chuyến đi',
                                style: TextStyle(
                                    fontFamily: "Roboto Regular",
                                    fontSize: 14)),
                          ))
                  ],
                ),
              ),
              floatingActionButton: checkHaschuyendiganday != 'no data'
                  ? FloatingActionButton.extended(
                      elevation: 6,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => layhangInfo(
                                    chuyendiGanday.data.guidLoTrinh,
                                    chooseChuyenDi)));
                      },
                      label: Text('LẤY HÀNG',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: 'Roboto Medium',
                              letterSpacing: 1.25)),
                      icon: SvgPicture.asset(
                        "asset/icons/goods.svg",
                        width: 16,
                        height: 16,
                        color: Colors.black,
                      ),
                      backgroundColor: Colors.white,
                    )
                  : null,
            ),
          );
  }

//String title1,String title2,Color color,
  RichText itemListHang(
      String title1, String title2, Color color, TextDecoration deco) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: title1,
          style: TextStyle(
              color: Colors.black, fontFamily: "Roboto Regular", fontSize: 14)),
      TextSpan(
          text: title2,
          style: TextStyle(
            fontFamily: "Roboto Medium",
            fontSize: 14,
            color: color,
            decoration: deco,
          )),
    ]));
  }

  Row itemListHangPhoneCall(String title1, String title2, Color color,
      TextDecoration deco, Function ontap) {
    return Row(
      children: [
        Text(title1,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Roboto Regular',
              fontSize: 12,
            )),
        GestureDetector(
          onTap: ontap,
          child: Text(title2,
              style: TextStyle(
                fontFamily: 'Roboto Medium',
                fontSize: 14,
                color: color,
                decoration: deco,
              )),
        )
      ],
    );
  }

  Stack itemImage(XFile imagedata, Function onDelete) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: Container(
            height: 79,
            width: 65,
            child: Image.file(
              File(imagedata.path),
              height: 50,
              width: 45,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 66,
          left: 49,
          child: IconButton(
            icon: SvgPicture.asset(
              'asset/icons/cancel.svg',
              width: 20,
              height: 20,
            ),
            onPressed: onDelete,
          ),
        )
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
            '$value',
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Roboto Regular',
                fontSize: 14),
          )),
        ),
        Text(
          title,
          style: TextStyle(
              color: Colors.black, fontFamily: 'Roboto Regular', fontSize: 14),
        ),
        Text(
          value,
          style: TextStyle(
              color: Colors.black, fontFamily: 'Roboto Regular', fontSize: 14),
        ),
      ],
    );
  }

  void _callNumber(String phoneNumber) async {
    String url = "tel://" + phoneNumber;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not call $phoneNumber';
    }
  }
}
