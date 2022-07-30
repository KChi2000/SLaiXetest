import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_ui_kit/helpers/ApiHelper.dart';
import 'package:flutter_ui_kit/model/chuyendiList.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/DSHHTheoChuyenDi.dart';
import '../model/DSTrangThai.dart';
import '../model/LichSuChuyenDi.dart';
import '../model/ThongTinThem.dart';
import '../model/chuyendiganday.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadchuyendiganday();
  }

  void loadchuyendiganday() async {
    chuyendigandayFuture = ApiHelper.getchuyendiganday();
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
  }

  void loadDSTrangThai() async {
    dsTrangThaiFuture = ApiHelper.getDSTrangThai(
        'http://113.176.29.57:19666/api/HangHoa/lay-danh-sach-trang-thai-van-chuyen?idChuyenDi=${chooseChuyenDi}');
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
    LichSuChuyenDiFuture = ApiHelper.getLichSuChuyenDi(
        'http://113.176.29.57:19666/api/ChuyenDi/lay-danh-sach-lich-su-chuyen-di-cua-lai-xe?GuidChuyenDi=${chuyendiGanday.data.guidChuyenDi}');
    lichsuChuyenDi = await LichSuChuyenDiFuture;
  }

  void loadshh(String vl, String s) async {
    tongtien = 0;
    dshhTheoChuyenDiFuture = ApiHelper.getDSHHTheoChuyenDi(
        'http://113.176.29.57:19666/api/HangHoa/lay-danh-sach-hang-hoa-theo-chuyen-di?idChuyenDi=${vl}&timKiem=${s}');
    dshhTheoChuyenDi = await dshhTheoChuyenDiFuture;
    for (int k = 0; k < dshhTheoChuyenDi.data.length; k++) {
      tongtien += dshhTheoChuyenDi.data[k].donGia;
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
    // title = moveList.first.name;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: AppBar(
            title: Container(
                height: itemListHeightHang,
                width: MediaQuery.of(context).size.width * itemListwidthtHang,
                child: TextFormField(
                  //  controller: searchController,
                  initialValue: search,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      prefixIcon: Icon(searchIcon),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(searchBoxRadius)),
                        borderSide: const BorderSide(
                          color: searchBoxColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
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
                    margin: EdgeInsets.only(right: 5),
                    width: 40,
                    // height: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue),
                    child: Center(
                        child: Text(
                      '${trangthaiCount}',
                      style: TextStyle(color: Colors.black),
                    )),
                  ),
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return chuyendiGanday.status
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
                                          'Chưa giao: ',
                                          '${dsTrangThai.data[0].soLuong}'),
                                      itemBottomSheet(Colors.green, 'Đã giao: ',
                                          '${dsTrangThai.data[1].soLuong}'),
                                      itemBottomSheet(Colors.red, 'Hủy: ',
                                          '${dsTrangThai.data[2].soLuong}'),
                                    ],
                                  ))
                              : Center(
                                  child: Text('Không có dữ liệu'),
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
                                        style: TextStyle(color: Colors.black),
                                      ));
                                    } else if (snapshot.hasError) {
                                      return Center(
                                        child: Text('Lỗi'),
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
                                                    fontWeight:
                                                        fontStyleTitleBottomSheet,
                                                    fontSize:
                                                        fontsizetitleBottomSheet)),
                                            SizedBox(
                                              height: 10,
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
                                                      setState(() {
                                                        choose = index;
                                                        title =
                                                            lichsulist[index]
                                                                .maChuyenDi;
                                                        print(title);
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                        height: 45,
                                                        child: Row(
                                                          children: [
                                                            SvgPicture.asset(
                                                              iconBottomSheet,
                                                              color: choose ==
                                                                      index
                                                                  ? Colors.blue
                                                                  : Colors
                                                                      .black,
                                                              width: 17,
                                                              height: 17,
                                                            ),
                                                            Text(
                                                              ' ${lichsulist[index].maChuyenDi}',
                                                              style: TextStyle(
                                                                  color: choose ==
                                                                          index
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
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Text(value != null ? '$value' : ''),
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
                        text: 'Tổng: ', style: TextStyle(color: Colors.black)),
                    TextSpan(
                        text: '$tongtienđ',
                        style: TextStyle(
                            color: tongtienColor, fontWeight: FontWeight.bold)),
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
                              child: Text('Không có dữ liệu'),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Expanded(
                            child: Center(
                              child: Text('Lỗi'),
                            ),
                          );
                        } else if (snapshot.hasData) {
                          DSHHTheoChuyenDi data = snapshot.data;
                          List<DataDSHH> list = data.data;
                          if (!data.status) {
                            return Expanded(
                              child: Center(
                                child: Text('Không có hàng trên xe'),
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
                                    if (list[index].thoiGianGiaoHangThucTe ==
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
                                      margin:
                                          EdgeInsets.only(top: marginItemList),
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
                                                      print('image');
                                                    },
                                                    child: Image.asset(
                                                      'asset/images/11.jpg',
                                                      width: imageItemListWidth,
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
                                                              builder: (context) =>
                                                                  hangDetail(
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
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: giaoStatus !=
                                                                                null
                                                                            ? Colors.green
                                                                            : bannerColorhang)),
                                                                giaoStatus != null
                                                                    ? TextSpan(
                                                                        text:
                                                                            '($timeHieuLuc)',
                                                                        style: TextStyle(
                                                                            fontStyle: FontStyle
                                                                                .italic,
                                                                            fontSize:
                                                                                12,
                                                                            color: Colors
                                                                                .green))
                                                                    : TextSpan(
                                                                        text:
                                                                            '(Dự kiến: $timeHieuLuc)',
                                                                        style: TextStyle(
                                                                            fontStyle: FontStyle
                                                                                .italic,
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                Colors.red)),
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
                                                      child: Text('IN PHIẾU',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.blue)),
                                                      height: 20,
                                                      // color: Colors.black,
                                                    ),
                                                    VerticalDivider(
                                                      width: 2,
                                                      thickness: 1.5,
                                                    ),
                                                    FlatButton(
                                                        onPressed:
                                                            giaoStatus != null
                                                                ? null
                                                                : () {
                                                                    showModalBottomSheet(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) {
                                                                          return StatefulBuilder(builder: (context,setState){
                                                                            return Container(
                                                                            padding:
                                                                                EdgeInsets.all(15),
                                                                            height:
                                                                                300,
                                                                            child:
                                                                                Column(
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
                                                                                        style: TextStyle(fontSize: 15, color: Colors.red),
                                                                                      )),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 15,
                                                                                ),
                                                                                Text(
                                                                                  'Xác nhận trả hàng',
                                                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                                                                ),
                                                                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                                                  Text('Ảnh: 0/2'),
                                                                                  Row(children: [
                                                                                    Checkbox(value: false, onChanged: (a) {}),
                                                                                    Text('In phiếu'),
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
                                                                                      SizedBox(width: 5,),
                                                                                      image.length < 2
                                                                                          ? Column(
                                                                                              children: [
                                                                                                SizedBox(
                                                                                                  height: 10,
                                                                                                ),
                                                                                                GestureDetector(
                                                                                                  child: Align(
                                                                                                    alignment: Alignment.topLeft,
                                                                                                    child: DottedBorder(
                                                                                                      child: Container(
                                                                                                        height: 75,
                                                                                                        width: 65,
                                                                                                        child: Center(
                                                                                                            child: SvgPicture.asset(
                                                                                                          'asset/icons/camera-plus.svg',
                                                                                                          color: Colors.black54,
                                                                                                        )),
                                                                                                      ),
                                                                                                      color: Colors.black54,
                                                                                                      strokeWidth: 1,
                                                                                                      radius: Radius.circular(10),
                                                                                                    ),
                                                                                                  ),
                                                                                                  onTap: () {
                                                                                                    return showDialog(
                                                                                                        context: context,
                                                                                                        builder: (context) {
                                                                                                          return AlertDialog(
                                                                                                            content: Container(
                                                                                                              width: 60,
                                                                                                              child: Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                                                                GestureDetector(
                                                                                                                  child: Text('Chụp ảnh mới'),
                                                                                                                  onTap: () async {
                                                                                                                    print('chọn chụp ảnh');
                                                                                                                    Navigator.pop(context);
                                                                                                                    imageitem = await ImagePicker().pickImage(source: ImageSource.camera);
                                                                                                                    if (imageitem == null) {
                                                                                                                      return;
                                                                                                                    }

                                                                                                                    setState(() {
                                                                                                                      image.add(imageitem);
                                                                                                                      count = image.length;
                                                                                                                    });
                                                                                                                    print('count: $count');
                                                                                                                  },
                                                                                                                ),
                                                                                                                SizedBox(
                                                                                                                  height: 20,
                                                                                                                ),
                                                                                                                GestureDetector(
                                                                                                                  child: Text('Chọn ảnh'),
                                                                                                                  onTap: () async {
                                                                                                                    print('chọn ảnh');
                                                                                                                    Navigator.pop(context);
                                                                                                                    imageitem = await ImagePicker().pickImage(source: ImageSource.gallery);
                                                                                                                    if (imageitem == null) {
                                                                                                                      return;
                                                                                                                    }
                                                                                                                    // image.add(imageitem);
                                                                                                                    setState(() {
                                                                                                                      image.add(imageitem);
                                                                                                                      count = image.length;
                                                                                                                    });
                                                                                                                    print('count: $count');
                                                                                                                  },
                                                                                                                ),
                                                                                                              ]),
                                                                                                            ),
                                                                                                          );
                                                                                                        });
                                                                                                  },
                                                                                                ),
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
                                                                                              var res = await ApiHelper.postMultipart('http://113.176.29.57:19666/api/HangHoa/thuc-hien-giao-tra-hang-hoa', {
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
                                                                                                      title: const Text('Lỗi'),
                                                                                                      content: Text('Lỗi kết nối'),
                                                                                                      actions: <Widget>[
                                                                                                        TextButton(
                                                                                                          child: const Text('Đã hiểu'),
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
                                                                                            child: Text('XÁC NHẬN'))))
                                                                              ],
                                                                            ),
                                                                          );
                                                                          });
                                                                        });
                                                                  },
                                                        child: Text('TRẢ HÀNG',
                                                            style: TextStyle(
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
                      child: Text('Không tìm thấy chuyến đi'),
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
                    style: TextStyle(fontSize: 12, color: Colors.black)),
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
      TextSpan(text: title1, style: TextStyle(color: Colors.black)),
      TextSpan(
          text: title2,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
            decoration: deco,
          )),
    ]));
  }

  Row itemListHangPhoneCall(String title1, String title2, Color color,
      TextDecoration deco, Function ontap) {
    return Row(
      children: [
        Text(title1, style: TextStyle(color: Colors.black)),
        GestureDetector(
          onTap: ontap,
          child: Text(title2,
              style: TextStyle(
                fontWeight: FontWeight.bold,
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

  void _callNumber(String phoneNumber) async {
    String url = "tel://" + phoneNumber;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not call $phoneNumber';
    }
  }
}
