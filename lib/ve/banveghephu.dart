import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_ui_kit/helpers/ApiHelper.dart';
import 'package:flutter_ui_kit/other/homeConstant.dart';
import 'package:flutter_ui_kit/uikit.dart';
import 'package:intl/intl.dart';
import '../componentsFuture/bottomshetHK.dart';
import '../model/DSDiemxuongLotrinh.dart';
import '../model/DonGiaTheoTuyen.dart';

class banveghephu extends StatefulWidget {
  String guidlotrinh;
  String guidchuyendi;
  banveghephu(this.guidlotrinh, this.guidchuyendi);

  @override
  State<banveghephu> createState() => _banveState();
}

class _banveState extends State<banveghephu> {
  final formkey = GlobalKey<FormState>();
  final formkey1 = GlobalKey<FormState>();
  final formTTHK = GlobalKey<FormState>();
  final abc = GlobalKey<FormState>();
  List<DataDSDiemXuongLoTrinh> diemxuong = [];
  final lowPrice =
     TextEditingController(text: '0đ');
  final sdtController = TextEditingController();
  bool cash = true;
  bool bank = false;
  bool checkbox = false;
  DataDSDiemXuongLoTrinh diemxuongObject;
  String ve = '1', sdt = null, giave = '0,00VNĐ';
  final veController = TextEditingController(text: '1');
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  var dsdiemxuongFuture;
  DonGiaTheoTuyen DonGia;
  List<DataDonGiaTheoTuyen> data = [];
   static const _locale = 'en';
  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get _currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadDonGia(widget.guidlotrinh);
  }

  void loadDsDiemxuong() {
    dsdiemxuongFuture = ApiHelper.getDSDiemXuongLoTrinh(widget.guidlotrinh);
  }

  void loadDonGia(String idLoTRinh) async {
    DonGia = await ApiHelper.getDonGiaTheoTuyen(idLoTRinh);
    if (DonGia.status) {
      loadDsDiemxuong();
      setState(() {});
    } else {
      // setState(() {

      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('THANH TOÁN BÁN VÉ'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: dsdiemxuongFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Lỗi',style: TextStyle(fontSize: 14,fontFamily: 'Roboto Regular',)),
                );
              } else if (snapshot.hasData) {
                data = DonGia.data;
                DSDiemXuongLoTrinh dsdiemxuong = snapshot.data;
                int errorCode;
                diemxuong = dsdiemxuong.data;
                String initdropdown;
                if (diemxuong.length == 0) {
                  return Center(
                    child: Text('Không có dữ liệu',style: TextStyle(fontSize: 14,fontFamily: 'Roboto Regular',)),
                  );
                }

                return Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Form(
                          key: formkey,
                          child: TextFormField(
                            controller: veController,
                            autofocus: true,
                            decoration:
                                InputDecoration(labelText: 'Số lượng vé'),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                              FilteringTextInputFormatter.deny(RegExp(r'^0+')),
                              LengthLimitingTextInputFormatter(2)
                            ],
                            validator: (sodt) {
                              if (sodt == null || sodt.isEmpty) {
                                return 'Vé không được để trống';
                              }

                              return null;
                            },
                            onChanged: (vl) {
                              setState(() {
                                ve = vl;
                              });
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                        ),
                        Form(
                          key: formkey1,
                          child: TextFormField(
                            controller: sdtController,
                            decoration: InputDecoration(
                                // hintText: 'nhập số điện thoại',
                                labelText: 'Số điện thoại',
                                suffixIcon:
                                    Icon(Icons.qr_code_scanner_rounded)),

                            // controller: sdtNhanController,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                              FilteringTextInputFormatter.deny(
                                  RegExp(r'^[1-9]+')),
                              LengthLimitingTextInputFormatter(10)
                            ],
                            validator: (sodt) {
                              if (sodt == null || sodt.isEmpty) {
                                return 'Số điện thoại không được để trống';
                              } else if (sodt.length <= 10) {
                                return 'Sai định dạng số điện thoại';
                              }
                              return null;
                            },
                            onChanged: (vl1) {
                              setState(() {
                                sdt = vl1;
                              });
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                        ),
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                              labelText: 'Điểm xuống',
                              hintText: 'Chọn điểm xuống'),
                          items: diemxuong.map((DataDSDiemXuongLoTrinh text) {
                            return new DropdownMenuItem(
                              child: Container(
                                  child: Text(text.tenDiemXuong,
                                      style: TextStyle(fontSize: 15))),
                              value: text,
                            );
                          }).toList(),
                          value: initdropdown,
                          onChanged: (t1) {
                            setState(() {
                              diemxuongObject = t1;
                            });
                          },
                          menuMaxHeight: 200,
                          validator: (vl1) {
                            if (vl1 == null || vl1.isEmpty) {
                              return 'Chưa chọn diem xuong';
                            }
                            return null;
                          },
                        ),
                        Form(
                          key: formTTHK,
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: '', label: Text('Giá vé(*)')),
                            controller: lowPrice,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]'))
                            ],
                            validator: (sodt) {
                              if (sodt == null || sodt.isEmpty) {
                                return 'abc';
                              }
                              return null;
                            },
                            onChanged: (vl2) {
                               vl2 = '${_formatNumber(vl2.replaceAll(',', ''))}';
                              lowPrice.value = TextEditingValue(
                                text: vl2,
                                selection:
                                    TextSelection.collapsed(offset: vl2.length),
                              );
                              xacnhan();
                              // setState(() {
                              //   giave = vl2;
                              // });
                            },
                          ),
                        ),
                        data.length != 0
                            ? Wrap(children: [
                                ...data.map((e) => InkWell(
                                      onTap: () {
                                        print(e.giaVe);
                                        setState(() {
                                           lowPrice.text = NumberFormat('#,###')
                                                .format(e.giaVe) ;
                                          giave = e.giaVe.toString();
                                        });
                                      },
                                      child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Chip(
                                            label: Text(e.giaVe.toString(),style: TextStyle(fontFamily: 'Roboto Regular',fontSize: 14,)),
                                            backgroundColor: Colors.grey[320],
                                          )),
                                    ))
                              ])
                            : Text(''),
                        Row(
                          children: [
                            Checkbox(
                                value: checkbox,
                                activeColor: Color.fromARGB(255, 21, 128, 216),
                                onChanged: (value) {
                                  setState(() {
                                    checkbox = value;
                                  });
                                }),
                            Text('Phát hành & In vé',
                                style: TextStyle(
                                  fontFamily: 'Roboto Regular',
                                  fontSize: 16,
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text('Chọn hình thức thu tiền',
                              style: TextStyle(
                                  fontFamily: 'Roboto Regular',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700)),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    cash = true;
                                    bank = false;
                                  });
                                },
                                child: Container(
                                  height: 39,
                                  padding: EdgeInsets.all(5),
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: cash == true
                                          ? Border.all(
                                              color: Colors.blue, width: 2)
                                          : null,
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.12),
                                            offset: Offset(0, 1),
                                            blurRadius: 0.1,
                                            spreadRadius: 2)
                                      ]),
                                  child: Row(children: [
                                    SvgPicture.asset(
                                      'asset/icons/cash.svg',
                                      width: 20,
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('TIỀN MẶT/CASH\nCHANGE',
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.black87),
                                        textAlign: TextAlign.start),
                                  ]),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    bank = true;
                                    cash = false;
                                  });
                                },
                                child: Container(
                                    height: 39,
                                    padding: EdgeInsets.all(5),
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: bank == true
                                            ? Border.all(
                                                color: Colors.blue, width: 2)
                                            : Border.all(
                                                color: Colors.grey[200],
                                                width: 2),
                                        borderRadius: BorderRadius.circular(5),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.12),
                                              offset: Offset(0, 1),
                                              blurRadius: 0.0,
                                              spreadRadius: 2)
                                        ]),
                                    child: SvgPicture.asset(
                                        'asset/icons/vietinbank logo svg.svg')),
                              ),
                            ]),
                        SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          onPressed: xacnhan()
                              ? () async {
                                  String money = lowPrice.text
                                      .replaceAll(RegExp('[^0-9]'), '');
                                  var resp = await ApiHelper.post(
                                      'http://113.176.29.57:19666/api/DonHang/thuc-hien-ban-ve-cho-ghe-phu',
                                      {
                                        'ToaDo': '',
                                        'giaVe': int.parse(money),
                                        'guidChuyenDi':
                                            '${widget.guidchuyendi}',
                                        'maDiemXuong':
                                            '${diemxuongObject.guidDiemXuong}',
                                        'phatHanhVe':
                                            jsonDecode(checkbox.toString()),
                                        'soDienThoai': '${sdtController.text}',
                                        'soLuong': '${veController.text}',
                                        'tenDiemXuong':
                                            '${diemxuongObject.tenDiemXuong}'
                                      });
                                  if (resp['status']) {
                                     Navigator.of(context).popUntil((route) => route.isFirst);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UIKitPage(1)));
                                  } else {
                                    showDialog(
                                      context: context,
                                      barrierDismissible:
                                          false, // user must tap button!
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Lỗi'),
                                          content: Text('${resp['message']}'),
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
                                }
                              : null,
                          child: Text(
                            'BÁN VÉ',
                           style: TextStyle(fontSize: 14,fontFamily: 'Roboto Medium',letterSpacing: 1.25, color: Colors.white),
                          ),
                        )
                      ],
                    ));
              }
              return Center(
                child: Text('Không có dữ liệu',style: TextStyle(fontSize: 14,fontFamily: 'Roboto Regular',)),
              );
            }),
      ),
    );
  }

  bool xacnhan() {
    if (giave == '0đ' ||
        lowPrice.text == '0đ' ||
        diemxuongObject == null ||
        ve == null ||
        ve.isEmpty ||
        sdt == null ||
        sdt.isEmpty) {
      return false;
    } else
      return true;
  }
}
