import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';

import 'package:flutter_svg/svg.dart';
import 'package:flutter_ui_kit/helpers/ApiHelper.dart';
import 'package:flutter_ui_kit/model/DSTuyenVanChuyenTheoNgay.dart';

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
  List<DataTuyenTheoNgay> listTuyenTheoNgay = [
    new DataTuyenTheoNgay('', 'Không có dữ liệu')
  ];
  final diem = ['không có dữ liệu'];
  String dropdownValue;
  DateTime pickDatetime = DateTime.now();
  DateTime initDateTime = DateTime.now();
  final formKey = GlobalKey<FormState>();
  DateTime date = DateTime.now();
  final timeController = TextEditingController(
      text: DateFormat('dd-MM-yyyy').format(DateTime.now()));
  final searchController = TextEditingController();
  final lidoController = TextEditingController();
  var DSLenhFuture;
  DSLenh maplenh;
  var DSTuyenVanChuyenTheoNgayFuture;
  DSTuyenVanChuyenTheoNgay dstuyentheongay;
  Map<String, dynamic> postdata = {
    
  };
  var datetemp;
  var datetime = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // var aaa= _getPSTTime();

    datetemp =
        new DateTime(datetime.year, datetime.month, datetime.day, 0, 0, 0)
            .toUtc()
            .toIso8601String();
   

    loadDSLenh();
  }

  void loadDSTuyenVanChuyenTheoNgay(String day) async {
    DSTuyenVanChuyenTheoNgayFuture = ApiHelper.getDSTuyenVanChuyenTheoNgay(day);
    dstuyentheongay = await DSTuyenVanChuyenTheoNgayFuture;
    checkdropdownTuyen();
  }

  void loadDSLenh() async {
    postdata = {
      'custom': {
        'danhSachGioXuatBen': [],
        'idLuongTuyen': null,
        'ngayXuatBenKeHoach': '${datetemp.toString()}',
        'timKiem': searchController.text,
      },
      'loadOptions': {
        'searchOperation': 'contains',
        'searchValue': null,
        'skip': 0,
        'take': 20,
        'userData': {}
      },
    };
    DSLenhFuture = ApiHelper.postDsLenh(
        'http://113.176.29.57:19666/api/Driver/lay-danh-sach-tat-ca-lenh-cua-lai-xe',
        postdata);
    maplenh = await DSLenhFuture;
    setState(() {});
   
  }

  void checkdropdownTuyen() {
    if (dstuyentheongay.message != 'Không tìm thấy dữ liệu') {
      listTuyenTheoNgay = dstuyentheongay.data;
    } else {
      listTuyenTheoNgay = [new DataTuyenTheoNgay('', 'Không có dữ liệu')];
    }
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
                loadDSTuyenVanChuyenTheoNgay(
                    Uri.encodeComponent(datetime.toUtc().toIso8601String()));
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder: (context, setStateModal) {
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
                                menuMaxHeight: 200,
                                validator: (vl1) {
                                  if (vl1 == null || vl1.isEmpty) {
                                    return 'Chưa chọn trạng thái';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: searchController,
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
                                          initialDate: initDateTime,
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime(3000))
                                      .then((value) {
                                    if (value == null) {
                                      setStateModal(() {
                                        timeController.text =
                                            '${pickDatetime.day}-${pickDatetime.month}-${pickDatetime.year}';
                                      });
                                    } else {
                                      setStateModal(() {
                                        // pickDatetime = value;
                                        initDateTime = value;
                                        print('pickdatetime    $pickDatetime');
                                        pickDatetime = new DateTime(value.year,
                                            value.month, value.day, 23, 59, 59);
                                        // print('pickdatetime    ${aa}');
                                        var exdatetime = pickDatetime
                                            .toUtc()
                                            .toIso8601String();
                                        print(
                                            ' jsonendcode: ${Uri.encodeComponent(exdatetime)}');
                                        loadDSTuyenVanChuyenTheoNgay(
                                            Uri.encodeComponent(exdatetime));
                                        // checkdropdownTuyen();
                                        timeController.text =
                                            '${value.day}-${value.month}-${value.year}';
                                      });
                                   
                                    }
                                  });
                                },
                                onFieldSubmitted: (vl) {
                                  // setState() {}
                                },
                              ),
                              DropdownButtonFormField(
                                decoration: InputDecoration(
                                    labelText: 'Tuyến vận chuyển'),
                                items: listTuyenTheoNgay
                                    .map((DataTuyenTheoNgay text) {
                                  return new DropdownMenuItem(
                                    child: Container(
                                        child: Text(text.tenTuyen,
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
                                hint: Text('Chọn tuyến'),
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
                                onPressed: () {
                                  setState(() {
                                    datetemp = new DateTime(
                                            pickDatetime.year,
                                            pickDatetime.month,
                                            pickDatetime.day,
                                            0,
                                            0,
                                            0)
                                        .toUtc()
                                        .toIso8601String();
                                    loadDSLenh();
                                  });
                                  Navigator.pop(context);
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
            print(datatemp.list == null);
            if (datatemp.list == null) {
              print('aheeeeeeee');
              return Center(
                child: Text('Không có dữ liệu'),
              );
            }
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
                    fontWeight: FontWeight.bold, color: listdata[index].idTrangThai == 6? Colors.red:Colors.orange),
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
                      isScrollControlled:true,
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(builder: (context, setState) {
                            return Padding(
                              padding: MediaQuery.of(context).viewInsets,
                              child: Container(
                                padding: EdgeInsets.all(15),
                                height: 250,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
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
                                      Text('${listdata[index].maLenh}',
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
                                      onPressed: ()async {
                                        if(formKey.currentState.validate()){
                                        var resp=  await ApiHelper.post('http://l113.176.29.57:19666/api/Driver/lai-xe-huy-nhan-lenh', {
                                            'guidLenh':'${listdata[index].guidLenh}',
                                            'lyDo':'${lidoController.text}',
                                            'toaDo':''
                                          });
                                          if(resp['status']){
                                            Navigator.pop(context);
                                              setState(() {
                                                loadDSLenh();
                                              },);
                                          }else{
                                            showDialog(
                                              context: context,
                                              barrierDismissible:
                                                  false, // user must tap button!
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text('Lỗi'),
                                                  content:
                                                      Text(resp['message']),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child:
                                                          const Text('Đã hiểu'),
                                                      onPressed: () {
                                                        Navigator.of(context)
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
                                  'Bạn có chắc chắn muốn tiếp nhận lệnh điện tử ${listdata[index].maLenh} không?'),
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
                                  onPressed: () async{
                                    // print(listdata[index].guidLenh);
                                    Navigator.pop(context);
                                    var resp = await ApiHelper.post('http://113.176.29.57:19666/api/Driver/lai-xe-tiep-nhan-lenh', {
                                      'guidLenh':'${listdata[index].guidLenh}',
                                      'toaDo':''
                                    });
                                    if(resp['status']){
                                      loadDSLenh();
                                    }
                                    else{
                                      showDialog(context: context, builder: (context){
                                        return AlertDialog(
                                          title: Text('Lái xe đang thực hiện lệnh khác'),
                                          actions: [
                                             TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Đã hiểu'),
                                  child: const Text(
                                    'Đã hiểu',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                                          ],
                                        );
                                      });
                                    }
                                  },
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
