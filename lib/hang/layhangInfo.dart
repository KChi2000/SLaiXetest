import 'dart:ffi';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_ui_kit/helpers/ApiHelper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../model/DSDiemxuongLotrinh.dart';

class layhangInfo extends StatefulWidget {
  String guidlotrinh;
  layhangInfo(this.guidlotrinh);

  @override
  State<layhangInfo> createState() => _layhangInfoState();
}

class _layhangInfoState extends State<layhangInfo> {
  bool flag = false;
  bool checkbox = false;
  final formkey1 = GlobalKey<FormState>();
  final formkey2 = GlobalKey<FormState>();
  int errorCode;
  List<DataDSDiemXuongLoTrinh> diemtrahang = [];
  final sdtNhanController = TextEditingController();
  final timeController = TextEditingController(
      text: DateFormat(' kk:mm, dd-MM-yyyy').format(DateTime.now()));
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  String nhan;
  String cuoc;
  String giacuoc;
  XFile imageitem;
  String Dropdownselected;
  final lowPrice =
      MoneyMaskedTextController(rightSymbol: 'VNĐ', initialValue: 0);
  final List<XFile> image = [];
  int count = 0;
  var dsdiemxuongFuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadDSdiemxuong();
    print(lowPrice.text);
    cuoc = lowPrice.text;
  }
  void loadDSdiemxuong(){
    dsdiemxuongFuture = ApiHelper.getDSDiemXuongLoTrinh(widget.guidlotrinh);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('THÔNG TIN GỬI HÀNG', style: TextStyle(fontSize: 16)),
        centerTitle: true,
      ),
      body: FutureBuilder(future: dsdiemxuongFuture,
      builder: ((context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }
        else if(snapshot.hasError){

        }
        else if(snapshot.hasData){
          int errorCode;
          DSDiemXuongLoTrinh dsdiemxuong = snapshot.data;
          diemtrahang = dsdiemxuong.data;
          if(diemtrahang.length ==0){
            diemtrahang = [DataDSDiemXuongLoTrinh('','Không có dữ liệu')];
          }
          return Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Đã trả cước'),
                  Switch(
                      value: flag,
                      activeColor: Color.fromARGB(255, 21, 128, 216),
                      onChanged: (value) {
                        setState(() {
                          flag = value;
                        });
                        print(flag);
                      }),
                ],
              ),
              Form(
                key: formkey1,
                child: TextFormField(
                  autofocus:true,
                  decoration: InputDecoration(
                      // hintText: 'nhập số điện thoại',
                      labelText: 'Số điện thoại người nhận(*)'),
                  controller: sdtNhanController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    FilteringTextInputFormatter.deny(RegExp(r'^[1-9]+')),
                    LengthLimitingTextInputFormatter(10)
                  ],
                  validator: (sodt) {
                    if (sodt == null || sodt.isEmpty) {
                      return 'Số điện thoại không được để trống';
                    } else if (validateMobile(sodt)) {
                      return 'Sai định dạng số điện thoại';
                    }

                    return null;
                  },
                  onChanged: (phone) {
                    print(phone);
                     xacnhan();
                      print('xac nhan ${xacnhan()}');
                    if (phone.length == 10) {
                     
                      setState(() {
                        phone.replaceAll(' ', '');
                        nhan = phone;
                        
                       
                        print(phone);
                        // formkey.currentState.activate();
                      });
                    } else {
                      setState(() {
                        nhan = null;
                      });
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(labelText: 'Điểm trả hàng(*)'),
                items: diemtrahang.map((DataDSDiemXuongLoTrinh text) {
                  return new DropdownMenuItem(
                    child: Container(
                        child: Text(text.tenDiemXuong, style: TextStyle(fontSize: 15))),
                    value: text,
                  );
                }).toList(),
                // value: 'Bến xe Hà Nam',
                onChanged: (DataDSDiemXuongLoTrinh t1) {
                  xacnhan();
                  setState(() {
                    Dropdownselected = t1.tenDiemXuong;
                    xacnhan();
                  });
                  
                },
                hint: Text('chọn điểm trả hàng'),
                menuMaxHeight: 200,
                validator: (vl1) {
                  if (vl1 == null || vl1.isEmpty) {
                    return 'Chưa chọn điểm trả hàng';
                  }
                  return null;
                },
              ),
              Form(
                // key: formkey,
                child: TextFormField(
                  decoration:
                      InputDecoration(hintText: '', label: Text('Giá cước(*)')),
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
                  onChanged: (gia) {
                    
                     String filter = gia.substring(0,gia.length-3);
                     
                     print(gia);
                        
                    setState(() {
                      // cuoc = double.parse(gia);
                       gia.replaceAll(' ', '');
                        cuoc = filter;
                     
                     print('xac nhan ${xacnhan()}');
                    
                      // filter.replaceAll(RegExp(r','), '');
                      // cuoc = double.tryParse(filter);
                      // print(filter);
                      // print('aaa: '+cuoc.toString());
                    });
                    xacnhan();
                  },
                ),
              ),
              Form(
                key: formkey2,
                child: TextFormField(
                  decoration: InputDecoration(
                      // hintText: 'nhập số điện thoại',
                      labelText: 'Số điện thoại người gửi(*)'),
                  // controller: sdtNhanController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    FilteringTextInputFormatter.deny(RegExp(r'^[1-9]+')),
                    LengthLimitingTextInputFormatter(10)
                  ],
                  validator: (sodt) {
                    if (sodt == null || sodt.isEmpty) {
                      return 'Số điện thoại không được để trống';
                    } else if (validateMobile(sodt)) {
                      return 'Sai định dạng số điện thoại';
                    }
                    return null;
                  },
                  onChanged: (p) {
                    if (p.length == 10) {
                      setState(() {
                        
                        print(p);
                        // formkey.currentState.activate();
                      });
                    } else {
                      setState(() {
                       
                      });
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              TextFormField(
                controller: timeController,
                decoration: InputDecoration(
                    labelText: 'Thời gian giao hàng dự kiến',
                    suffixIcon: Icon(Icons.date_range)),
                // initialValue: datetime,

                onTap: () async {
                  // Below line stops keyboard from appearing
                  FocusScope.of(context).requestFocus(new FocusNode());
                  // Show Date Picker Here
                  date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(3000));
                  if (date == null) {
                    setState(() {
                      date = DateTime.now();
                    });
                  }
                  time =
                      await showTimePicker(context: context, initialTime: time,hourLabelText: 'Giờ',minuteLabelText: 'phút');
                  if (time == null) {
                    setState(() {
                      time = TimeOfDay.now();
                    });
                  }
                  setState(() {
                    timeController.text =
                        '${time.hour}:${time.minute}, ${date.day}/${date.month}/${date.year}';
                  });
                },
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
              Container(
                padding: EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width * 0.35,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(5)),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Ảnh ${image.length}/3'),
                  Row(
                    children: [
                      Checkbox(
                          checkColor: Colors.white,
                          // fillColor: MaterialStateProperty.resolveWith(getColor),
                          value: checkbox,
                          onChanged: (a) {
                            setState(() {
                              checkbox = a;
                            });
                          }),
                      Text('In phiếu'),
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          height: 60,
                          width: 50,
                          child: Image.asset(
                            'asset/images/6.jpg',
                            width: 60,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 45,
                        left: 35,
                        child: IconButton(
                          icon: SvgPicture.asset(
                            'asset/icons/cancel.svg',
                            width: 20,
                            height: 20,
                          ),
                          onPressed: () {},
                        ),
                      )
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          height: 60,
                          width: 50,
                          child: Image.asset(
                            'asset/images/6.jpg',
                            width: 60,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 45,
                        left: 35,
                        child: IconButton(
                          icon: SvgPicture.asset(
                            'asset/icons/cancel.svg',
                            width: 20,
                            height: 20,
                          ),
                          onPressed: () {},
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: DottedBorder(
                      child: GestureDetector(
                        child: Container(
                          height: 55,
                          width: 50,
                          child: Center(
                              child: SvgPicture.asset(
                            'asset/icons/camera-plus.svg',
                            color: Colors.black54,
                          )),
                        ),
                        onTap: () {
                          return showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Container(
                                    width: 60,
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            child: Text('Chụp ảnh mới'),
                                            onTap: () async {
                                              print('chọn chụp ảnh');
                                              Navigator.pop(context);
                                              await ImagePicker().pickImage(
                                                  source: ImageSource.camera);
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
                                              imageitem = await ImagePicker()
                                                  .pickImage(
                                                      source:
                                                          ImageSource.gallery);
                                              if (imageitem == null) {
                                                return;
                                              }
                                              image.add(imageitem);
                                              setState(() {
                                                count = image.length;
                                              });
                                            },
                                          ),
                                        ]),
                                  ),
                                );
                              });
                        },
                      ),
                      color: Colors.black54,
                      strokeWidth: 1,
                      radius: Radius.circular(10),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              FlatButton(
                onPressed: xacnhan() ? (){
                 
                } : null,
                child: Text(
                  'XÁC NHẬN',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                color: Colors.blue,
                height: 30,
              )
            ],
          ));
        }
        return Center(child: Text('Không có dữ liệu'),);
      }),),
    );
  }


  bool validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10}$)';
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return true;
    }
    return false;
  }

  bool xacnhan() {
    if (nhan != null  && cuoc != '0,00' && lowPrice.text != '0,00VNĐ' && Dropdownselected !=null) {
      return true;
    }
    return false;
  }
}
