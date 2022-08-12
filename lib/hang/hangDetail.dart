import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_ui_kit/components/chooseImage.dart';
import 'package:flutter_ui_kit/helpers/ApiHelper.dart';
import 'package:flutter_ui_kit/servicesAPI.dart';
import 'package:flutter_ui_kit/uikit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../model/LayChiTietNhatKyVanChuyen.dart';
import 'package:intl/intl.dart';

class hangDetail extends StatefulWidget {
  int num;
  String idnhatki;
  hangDetail(this.num, this.idnhatki);

  @override
  State<hangDetail> createState() => _hangDetailState();
}

class _hangDetailState extends State<hangDetail> {
  var chitietnhatkyFuture;
  XFile imageitem;
  List<XFile> image = [];
  int count;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('ahihi ' + widget.idnhatki);
    if (widget.idnhatki != null || !(widget.idnhatki.isEmpty)) {
      loadchitietNhatky(widget.idnhatki);
    }
  }

  void loadchitietNhatky(String idNhatKi) {
    chitietnhatkyFuture = ApiHelper.getLayChiTietNhatKyVanChuyen(idNhatKi);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('XEM CHI TIẾT'),
      ),
      body: FutureBuilder<LayChiTietNhatKyVanChuyen>(
        future: chitietnhatkyFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Lỗi'),
            );
          } else if (snapshot.hasData) {
            LayChiTietNhatKyVanChuyen chitietnhatky = snapshot.data;
            DataNhatKyChiTiet datachitiet = chitietnhatky.data;
            var datetime;
            if (datachitiet.thoiGianGiaoHangThucTe == null ||
                datachitiet.thoiGianGiaoHangThucTe.isEmpty) {
              print('nulllllll');
              datetime =
                  DateTime.parse(datachitiet.thoiGianGiaoHangDuKien).toLocal();
            } else {
              datetime =
                  DateTime.parse(datachitiet.thoiGianGiaoHangThucTe).toLocal();
            }
            String datetimegiaohang =
                DateFormat('kk:mm dd/MM/yyyy ').format(datetime);
            return Banner(
              message: '${datachitiet.trangThaiThanhToan}',
              location: BannerLocation.topEnd,
              color: datachitiet.thoiGianGiaoHangThucTe != null
                  ? Colors.green
                  : Colors.pink[800],
              child: Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                     
                      Center(child: QrImage(data: datachitiet.linkTraCuu,size: 150,)),
                      Center(
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: '${datachitiet.trangThaiVanChuyen}',
                              style: TextStyle(
                                  fontFamily: 'Roboto Medium',
                                  color:
                                      datachitiet.thoiGianGiaoHangThucTe != null
                                          ? Colors.green
                                          : Colors.red)),
                          TextSpan(
                              text: datachitiet.thoiGianGiaoHangThucTe != null
                                  ? '($datetimegiaohang)'
                                  : ' ( Dự kiến: $datetimegiaohang)',
                              style: TextStyle(
                                  fontFamily: 'Roboto Italic',
                                  fontSize: 12,
                                  color:
                                      datachitiet.thoiGianGiaoHangThucTe != null
                                          ? Colors.green
                                          : Colors.red)),
                        ])),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      rowItemDetail(
                          SvgPicture.asset(
                            'asset/icons/cuoc.svg',
                            height: 20,
                            width: 20,
                          ),
                          'Cước: ${datachitiet.tongTien}đ'),
                      SizedBox(
                        height: 10,
                      ),
                      rowItemDetail(
                          SvgPicture.asset(
                            'asset/icons/barcode.svg',
                            height: 20,
                            width: 20,
                          ),
                          'Mã tra cứu: ${datachitiet.maTraCuu}'),
                      SizedBox(
                        height: 10,
                      ),
                      rowItemDetail(
                          SvgPicture.asset(
                            'asset/icons/link.svg',
                            height: 20,
                            width: 20,
                          ),
                          'Link tra cứu: ${datachitiet.linkTraCuu}'),
                      SizedBox(
                        height: 10,
                      ),
                      rowItemDetail(
                          SvgPicture.asset(
                            'asset/icons/location.svg',
                            height: 20,
                            width: 20,
                          ),
                          'Trả tại: ${datachitiet.tenDiemNhanHang}'),
                      SizedBox(
                        height: 10,
                      ),
                      rowItemDetail(
                          SvgPicture.asset(
                            'asset/icons/emailreceive.svg',
                            height: 20,
                            width: 20,
                          ),
                          'SĐT người nhận: ${datachitiet.soDienThoaiNhan}'),
                      SizedBox(
                        height: 10,
                      ),
                      rowItemDetail(
                          SvgPicture.asset(
                            'asset/icons/emailsend.svg',
                            height: 20,
                            width: 20,
                          ),
                          'SĐT người gửi: ${datachitiet.soDienThoaiGui != null ? datachitiet.soDienThoaiGui : ''}'),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Divider(
                                thickness: 2,
                                height: 2,
                              ),
                              IntrinsicHeight(
                                child: Row(
                                    // mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      FlatButton(
                                        onPressed: () {},
                                        child: Text('IN PHIẾU',
                                            style: TextStyle(
                                                fontFamily: 'Roboto Medium',
                                                fontSize: 14,
                                                letterSpacing: 1.25,
                                                color: Colors.blue)),
                                        height: 20,
                                        // color: Colors.black,
                                      ),
                                      //  VerticalDivider(
                                      //     width: 2,
                                      //     thickness: 2,
                                      //   ),
                                      GestureDetector(
                                        onTap:
                                            datachitiet.trangThaiVanChuyen ==
                                                    'Đã giao'
                                                ? null
                                                : () {
                                                    showModalBottomSheet(
                                                        context: context,
                                                        builder: (context) {
                                                          return StatefulBuilder(
                                                              builder: (context,
                                                                  setState) {
                                                            return Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(15),
                                                              height: 300,
                                                              child: Column(
                                                                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: GestureDetector(
                                                                        onTap: () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child: Text(
                                                                          'Thoát',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                Colors.red,
                                                                            fontFamily:
                                                                                'Roboto Regular',
                                                                          ),
                                                                        )),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 15,
                                                                  ),
                                                                  Text(
                                                                      'Xác nhận trả hàng',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Roboto Medium',
                                                                        fontSize:
                                                                            20,
                                                                      )),
                                                                  Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                            'Ảnh: ${image.length}/2',
                                                                            style:
                                                                                TextStyle(
                                                                              fontFamily: 'Roboto Regular',
                                                                              fontSize: 14,
                                                                            )),
                                                                        Row(
                                                                            children: [
                                                                              Checkbox(value: false, onChanged: (a) {}),
                                                                              Text('In phiếu',
                                                                                  style: TextStyle(
                                                                                    fontFamily: 'Roboto Regular',
                                                                                    fontSize: 14,
                                                                                  )),
                                                                            ]),
                                                                      ]),
                                                                  SizedBox(
                                                                    width: double
                                                                        .infinity,
                                                                    height: 100,
                                                                    child:
                                                                        ListView(
                                                                      scrollDirection:
                                                                          Axis.horizontal,
                                                                      children: [
                                                                        ...image
                                                                            .map(
                                                                          (e) {
                                                                            return itemImage(e,
                                                                                () {
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
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        image.length <
                                                                                2
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
                                                                    thickness:
                                                                        1.5,
                                                                    height: 1,
                                                                  ),
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .bottomRight,
                                                                      child: SizedBox(
                                                                          height: 28,
                                                                          child: ElevatedButton(
                                                                              onPressed: () async {
                                                                                var res = await ApiHelper.postMultipart(servicesAPI.API_HangHoa + 'HangHoa/thuc-hien-giao-tra-hang-hoa', {
                                                                                  'idNhatKy': '${widget.idnhatki}',
                                                                                  'toaDo': ''
                                                                                });
                                                                                if (res == 'Uploadd') {
                                                                                  // trangthaiCount = 0;
                                                                                  // loadchuyendiganday();
                                                                                  Navigator.of(context).pop();
                                                                                  Navigator.of(context).popUntil((route) => route.isFirst);
                                                                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UIKitPage(3)));
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
                                        child: Container(
                                          height: 50,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          decoration: BoxDecoration(
                                              color: datachitiet
                                                          .trangThaiVanChuyen ==
                                                      'Đã giao'
                                                  ? Colors.grey[400]
                                                  : Colors.blue),
                                          child: Center(
                                              child: Text('TRẢ HÀNG',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Roboto Medium',
                                                      fontSize: 14,
                                                      letterSpacing: 1.25,
                                                      color: Colors.white))),
                                        ),
                                      )
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
            );
          }
          return Center(
            child: Text('Không có dữ liệu',
                style: TextStyle(fontFamily: 'Roboto Regular', fontSize: 14)),
          );
        },
      ),
    );
  }

//
//
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

  Row rowItemDetail(SvgPicture image, String title) {
    return Row(children: [
      image,
      SizedBox(
        width: 5,
      ),
      Expanded(
        child: Text('$title',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(fontFamily: 'Roboto Regular', fontSize: 14)),
      )
    ]);
  }
}
