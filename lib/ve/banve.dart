import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_svg/svg.dart';

class banve extends StatefulWidget {
  const banve({Key key}) : super(key: key);

  @override
  State<banve> createState() => _banveState();
}

class _banveState extends State<banve> {
  final formkey = GlobalKey<FormState>();
  final formkey1 = GlobalKey<FormState>();
  final diemxuong = ['Bến xe Việt Trì'];
  final lowPrice =
      MoneyMaskedTextController(rightSymbol: 'VNĐ', initialValue: 0);
  bool cash = true;
  bool bank = false;
  // bool xacnhan= false;
  String ve = '1', sdt = null, giave = '0,00VNĐ';
  final veController = TextEditingController(text: '1');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('THANH TOÁN BÁN VÉ'),
        centerTitle: true,
      ),
      body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Form(
                key: formkey,
                child: TextFormField(
                  controller: veController,
                  autofocus: true,
                  decoration: InputDecoration(labelText: 'Số lượng vé'),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
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
                    FilteringTextInputFormatter.deny(RegExp(r'^[1-9]+')),
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
                decoration: InputDecoration(labelText: 'Điểm xuống'),
                items: diemxuong.map((String text) {
                  return new DropdownMenuItem(
                    child: Container(
                        child: Text(text, style: TextStyle(fontSize: 15))),
                    value: text,
                  );
                }).toList(),
                value: 'Bến xe Việt Trì',
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
                // key: formkey,
                child: TextFormField(
                  decoration:
                      InputDecoration(hintText: '', label: Text('Giá vé(*)')),
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
                      value: true,
                      activeColor: Color.fromARGB(255, 21, 128, 216),
                      onChanged: (value) {
                        setState(() {
                          // flag = value;
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
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                            ? Border.all(color: Colors.blue, width: 2)
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
                          style: TextStyle(fontSize: 10, color: Colors.black87),
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
                      width: MediaQuery.of(context).size.width * 0.35,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: bank == true
                              ? Border.all(color: Colors.blue, width: 2)
                              : Border.all(color: Colors.grey[200], width: 2),
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.12),
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
                        formkey.currentState.validate();
                        formkey1.currentState.validate();
                      }
                    : null,
                child: Text(
                  'BÁN VÉ',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              )
            ],
          )),
    );
  }

  bool xacnhan() {
    if (giave == '0,00VNĐ' ||
        ve == null ||
        ve.isEmpty ||
        sdt == null ||
        sdt.isEmpty) {
      return false;
    } else
      return true;
  }
}
