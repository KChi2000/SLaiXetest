import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_ui_kit/helpers/ApiHelper.dart';
import 'package:flutter_ui_kit/model/DSDiemXuong.dart';

import '../componentsFuture/bottomshetHK.dart';
import '../other/homeConstant.dart';

class banve extends StatefulWidget {
  String guidlotrinh;
  banve(this.guidlotrinh);

  @override
  State<banve> createState() => _banveState();
}

class _banveState extends State<banve> {
  final formkey = GlobalKey<FormState>();
  final formkey1 = GlobalKey<FormState>();
  final formTTHK = GlobalKey<FormState>();
  final abc = GlobalKey<FormState>();
  final diemxuong = ['Bến xe Việt Trì'];
  final lowPrice =
      MoneyMaskedTextController(rightSymbol: 'VNĐ', initialValue: 0);
  bool cash = true;
  bool bank = false;
  bool checkbox = false;
  // bool xacnhan= false;
  String ve = '1', sdt = null, giave = '0,00VNĐ';
  final veController = TextEditingController(text: '1');
 
  var DSDiemXuongFuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.guidlotrinh);
    loadDSDiemXuong();
  }

  void loadDSDiemXuong() {
    DSDiemXuongFuture = ApiHelper.getDSDiemXuong(widget.guidlotrinh);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('THANH TOÁN BÁN VÉ'),
      ),
      body: FutureBuilder(
          future: DSDiemXuongFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              DSDiemXuong dsdiemxuong = snapshot.data;
              List<DiemXuongData> listdiemxuong= dsdiemxuong.data;
              String initDropValue= listdiemxuong[0].tenDiemXuong;
              return Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Form(
                        key: formkey1,
                        child: TextFormField(
                          decoration: InputDecoration(
                              // hintText: 'nhập số điện thoại',
                              labelText: 'Số điện thoại',
                              suffixIcon: Icon(Icons.qr_code_scanner_rounded)),

                          // controller: sdtNhanController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ),
                      DropdownButtonFormField(
                        decoration: InputDecoration(labelText: 'Điểm xuống',hintText: 'Chọn điểm xuống'),
                        items: listdiemxuong.map((DiemXuongData text) {
                          return new DropdownMenuItem(
                            child: Container(
                                child:
                                    Text(text.tenDiemXuong, style: TextStyle(fontSize: 15))),
                            value: text,
                          );
                        }).toList(),
                        // value: initDropValue,
                        onChanged: (t1) {
                          setState(() {
                            // tinh = t1;
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
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                          ],
                          validator: (sodt) {
                            if (sodt == null || sodt.isEmpty) {
                              return 'abc';
                            }
                            return null;
                          },
                          onChanged: (vl2) {
                            setState(() {
                              giave = vl2;
                            });
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: checkbox,
                              activeColor: Color.fromARGB(255, 21, 128, 216),
                              onChanged: (value) {
                                setState(() {
                                  checkbox = value;
                                  print(checkbox);
                                });
                              }),
                          Text('Phát hành & In vé'),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text('Chọn hình thức thu tiền',
                            style: TextStyle(fontWeight: FontWeight.bold)),
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
                                width: MediaQuery.of(context).size.width * 0.35,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: cash == true
                                        ? Border.all(
                                            color: Colors.blue, width: 2)
                                        : null,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.12),
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
                                          fontSize: 10, color: Colors.black87),
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
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
                                            color:
                                                Colors.black.withOpacity(0.12),
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
                            ? () {
                                // formkey.currentState.validate();
                                // formkey1.currentState.validate();
                                
                              }
                            : null,
                        child: Text(
                          'BÁN VÉ',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      )
                    ],
                  ));
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Không có dữ liệu'),
              );
            }
            return Center(
              child: Text('Lỗi kết nối'),
            );
          }),
    );
  }

  bool xacnhan() {
    if (giave == '0,00VNĐ' || sdt == null || sdt.isEmpty) {
      return false;
    } else
      return true;
  }
}
