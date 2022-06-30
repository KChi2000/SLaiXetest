import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ui_kit/Login.dart';
import 'package:flutter_ui_kit/helpers/LoginHelper.dart';
import 'package:flutter_ui_kit/model/Huyen.dart';
import 'package:flutter_ui_kit/model/thongtincanhan.dart';
import 'package:flutter_ui_kit/other/constant.dart';
import 'package:flutter_ui_kit/other/homeConstant.dart';
import 'package:flutter_ui_kit/other/imgConst.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import '../helpers/ApiHelper.dart';
import '../model/Tinh.dart';

class Taikhoan extends StatefulWidget {
  const Taikhoan({Key key}) : super(key: key);
  @override
  TaikhoanState createState() {
    return TaikhoanState();
  }
}

class TaikhoanState extends State<Taikhoan> {
  final formkey = GlobalKey<FormState>();
  DateTime datetime = DateTime.now();
  String formattedDate;
  String unselect = 'chưa chọn';
  String sdt;
  String email = '';
  String address = '';
  final phoneController = TextEditingController(text: '');
  final emailController = TextEditingController(text: '');
  final addressController = TextEditingController(text: '');
  // final diachiContoller= TextEditingController(text: 'tổ abc, phường xyz');
  String txt;
  String tinh, huyen, diachi;
  List<DataTinh> province = [];
  List<DataHuyen> district = [];
   List<DataHuyen> huyenlist = [];
  var idTinh;
  var datafuture;
  Map<String, dynamic> data;
  var tinhfuture;

  Tinh dataTinh;
  var huyenfuture;

  Huyen dataHuyen;
  final imagePicker = ImagePicker();
  File _image;
  Future getImage() async {
    final image = await imagePicker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(image.path);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    loadInfo();

    super.initState();

    // print('${infoMap.}');
  }

  void loadInfo() async {
    datafuture = ApiHelper.get(
        'https://api-dnvt.sbus.vn/api/Driver/lay-thong-tin-ca-nhan');
    data = await datafuture;
    tinh = '';
    idTinh = data['data']['idTinh'];
    print('ttttt ${data['data']['idTinh']}');
    tinhfuture = ApiHelper.getProvince(
        "https://api-dnvt.sbus.vn/api/Driver/lay-danh-sach-tinh");
    dataTinh = await tinhfuture;
    province = dataTinh.data;
    if (idTinh != null) {
      loadHuyen();
    }
  }

  void loadHuyen() async {
    huyenfuture = ApiHelper.getDistrict(
        "https://api-dnvt.sbus.vn/api/Driver/lay-danh-sach-huyen?IdTinh=$idTinh");
    dataHuyen = await huyenfuture;
    district = dataHuyen.data;
    setState(() {
      huyenlist = dataHuyen.data;
    });
    for (int i = 0; i < district.length; i++) {
      print('huyen: ${district[i].tenHuyen}');
      print('    ');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (datetime != null) {
      formattedDate = DateFormat('dd-MM-yyyy').format(datetime);
    }
    // formattedDate == DateFormat('dd-MM-yyyy').format(datetime)? null: formattedDate;
    print(formattedDate);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(
            color: titleColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20),
                child: Stack(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: _image == null
                          ? AssetImage(IMG_HEAD)
                          : Image.file(_image),
                    ), //Scaffold.of(context).showSnackBar(new SnackBar(content: new Text('edit avatar')));
                    Positioned(
                      bottom: 25 - sin(45) * 25,
                      right: 25 - sin(45) * 25,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.brown[400],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: GestureDetector(
                              child: Icon(
                                Icons.edit,
                                size: 10,
                                color: Colors.white,
                              ),
                              onTap: getImage),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 10, right: 20),
                    child: Text(
                      '${LoginHelper.Default.userToken.given_name} ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    'Lai xe',
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              )
            ],
          ),
          FutureBuilder<Map<String, dynamic>>(
              future: datafuture,
              builder: (context, snapshot) {
                // By default, show a loading spinner.
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: const CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('${snapshot.error} loiiiii'));
                } else if (snapshot.hasData) {
                  var fetchdata = snapshot.data;
                  formattedDate = fetchdata['data']['ngaySinh'];
                  sdt = fetchdata['data']['soDienThoai'];
                  email = fetchdata['data']['email'];
                  address = fetchdata['data']['diaChiThuongTru'];
                  print('sdt:  ${fetchdata['data']['soDienThoai'].toString()}');

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        // height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(offset: Offset(0, 0), blurRadius: 0.5)
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Thông tin cá nhân',
                              style: TextStyle(
                                  color: fontColor,
                                  fontSize: sizeLetter,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            rowItemInfor(
                                'Ngày sinh',
                                formattedDate == null
                                    ? unselect
                                    : formattedDate,
                                true, () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2222))
                                  .then((value) {
                                setState(() {
                                  datetime = value;

                                  print(formattedDate);
                                });
                              });
                            }),
                            SizedBox(
                              height: spaceInfo,
                            ),
                            rowItemInfor('Số điện thoại',
                                sdt == null ? unselect : sdt, true, () {
                              phoneController.text = sdt;
                              return showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      title: Text(
                                        'Sửa SĐT',
                                        style: TextStyle(fontSize: sizeLetter),
                                      ),
                                      content: Container(
                                          height: 30,
                                          width: 100,
                                          child: Form(
                                            key: formkey,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                  hintText:
                                                      'nhập số điện thoại'),
                                              controller: phoneController,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(r'[0-9]'))
                                              ],
                                              validator: (sodt) {
                                                if (sodt == null ||
                                                    sodt.isEmpty) {
                                                  return 'Số điện thoại không được để trống';
                                                }
                                                return null;
                                              },
                                            ),
                                          )),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Cancel'),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            if (formkey.currentState
                                                .validate()) {
                                              setState(() {
                                                sdt = phoneController.text;
                                                print('sdt: ' + sdt);
                                              });
                                              Navigator.pop(context, 'Cancel');
                                            }
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    );
                                  });
                            }),
                            SizedBox(
                              height: spaceInfo,
                            ),
                            rowItemInfor(
                                'Email', email == null ? unselect : email, true,
                                () {
                              return showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      title: Text(
                                        'Sửa Email',
                                        style: TextStyle(fontSize: sizeLetter),
                                      ),
                                      content: Form(
                                          key: formkey,
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                                hintText: 'nhập email'),
                                            controller: emailController,
                                            inputFormatters: [],
                                            validator: (em) {
                                              if (em == null || em.isEmpty) {
                                                return 'Email không được để trống';
                                              }
                                              return null;
                                            },
                                          )),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Cancel'),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            if (formkey.currentState
                                                .validate()) {
                                              setState(() {
                                                email = emailController.text;
                                              });
                                              Navigator.pop(context, 'OK');
                                            }
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    );
                                  });
                            }),
                            SizedBox(
                              height: spaceInfo,
                            ),
                            rowItemInforAddress('Địa chỉ',
                                address == null ? unselect : address, true, () {
                              addressController.text = address;
                              var tinhtemp = province.where((value) =>
                                  fetchdata['data']['idTinh'] == value.idTinh);
                              if (!tinhtemp.isEmpty || tinhtemp != null) {
                                tinh = tinhtemp.first.tenTinh;
                              }
                              var huyentemp = district.where((value) =>
                                  fetchdata['data']['idHuyen'] ==
                                  value.idHuyen);
                              if (!huyentemp.isEmpty || huyentemp != null) {
                                huyen = huyentemp.first.tenHuyen;
                              }
                              return showDialog(
                                  context: context,
                                  builder: (context) {
                                    return StatefulBuilder(
                                        builder: (context, setState) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        title: Text(
                                          'Sửa địa chỉ',
                                          style:
                                              TextStyle(fontSize: sizeLetter),
                                        ),
                                        content: Form(
                                            key: formkey,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  child:
                                                      DropdownButtonFormField(
                                                    decoration: InputDecoration(
                                                        labelText: 'tỉnh(*)'),
                                                    items: province.map((text) {
                                                      return new DropdownMenuItem(
                                                        child: Container(
                                                            child: Text(
                                                                text.tenTinh,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15))),
                                                        value: text.tenTinh,
                                                        onTap: () {
                                                          print(
                                                              'tinh moi : ${text.idTinh}  ${text.tenTinh}');
                                                          setState(() {
                                                            idTinh =
                                                                text.idTinh;
                                                         
                                                            huyen = null;
                                                            loadHuyen();
                                                          });
                                                        },
                                                      );
                                                    }).toList(),
                                                    value: tinh,
                                                    onChanged: (t1) {
                                                      setState(() {
                                                        tinh = t1;
                                                      });
                                                    },
                                                    hint: Text('chọn tỉnh'),
                                                    menuMaxHeight: 200,
                                                    validator: (vl1) {
                                                      if (vl1 == null ||
                                                          vl1.isEmpty) {
                                                        return 'Chưa chọn tỉnh';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  // height: 45,
                                                  child:
                                                      DropdownButtonFormField(
                                                    decoration: InputDecoration(
                                                        labelText:
                                                            'Quận/huyện(*)'),
                                                    items: district.map((text) {
                                                      return new DropdownMenuItem(
                                                        child: Container(
                                                            child: Text(
                                                                text.tenHuyen,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15))),
                                                        value: text.tenHuyen,
                                                      );
                                                    }).toList(),
                                                    value: huyen,
                                                    onChanged: (t2) {
                                                      setState(() {
                                                        huyen = t2;
                                                      });
                                                    },
                                                    hint: Text('chọn huyện'),
                                                    menuMaxHeight: 200,
                                                    validator: (vl2) {
                                                      if (vl2 == null ||
                                                          vl2.isEmpty) {
                                                        return 'Chưa chọn huyện';
                                                      }
                                                      return null;
                                                    },
                                                    onTap: () {
                                                      // setState(() {});
                                                    },
                                                  ),
                                                ),
                                                TextFormField(
                                                  controller: addressController,
                                                  inputFormatters: [],
                                                  maxLines: null,
                                                  decoration: InputDecoration(
                                                      labelText:
                                                          'Địa chỉ cụ thể(*)'),
                                                  validator: (vl4) {
                                                    if (vl4 == null ||
                                                        vl4.isEmpty) {
                                                      return 'Chưa điền địa chỉ cụ thể';
                                                    }
                                                    return null;
                                                  },
                                                )
                                              ],
                                            )),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                context, 'Cancel'),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              if (formkey.currentState
                                                  .validate()) {
                                                setState(() {
                                                  diachi =
                                                      addressController.text;
                                                });
                                                Navigator.pop(context, 'OK');
                                              }
                                              ;
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      );
                                    });
                                  });
                            }),
                            SizedBox(
                              height: spaceInfo,
                            ),
                            rowItemInfor(
                                'Năm bắt đầu hành nghề', '2022', false, () {}),
                            SizedBox(
                              height: spaceInfo,
                            ),
                            rowItemInfor(
                                'Số GPLX',
                                fetchdata['data']['soGPLX'] == null
                                    ? unselect
                                    : fetchdata['data']['soGPLX'],
                                false,
                                () {}),
                            SizedBox(
                              height: spaceInfo,
                            ),
                            rowItemInfor(
                                'Hạng bằng',
                                fetchdata['data']['hangBang'] == null
                                    ? unselect
                                    : fetchdata['data']['hangBang'],
                                false,
                                () {}),
                            SizedBox(
                              height: spaceInfo,
                            ),
                            rowItemInfor(
                                'Ngày bắt đầu hiệu lực',
                                fetchdata['data']['ngayBatDauHieuLuc'] == null
                                    ? unselect
                                    : fetchdata['data']['ngayBatDauHieuLuc'],
                                false,
                                () {}),
                            SizedBox(
                              height: spaceInfo,
                            ),
                            rowItemInfor('Thời hạn hiệu lực', '21/03/2022',
                                false, () {}),
                            SizedBox(
                              height: spaceInfo,
                            ),
                            rowItemInfor(
                                'Cơ quan cấp',
                                fetchdata['data']['coQuanCap'] == null
                                    ? unselect
                                    : fetchdata['data']['coQuanCap'],
                                false,
                                () {}),
                            SizedBox(
                              height: spaceInfo,
                            ),
                            rowItemInfor(
                                'Ngày cấp',
                                fetchdata['data']['ngayCap'] == null
                                    ? unselect
                                    : fetchdata['data']['ngayCap'],
                                false,
                                () {}),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {
                          print('Đăng xuất');
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Text('Đăng Xuất',
                            style: TextStyle(color: Colors.white)),
                        color: Colors.blue,
                      )
                    ],
                  );
                }
                return Center(child: Text('No data'));
              }),
        ],
      )),
    );
  }

  Row rowItemInfor(String t1, String t2, bool active, VoidCallback click) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          t1,
          style: TextStyle(
            color: Colors.black,
            fontSize: sizeInfo,
          ),
        ),
        SizedBox(
          width: 100,
        ),
        Row(
          children: [
            SizedBox(
              child: Text(
                t2,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: sizeInfo,
                    fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: true,
              ),
            ),
            GestureDetector(
              child: active
                  ? RotatedBox(
                      child: Icon(Icons.arrow_back_ios,
                          size: 14, color: Color.fromARGB(255, 73, 73, 72)),
                      quarterTurns: 2,
                    )
                  : Container(width: 0, height: 0),
              onTap: click,
            )
          ],
        )
      ],
    );
  }

  Row rowItemInforAddress(
      String t1, String t2, bool active, VoidCallback click) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          t1,
          style: TextStyle(
            color: Colors.black,
            fontSize: sizeInfo,
          ),
        ),
        SizedBox(
          width: 100,
        ),
        Row(
          children: [
            SizedBox(
              width: 120,
              child: Text(
                t2,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: sizeInfo,
                    fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: true,
              ),
            ),
            GestureDetector(
              child: active
                  ? RotatedBox(
                      child: Icon(Icons.arrow_back_ios,
                          size: 14, color: Color.fromARGB(255, 73, 73, 72)),
                      quarterTurns: 2,
                    )
                  : Container(width: 0, height: 0),
              onTap: click,
            )
          ],
        )
      ],
    );
  }

  Expanded buildMapItemView(String value, String key) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Divider(
            height: 5,
            color: Colors.transparent,
          ),
          Text(
            key,
            style: TextStyle(color: Colors.grey, fontSize: 12),
          )
        ],
      ),
      flex: 1,
    );
  }
}
