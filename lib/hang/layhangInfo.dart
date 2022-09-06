import 'dart:ffi';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_ui_kit/components/chooseImage.dart';
import 'package:flutter_ui_kit/components/printpopup.dart';
import 'package:flutter_ui_kit/helpers/ApiHelper.dart';
import 'package:flutter_ui_kit/servicesAPI.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../model/DSDiemxuongLotrinh.dart';
import '../uikit.dart';

class layhangInfo extends StatefulWidget {
  String guidlotrinh;
  String idchuyendi;
  layhangInfo(this.guidlotrinh, this.idchuyendi);

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
  final sdtGuiController = TextEditingController();
  final timeController = TextEditingController(
      text: DateFormat(' kk:mm, dd-MM-yyyy').format(DateTime.now()));
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  String nhan='';
  String cuoc='0đ';
  String giacuoc;
  XFile imageitem;
  String Dropdownselected;
  final lowPrice =
      TextEditingController(text: '0đ');
      static const _locale = 'en';
      String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));
  List<XFile> image = [];
  int count = 0;
  var dsdiemxuongFuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadDSdiemxuong();
    print(widget.idchuyendi);
    // cuoc = lowPrice.text;
  }

  void loadDSdiemxuong() {
    dsdiemxuongFuture = ApiHelper.getDSDiemXuongLoTrinh(widget.guidlotrinh);
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
     useDefaultLoading: false,
     overlayOpacity: 0.6,
     overlayWidget: Center(child: CircularProgressIndicator(),),
      child: Scaffold(
      appBar: AppBar(
        title: Text('THÔNG TIN GỬI HÀNG', style: TextStyle()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: dsdiemxuongFuture,
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Lỗi'),);
            } else if (snapshot.hasData) {
              int errorCode;
              DSDiemXuongLoTrinh dsdiemxuong = snapshot.data;
              diemtrahang = dsdiemxuong.data;
              if (diemtrahang.length == 0) {
                diemtrahang = [DataDSDiemXuongLoTrinh('', 'Không có dữ liệu')];
              }
              return Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Đã trả cước', style: TextStyle(fontFamily: 'Roboto Regular',fontSize: 14)),
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
                          autofocus: true,
                          decoration: InputDecoration(
                              // hintText: 'nhập số điện thoại',
                              labelText: 'Số điện thoại người nhận(*)'),
                          controller: sdtNhanController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            // FilteringTextInputFormatter.deny(RegExp(r'/^\+[1-9]{2}(?!0+$)[\d +-]{4,23}$/')),
                            FilteringTextInputFormatter.deny(
                                RegExp(r'^[1-9]')),
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
                            setState(() {
                              nhan = phone;
                            });
                            xacnhan();
                            
                            
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ),
                      DropdownButtonFormField(
                        decoration:
                            InputDecoration(labelText: 'Điểm trả hàng(*)'),
                        items: diemtrahang.map((DataDSDiemXuongLoTrinh text) {
                          return new DropdownMenuItem(
                            child: Container(
                                child: Text(text.tenDiemXuong,
                                    style: TextStyle(fontSize: 15))),
                            value: text,
                          );
                        }).toList(),
                        // value: 'Bến xe Hà Nam',
                        onChanged: (DataDSDiemXuongLoTrinh t1) {
                         
                          setState(() {
                            Dropdownselected = t1.tenDiemXuong;
                            
                          });
                          xacnhan();
                        },
                        hint: Text('chọn điểm trả hàng', style: TextStyle(fontFamily: 'Roboto Regular',fontSize: 14)),
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
                          decoration: InputDecoration(
                              hintText: '', label: Text('Giá cước(*)')),
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
                            setState(() {
                              cuoc=gia;
                            });
                            xacnhan();
                           gia = '${_formatNumber(gia.replaceAll(',', ''))}';
                                lowPrice.value = TextEditingValue(
                                  text: gia,
                                  selection:
                                      TextSelection.collapsed(offset: gia.length),
                                );

                            
                          },
                        ),
                      ),
                      Form(
                        key: formkey2,
                        child: TextFormField(
                          controller: sdtGuiController,
                          decoration: InputDecoration(
                              // hintText: 'nhập số điện thoại',
                              labelText: 'Số điện thoại người gửi(*)'),
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
                              setState(() {});
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
                          time = await showTimePicker(
                              context: context,
                              initialTime: time,
                              hourLabelText: 'Giờ',
                              minuteLabelText: 'phút');
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
                            style: TextStyle(fontFamily: 'Roboto Regular',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700)),
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
                              style: TextStyle(
                                   fontFamily: 'Roboto Regular',
                                            fontSize: 9, color: Colors.black87),
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
                              Text('In phiếu',style: TextStyle(fontFamily: 'Roboto Regular',fontSize: 14)),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 100,
                        width: double.infinity,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
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
                                     chooseImage(50, 55, imageitem, image, setState)
                                    ],
                                  )
                                : Text(''),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      FlatButton(
                        onPressed: xacnhan()
                            ? () async {
                              context.loaderOverlay.show();
                                DateTime sendDatetime = new DateTime(
                                    date.year,
                                    date.month,
                                    date.day,
                                    time.hour,
                                    time.minute);
                                print(sendDatetime);
                                print(sendDatetime.toUtc().toIso8601String());
                                var resp = await ApiHelper.postMultipart(
                                    servicesAPI.API_HangHoa+'HangHoa/thuc-hien-nhan-van-chuyen-hang-hoa',
                                    {
                                      'idChuyenDi': '${widget.idchuyendi}',
                                      'tongTien':
                                          '${lowPrice.text.substring(0, lowPrice.text.length - 3)}',
                                      'soDienThoaiNhan':
                                          '${sdtNhanController.text}',
                                      'soDienThoaiGui':
                                          '${sdtGuiController.text}',
                                      'idDiemNhan':
                                          '${diemtrahang[0].guidDiemXuong}',
                                      'tenDiemNhan':
                                          '${diemtrahang[0].tenDiemXuong}',
                                      'thoiGianGiaoHangDuKien':
                                          '${sendDatetime.toUtc().toIso8601String()}',
                                      'daTraCuoc': '$checkbox',
                                      'toaDoGuiHang': ''
                                    });

                                if (resp == 'Uploadd') {
                                  context.loaderOverlay.hide();
                                  if(Platform.isIOS){
                                                           printpopup.showpopup(context, listprint);
                                                        }
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UIKitPage(3)));
                                } else {
                                  context.loaderOverlay.hide();
                                  showDialog(
                                    context: context,
                                    barrierDismissible:
                                        false, // user must tap button!
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Lỗi',style: TextStyle(fontFamily: 'Roboto Regular',fontSize: 18,color: Colors.red)),
                                        content: Text('Lỗi kết nối',style: TextStyle(fontFamily: 'Roboto Regular',fontSize: 14)),
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
                              }
                            : null,
                        child: Text(
                          'XÁC NHẬN',
                          style: TextStyle(fontSize: 14,fontFamily: 'Roboto Medium',letterSpacing: 1.25, color: Colors.white),
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
            return Center(
              child: Text('Không có dữ liệu',style: TextStyle(fontFamily: 'Roboto Regular',fontSize: 14)),
            );
          }),
        ),
      ),
    ));
  }

  bool validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10}$)';
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return true;
    }
    return false;
  }

 
  bool xacnhan(){
    if(nhan.length <10 || cuoc.isEmpty || cuoc == '0đ' || Dropdownselected==null){
      return false;
    }
    return true;
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
          bottom: 65,
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
}
