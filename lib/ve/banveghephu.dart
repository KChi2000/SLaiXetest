import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_ui_kit/other/homeConstant.dart';

import '../componentsFuture/bottomshetHK.dart';

class banveghephu extends StatefulWidget {
  const banveghephu({Key key}) : super(key: key);

  @override
  State<banveghephu> createState() => _banveState();
}

class _banveState extends State<banveghephu> {
  final formkey = GlobalKey<FormState>();
  final formkey1 = GlobalKey<FormState>();
  final formTTHK = GlobalKey<FormState>();
  final abc = GlobalKey<FormState>();
  final diemxuong = ['Bến xe Việt Trì'];
  final lowPrice =
      MoneyMaskedTextController(rightSymbol: 'VNĐ', initialValue: 0);
  bool cash = true;
  bool bank = false;
  // bool xacnhan= false;
  String ve = '1', sdt = null, giave = '0,00VNĐ';
  final veController = TextEditingController(text: '1');
   final phoneController = TextEditingController();
    final nameController = TextEditingController();
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
                key: formTTHK,
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
                        // formkey.currentState.validate();
                        // formkey1.currentState.validate();
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                padding: EdgeInsets.all(20),
                                height: 400,
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
                                                fontSize: 15)),
                                      ),
                                    ),
                                    Text('Thông tin hành khách',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18)),
                                    Form(
                                      // key: formkey1,
                                      child:  Column(children: [
                                      TextFormField(
                                        controller: phoneController,
                                        decoration: InputDecoration(
                                            // hintText: 'nhập số điện thoại',
                                            labelText: 'Số điện thoại',
                                           ),

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
                                            return 'Điện thoại không được để trống';
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
                                    
                                   
                                      TextFormField(
                                        controller: nameController,
                                        decoration: InputDecoration(
                                            // hintText: 'nhập số điện thoại',
                                            labelText: 'Họ tên: ',
                                           ),

                                        // controller: sdtNhanController,
                                        inputFormatters: [
                                          // FilteringTextInputFormatter.allow(
                                          //     RegExp(r'[0-9]')),
                                          FilteringTextInputFormatter.deny(
                                              RegExp(r'[0-9]+')),
                                          // LengthLimitingTextInputFormatter(10)
                                        ],
                                        validator: (ht) {
                                          if (ht == null || ht.isEmpty) {
                                            return 'Họ tên không được để trống';
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
                                      ),])
                                    ),
                                     SizedBox(
                                      height: 15,
                                    ),
                                     Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                        SvgPicture.asset('asset/icons/currency-usd.svg',
                                          width: 24, height: 24),
                                     
                                      SizedBox(
                                        width: spaceBetween,
                                      ),
                                      Text(
                                        'Thanh toán',
                                        style: TextStyle(
                                          // fontWeight: fontStyleListItem,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Đã thanh toán',
                                    style: TextStyle(
                                        // fontWeight: fontStyleListStatus,
                                        color: Colors.black),
                                  )
                                ],
                              ),
                               Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                     Icon(Icons.location_on,size: 24,),
                                      SizedBox(
                                        width: spaceBetween,
                                      ),
                                      Text(
                                        'Điểm xuống',
                                        style: TextStyle(
                                          // fontWeight: fontStyleListItem,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Yên Nghĩa',
                                    style: TextStyle(
                                        // fontWeight: fontStyleListStatus,
                                        color: Colors.black),
                                  )
                                ],
                              ),
                               SizedBox(
                                      height: 20,
                                    ),
                              FlatButton(onPressed: (){
                                formTTHK.currentState.validate();
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> componentArea(nameController.text,phoneController.text)));
                              }, child: Text('XÁC NHẬN',style: TextStyle(color: Colors.white),),color: Colors.blue,)
                                   
                                  ],
                                ),
                              );
                            });
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
