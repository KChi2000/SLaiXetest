import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:flutter_ui_kit/helpers/ApiHelper.dart';
import 'package:flutter_ui_kit/lenh/AnhLenh.dart';
import 'package:flutter_ui_kit/lenh/dunglenhthanhcong.dart';
import 'package:flutter_ui_kit/model/KhachTrenXe.dart';
import 'package:flutter_ui_kit/servicesAPI.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../components/chooseImage.dart';
import '../lenh/chuyendoilenh.dart';
import '../lenh/lenhvanchuyenList.dart';
import '../model/lenhModel.dart';
import '../other/homeConstant.dart';
import 'package:intl/intl.dart';

class Lenh extends StatefulWidget {
  ChiTietLenh chitietlenh;
  Lenh(this.chitietlenh);
  @override
  LenhState createState() {
    return LenhState();
  }
}

class LenhState extends State<Lenh> {
  bool activefab = false;
  XFile imageitem;
  List<XFile> image = [];
  final formkey = GlobalKey<FormState>();
  final lidoController = TextEditingController();
  var chitietlenhFuture;
  // ChiTietLenh chitietlenh;
  var khachTrenXeFuture;
  KhachTrenXe khachtrenxe;
  var datetime;
  String timeHieuLuc;
  int count = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadChiTietLenh();
  }

  void loadChiTietLenh() async {
    convertDateTime();
    print('object ${widget.chitietlenh.data.guidLenh}');
    if (widget.chitietlenh != null) {
      khachTrenXeFuture =
          ApiHelper.getKhachTrenXe(widget.chitietlenh.data.guidLenh);
    }
    setState(() {});
    print(' chi tiet lenh ${widget.chitietlenh.data.maTuyen}');
  }

  void convertDateTime() {
    datetime = DateTime.parse(widget.chitietlenh.data.hieuLucDenNgay).toLocal();
    timeHieuLuc = DateFormat('kk:mm dd-MM-yyyy ').format(datetime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            appbarTitle,
            style: TextStyle(
              color: titleColor,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
              icon: SvgPicture.asset(
                'asset/icons/close.svg',
                color: appbarIconColor,
                width: appbarIconSize,
                height: appbarIconSize,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => lenhvanchuyenList()));
              }),
        ),
        body: FutureBuilder<KhachTrenXe>(
          future: khachTrenXeFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              KhachTrenXe snapshotdata = snapshot.data;
              return Banner(
                message: '${widget.chitietlenh.data.trangThai}',
                location: bannerLocation,
                color: bannerColor,
                child: Container(
                  padding: EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AnhLenh(
                                      widget.chitietlenh.data.guidLenh)));
                        },
                        child: Text(
                          '${widget.chitietlenh.data.maLenh}',
                          style: TextStyle(
                              color: Colors.blue,
                              fontFamily: 'Roboto Medium',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                      QrImage(
                        data: widget.chitietlenh.data.qrCode.toString(),
                        size: 185,
                      ),
                      Text('${widget.chitietlenh.data.bienKiemSoat}',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Roboto Medium',
                            fontSize: 16,
                          )),
                      Text('$timeHieuLuc',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Roboto Italic',
                            fontSize: 14,
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      itemRowLenh('Mã tuyến',
                          '${widget.chitietlenh.data.maTuyen}', valueTextColor),
                      SizedBox(
                        height: spacerItem,
                      ),
                      itemRowLenh('Tên bến đi',
                          '${widget.chitietlenh.data.benDi}', valueTextColor),
                      SizedBox(
                        height: spacerItem,
                      ),
                      itemRowLenh('Tên bến đến',
                          '${widget.chitietlenh.data.benDen}', valueTextColor),
                      SizedBox(
                        height: spacerItem,
                      ),
                      itemRowLenh(
                          'Số khách đã mua vé',
                          '${snapshotdata.data.soKhachMuaVe}',
                          numberPassengerBuyTicketColor),
                      SizedBox(
                        height: spacerItem,
                      ),
                      itemRowLenh(
                          'Số khách trên xe',
                          '${snapshotdata.data.soKhachTrenXe}',
                          numberPassengeronBusColor),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Lỗi !',
                    style:
                        TextStyle(fontSize: 14, fontFamily: 'Roboto Regular')),
              );
            }
            return Center(
              child: Text('Không có dữ liệu !',
                  style: TextStyle(fontSize: 14, fontFamily: 'Roboto Regular')),
            );
          },
        ),
        floatingActionButton: widget.chitietlenh != null
            ? SpeedDial(
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
                        print('chuyn doi lenh');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => chuyndoilenh(
                                    widget.chitietlenh.data.guidLenh)));
                      },
                      label: 'Chuyển đổi lệnh',
                      child: Icon(
                        Icons.change_circle_sharp,
                        color: Colors.black,
                      )),
                  SpeedDialChild(
                      // backgroundColor: Colors.red,
                      onTap: () {
                        image = [];
                        count = 0;
                        showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(
                                  builder: (context, setState) {
                                return Padding(
                                  padding: MediaQuery.of(context).viewInsets,
                                  child: Container(
                                    padding: EdgeInsets.all(15),
                                    height: 350,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                                  fontFamily: 'Roboto Regular',
                                                  fontSize: 14,
                                                )),
                                          ),
                                        ),
                                        Text('Dừng hành trình',
                                            style: TextStyle(
                                              fontFamily: 'Roboto Bold',
                                              fontSize: 20,
                                            )),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Row(children: [
                                          Text('Mã số lệnh: ',
                                              style: TextStyle(
                                                fontFamily: 'Roboto Regular',
                                                fontSize: 12,
                                              )),
                                          Text(
                                              '${widget.chitietlenh.data.maLenh}',
                                              style: TextStyle(
                                                fontFamily: 'Roboto Regular',
                                                fontSize: 16,
                                              )),
                                        ]),
                                        Form(
                                          key: formkey,
                                          child: TextFormField(
                                            controller: lidoController,
                                            decoration: InputDecoration(
                                                labelText: 'Dừng vì lí do()*'),
                                            validator: (vl) {
                                              if (vl == null || vl.isEmpty) {
                                                return 'Chưa nhập lí do';
                                              } else
                                                return null;
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: RichText(
                                                text: TextSpan(children: [
                                              TextSpan(
                                                  text: 'Hình ảnh cho sự cố ',
                                                  style: TextStyle(
                                                    fontFamily: 'Roboto Bold',
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                  )),
                                              TextSpan(
                                                  text: '${image.length}/3',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'Roboto Regular',
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                  )),
                                            ]))),
                                        SizedBox(
                                          height: 0,
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: ListView(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              children: [
                                                ...image.map(
                                                  (e) {
                                                    return itemImage(e, () {
                                                      setState(
                                                        () {
                                                          image.remove(e);
                                                        },
                                                      );
                                                    });
                                                  },
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                image.length < 3
                                                    ? Column(
                                                        children: [
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          chooseImage(
                                                              50,
                                                              55,
                                                              imageitem,
                                                              image,
                                                              setState)
                                                        ],
                                                      )
                                                    : Text(''),
                                              ],
                                            ),
                                          ),
                                        ),
                                        RaisedButton(
                                          onPressed: () async {
                                            if (formkey.currentState
                                                .validate()) {
                                              var resp =
                                                  await ApiHelper.postMultipart(
                                                      servicesAPI
                                                              .API_LenhDienTu +
                                                          'lai-xe-dung-hanh-trinh',
                                                      {
                                                    'guidLenh':
                                                        '${widget.chitietlenh.data.guidLenh}',
                                                    'lyDo':
                                                        '${lidoController.text}',
                                                    'ToaDo': ''
                                                  });
                                              if (resp == 'Uploadd') {
                                                Navigator.pop(context);
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            dunglenhthanhcong(widget
                                                                .chitietlenh
                                                                .data
                                                                .tenDoanhNghiep)));
                                              } else {
                                                Navigator.pop(context);
                                                showDialog(
                                                  context: context,
                                                  barrierDismissible:
                                                      false, // user must tap button!
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text('Lỗi',
                                                          style: TextStyle(
                                                              fontSize: 18,color: Colors.red,
                                                              fontFamily:
                                                                  'Roboto Regular')),
                                                      content: Text(
                                                          'Lỗi dừng hành trình',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  'Roboto Regular')),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          child: const Text(
                                                              'Đã hiểu',
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontFamily:
                                                                      'Roboto Regular')),
                                                          onPressed: () {
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
                                            }
                                          },
                                          child: Text('XÁC NHẬN',
                                              style: TextStyle(
                                                fontFamily: 'Roboto Medium',
                                                fontSize: 14,
                                                letterSpacing: 1.25,
                                                color: Colors.white,
                                              )),
                                          color: Colors.blue,
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                            });
                        print('dung hanh trinh');
                      },
                      label: 'Dừng hành trình',
                      child: Icon(Icons.stop, color: Colors.black))
                ],
              )
            : null);
  }

  Stack itemImage(XFile imagedata, Function onDelete) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: Container(
            height: 60,
            width: 50,
            child: Image.file(
              File(imagedata.path),
              height: 50,
              width: 45,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 80,
          left: 35,
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

  Row itemRowLenh(String title, String name, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('$title',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Roboto Regular',
              fontSize: 14,
            )),
        Text('$name',
            style: TextStyle(
              color: color,
              fontFamily: 'Roboto Medium',
              fontSize: 14,
            )),
      ],
    );
  }
}


