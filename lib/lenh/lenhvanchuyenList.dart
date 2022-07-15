import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';

import 'package:flutter_svg/svg.dart';
import 'package:flutter_ui_kit/helpers/ApiHelper.dart';

import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_ui_kit/model/customModel.dart';
import 'package:flutter_ui_kit/model/lenhvanchuyen.dart';
import 'package:intl/intl.dart';

import '../model/lenhModel.dart';

class lenhvanchuyenList extends StatefulWidget {
  const lenhvanchuyenList({Key key}) : super(key: key);

  @override
  State<lenhvanchuyenList> createState() => _lenhvanchuyenListState();
}

class _lenhvanchuyenListState extends State<lenhvanchuyenList> {
  int count = 1;
  final trangthai = [
    'Tất cả',
    'Chưa thực hiện',
    'Đã hoàn thành',
    'Không hoàn thành'
  ];
  final tuyen = ['không có dữ liệu'];
  final diem = ['không có dữ liệu'];
  String dropdownValue;
  String dateString = '';

  final formKey = GlobalKey<FormState>();
  DateTime date = DateTime.now();
  final timeController = TextEditingController(
      text: DateFormat('dd-MM-yyyy').format(DateTime.now()));
  final lidoController = TextEditingController();
  var DSLenhFuture;
  DSLenh maplenh;
  // List<DSLenhData> lenhldata;
  var datePostFormat = DateFormat('dd-MM-yyyy kk:mm').format(DateTime.now());

  Map<String, dynamic> postdata = {
    'custom': {
      'danhSachGioXuatBen': [],
      'idLuongTuyen': null,
      'ngayXuatBenKeHoach': '2022-07-04T17:00:00.000Z',
      'timKiem': null,
    },
    'loadOptions': {
      'searchOperation': 'contains',
      'searchValue': null,
      'skip': 0,
      'take': 20,
      'userData': {}
    },
  };
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var aaa= _getPSTTime();
    // var abb = DateFormat('yyyy/MM/dd kk:mm').format(aaa);
    // DateTime ccc= DateTime.parse(abb);
    
    // print(abb);
    print(' aaa: ${DateTime.now().toIso8601String()}');
    // getForeignTime();

    loadDSLenh();
  }

  // void getForeignTime() async {
  //   await tz.initializeTimeZone();
  //   var detroit = tz.getLocation('America/Detroit');
  //   var now = tz.TZDateTime.now(detroit);
  //   print('now  $now');
  // }

  void loadDSLenh() async {
    DSLenhFuture = ApiHelper.postDsLenh(
        'http://lenh.nguyencongtuyen.local:19666/api/Driver/lay-danh-sach-tat-ca-lenh-cua-lai-xe',
        postdata);
    maplenh = await DSLenhFuture;
    setState(() {});
    if (maplenh != null) {
     
      print('postttt ${maplenh.message}');
    }
  }

DateTime _getPSTTime() {
  tz.initializeTimeZones();

  final DateTime now = DateTime.now();
  final pacificTimeZone = tz.getLocation('America/Los_Angeles');

  return tz.TZDateTime.from(now, pacificTimeZone);
}
  @override
  Widget build(BuildContext context) {
//      var todatetime = DateTime.parse(datePostFormat);
//  var datePost = todatetime.toUtc();
   
    double widthScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DANH SÁCH LỆNH',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder: (context, setState) {
                        return Container(
                          padding: EdgeInsets.all(15),
                          height: 450,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: widthScreen * 0.32),
                                    child: Text('Lọc dữ liệu',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18)),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Hủy',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 15)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              DropdownButtonFormField(
                                decoration:
                                    InputDecoration(labelText: 'Trạng thái(*)'),
                                items: trangthai.map((String text) {
                                  return new DropdownMenuItem(
                                    child: Container(
                                        child: Text(text,
                                            style: TextStyle(fontSize: 15))),
                                    value: text,
                                  );
                                }).toList(),
                                value: 'Tất cả',
                                onChanged: (t1) {
                                  setState(() {
                                    // tinh = t1;
                                  });
                                },
                                hint: Text('chọn tỉnh'),
                                menuMaxHeight: 200,
                                validator: (vl1) {
                                  if (vl1 == null || vl1.isEmpty) {
                                    return 'Chưa chọn trạng thái';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Tìm kiếm'),
                              ),
                              TextFormField(
                                controller: timeController,
                                decoration: InputDecoration(
                                    labelText: 'Ngày xuất bến kế hoạch',
                                    suffixIcon: Icon(Icons.date_range)),
                                onTap: () async {
                                  // Below line stops keyboard from appearing
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  // Show Date Picker Here
                                  await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime(3000))
                                      .then((value) {
                                    if (value == null) {
                                      setState(() {
                                        timeController.text =
                                            '${date.day}-${date.month}-${date.year}';
                                      });
                                    } else {
                                      setState(() {
                                        timeController.text =
                                            '${value.day}-${value.month}-${value.year}';
                                      });
                                    }
                                  });
                                },
                                onFieldSubmitted: (vl) {
                                  setState() {}
                                },
                              ),
                              DropdownButtonFormField(
                                decoration: InputDecoration(
                                    labelText: 'Tuyến vận chuyển'),
                                items: tuyen.map((String text) {
                                  return new DropdownMenuItem(
                                    child: Container(
                                        child: Text(text,
                                            style: TextStyle(fontSize: 15))),
                                    value: text,
                                  );
                                }).toList(),
                                value: dropdownValue,
                                onChanged: (t1) {
                                  setState(() {
                                    // tinh = t1;
                                  });
                                },
                                hint: Text('Lựa chọn...'),
                                menuMaxHeight: 200,
                                validator: (vl1) {
                                  if (vl1 == null || vl1.isEmpty) {
                                    return 'Chưa chọn trạng thái';
                                  }
                                  return null;
                                },
                              ),
                              DropdownButtonFormField(
                                decoration: InputDecoration(
                                    labelText: 'Giờ xuất bến kế hoạch'),
                                items: diem.map((String text) {
                                  return new DropdownMenuItem(
                                    child: Container(
                                        child: Text(text,
                                            style: TextStyle(fontSize: 15))),
                                    value: text,
                                  );
                                }).toList(),
                                value: dropdownValue,
                                hint: Text('Chọn điểm đến'),
                                menuMaxHeight: 200,
                                validator: (vl1) {
                                  if (vl1 == null || vl1.isEmpty) {
                                    return 'Chưa chọn trạng thái';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              RaisedButton(
                                onPressed: () {},
                                child: Text(
                                  'XÁC NHẬN',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                color: Colors.blue,
                              )
                            ],
                          ),
                        );
                      });
                    });
              },
              icon: Icon(Icons.filter_list))
        ],
      ),
      body: FutureBuilder<DSLenh>(
        future: DSLenhFuture,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Lỗi'),
            );
          } else if (snapshot.hasData) {
            DSLenh getdata = snapshot.data;
            Data datatemp = getdata.data;
            List<Lenh> listdata = datatemp.list;
            // print('tttttt: ${listdata[0].bienKiemSoat}');
            return ListView.builder(
                itemCount: listdata.length,
                itemBuilder: (context, index) {
                  var time;

                  time = DateTime.parse(listdata[index].thoiGianXuatBenKeHoach)
                      .toLocal();

                  String timeHieuLuc =
                      DateFormat('kk:mm dd/MM/yyyy').format(time);
                  return listdata[index].idTrangThai == 1
                      ? itemWhenAccepted(
                          timeHieuLuc, listdata, index, context, widthScreen)
                      : itemWhenNotAccepted(timeHieuLuc, listdata, index);
                });
          }
          return Center(
            child: Text('Không có dữ liệu'),
          );
        }),
      ),
    );
  }

  Container itemWhenNotAccepted(
      String timeHieuLuc, List<Lenh> listdata, int index) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey[400].withOpacity(0.7),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.grey[400].withOpacity(0.7),
                offset: Offset(5, 5),
                blurRadius: 3,
                spreadRadius: 0.6)
          ]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset('asset/icons/clock.svg',
                      width: 18, height: 18),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${timeHieuLuc}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              SvgPicture.asset('asset/icons/sohieu.svg', width: 18, height: 18),
              SizedBox(
                width: 10,
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: '${listdata[index].bienKiemSoat}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black)),
                TextSpan(
                    text: '(',
                    style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        color: Colors.black)),
                TextSpan(
                    text: '${listdata[index].maLenh}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue)),
                TextSpan(
                    text: ')',
                    style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ])),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              SvgPicture.asset('asset/icons/buslocation.svg',
                  width: 19, height: 19),
              SizedBox(
                width: 10,
              ),
              Text(
                '${listdata[index].tenTuyen}\n(${listdata[index].maTuyen})',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              SvgPicture.asset('asset/icons/bus-stop.svg',
                  width: 18, height: 18),
              SizedBox(
                width: 10,
              ),
              Text(
                '${listdata[index].tenBenXe}',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              SvgPicture.asset('asset/icons/card-account-details-outline.svg',
                  width: 18, height: 18),
              SizedBox(
                width: 10,
              ),
              Text(
                '${listdata[index].tenLaiXe}',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              SvgPicture.asset('asset/icons/format-list-checks.svg',
                  width: 18, height: 18),
              SizedBox(
                width: 10,
              ),
              Text(
                '${listdata[index].tenTrangThai}',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.orange),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Container itemWhenAccepted(String timeHieuLuc, List<Lenh> listdata, int index,
      BuildContext context, double widthScreen) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey[400].withOpacity(0.7),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.grey[400].withOpacity(0.7),
                offset: Offset(5, 5),
                blurRadius: 3,
                spreadRadius: 0.6)
          ]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset('asset/icons/clock.svg',
                      width: 18, height: 18),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${timeHieuLuc}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              SvgPicture.asset('asset/icons/sohieu.svg', width: 18, height: 18),
              SizedBox(
                width: 10,
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: '${listdata[index].bienKiemSoat}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black)),
                TextSpan(
                    text: '(',
                    style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        color: Colors.black)),
                TextSpan(
                    text: '${listdata[index].maLenh}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue)),
                TextSpan(
                    text: ')',
                    style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ])),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              SvgPicture.asset('asset/icons/buslocation.svg',
                  width: 19, height: 19),
              SizedBox(
                width: 10,
              ),
              Text(
                '${listdata[index].tenTuyen}\n(${listdata[index].maTuyen})',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              SvgPicture.asset('asset/icons/bus-stop.svg',
                  width: 18, height: 18),
              SizedBox(
                width: 10,
              ),
              Text(
                '${listdata[index].tenBenXe}',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              SvgPicture.asset('asset/icons/card-account-details-outline.svg',
                  width: 18, height: 18),
              SizedBox(
                width: 10,
              ),
              Text(
                '${listdata[index].tenLaiXe}',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              SvgPicture.asset('asset/icons/format-list-checks.svg',
                  width: 18, height: 18),
              SizedBox(
                width: 10,
              ),
              Text(
                '${listdata[index].tenTrangThai}',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.orange),
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FlatButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(builder: (context, setState) {
                            return Container(
                              padding: EdgeInsets.all(15),
                              height: 250,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: widthScreen * 0.32),
                                        child: Text('Từ chối lệnh',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Hủy',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 15)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(children: [
                                    Text('Mã số lệnh: ',
                                        style: TextStyle(fontSize: 13)),
                                    Text('LCV-0000187/SPCT',
                                        style: TextStyle(fontSize: 16)),
                                  ]),
                                  Form(
                                    key: formKey,
                                    child: TextFormField(
                                      controller: lidoController,
                                      decoration: InputDecoration(
                                          labelText: 'Lí do(*)'),
                                      validator: (vl) {
                                        if (vl == null || vl.isEmpty) {
                                          return 'Lí do không được để trống';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  RaisedButton(
                                    onPressed: () {
                                      formKey.currentState.validate();
                                    },
                                    child: Text(
                                      'XÁC NHẬN',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    color: Colors.blue,
                                  )
                                ],
                              ),
                            );
                          });
                        });
                  },
                  child: Text('TỪ CHỐI', style: TextStyle(color: Colors.red)),
                  height: 18,
                  // color: Colors.black,
                ),
                VerticalDivider(
                  width: 2,
                  thickness: 1.5,
                ),
                FlatButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                  'Bạn có chắc chắn muốn tiếp nhận lệnh điện tử ${listdata[index].maTuyen} không?'),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Hủy'),
                                  child: const Text(
                                    'Hủy',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text('Xác nhận'),
                                ),
                              ],
                            );
                          });
                    },
                    child:
                        Text('TIẾP NHẬN', style: TextStyle(color: Colors.blue)),
                    height: 18)
              ],
            ),
          )
        ],
      ),
    );
  }
}
