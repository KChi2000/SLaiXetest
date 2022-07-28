import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_ui_kit/model/DSHanhKhachMuaVe.dart';
import 'package:intl/intl.dart';

import '../helpers/ApiHelper.dart';
import '../model/lenhModel.dart';

class chuyndoilenh extends StatefulWidget {
  String idLenhdientu;
  chuyndoilenh(this.idLenhdientu);

  @override
  State<chuyndoilenh> createState() => _chuyndoilenhState();
}

class _chuyndoilenhState extends State<chuyndoilenh> {
  DateTime date = DateTime.now();
  var DSLenhFuture;
  String dateString = '';
  Map<String, dynamic> postdata = {};
  var datetemp;
  var datetime = DateTime.now();
  List<DataDSHangKhachMuaVe> listCheck = [];
  var DshanhkhachmuaveFuture;
  void Function(void Function()) setstatecheck;
  bool AllChecked = false;
  //DSHangKhachMuaVe
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    datetemp =
        new DateTime(datetime.year, datetime.month, datetime.day, 0, 0, 0)
            .toUtc()
            .toIso8601String();

    loadDSLenh();
    print(widget.idLenhdientu);
  }

  void loadDSLenh() async {
    postdata = {
      'custom': {
        'danhSachGioXuatBen': [],
        'idLuongTuyen': null,
        'ngayXuatBenKeHoach': '${datetemp.toString()}',
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
    DSLenhFuture = ApiHelper.postDsLenh(
        'http://113.176.29.57:19666/api/Driver/lay-danh-sach-lenh-dien-tu-chua-thuc-hien',
        postdata);

    // }
  }

  void loadDSHanhKhachTrenXe() {
    DshanhkhachmuaveFuture = ApiHelper.getDSHanhKhachMuaVe(widget.idLenhdientu);
  }

  void setAllChecked(bool vl) {
    setstatecheck(() {
      AllChecked = vl;
      listCheck.forEach((element) {
        setstatecheck(() {
          element.check = vl;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    Size sizeScreen = MediaQuery.of(context).size;
    dateString = DateFormat('dd-MM-yyyy').format(date);

    return Scaffold(
      appBar: AppBar(
        title: Text('CHUYỂN ĐỔI LỆNH'),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              setState(() {
                loadDSLenh();
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                'LỌC',
                style: TextStyle(fontSize: 18),
              )),
            ),
          )
        ],
      ),
      body: Container(
        width: sizeScreen.width,
        height: sizeScreen.height,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Chọn ngày',
                  style: TextStyle(fontSize: 16),
                ),
                GestureDetector(
                  onTap: () {
                    showDatePicker(
                            context: context,
                            initialDate: date,
                            firstDate: DateTime(1900),
                            lastDate: DateTime(3000))
                        .then((value) {
                      if (value == null) {
                        return;
                      } else {
                        setState(() {
                          date = value;
                          datetemp = new DateTime(
                                  value.year, value.month, value.day, 0, 0, 0)
                              .toUtc()
                              .toIso8601String();
                        });
                      }
                    });
                    // setState(() {
                    //   dateString = DateFormat('dd-MM-yyyy').format(date);
                    // });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    // width: 100,
                    height: 45,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$dateString',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Center(child: Icon(Icons.calendar_month))
                          ]),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            FutureBuilder<DSLenh>(
              future: DSLenhFuture,
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Expanded(
                    child: Center(
                      child: Text('Lỗi'),
                    ),
                  );
                } else if (snapshot.hasData) {
                  DSLenh getdata = snapshot.data;
                  Data datatemp = getdata.data;

                  if (!getdata.status) {
                    print('aheeeeeeee');
                    return Expanded(
                      child: Center(
                        child: Text('Không có dữ liệu'),
                      ),
                    );
                  }
                  List<Lenh> listdata = datatemp.list;
                  return Expanded(
                    child: ListView.builder(
                        itemCount: listdata.length,
                        itemBuilder: (context, index) {
                          var time;

                          time = DateTime.parse(
                                  listdata[index].thoiGianXuatBenKeHoach)
                              .toLocal();

                          String timeHieuLuc =
                              DateFormat('kk:mm dd/MM/yyyy').format(time);
                          return itemWhenAccepted(timeHieuLuc, listdata, index,
                              context, widthScreen);
                        }),
                  );
                }
                return Center(
                  child: Text('Không có dữ liệu'),
                );
              }),
            ),
          ],
        ),
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
            height: 12,
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
            height: 12,
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
            height: 12,
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
            height: 12,
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
            height: 12,
          ),
          Divider(
            thickness: 1.5,
            height: 1,
          ),
          SizedBox(
            height: 40,
            child: FlatButton(
              onPressed: () {
                loadDSHanhKhachTrenXe();
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder: (context, setState) {
                        setstatecheck = setState;
                        return Container(
                          padding: EdgeInsets.all(15),
                          // height: 400,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                            FutureBuilder<DSHanhKhachMuaVe>(
                              future: DshanhkhachmuaveFuture,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                if (snapshot.hasData) {
                                  DSHanhKhachMuaVe dshanhkhachmuave =
                                      snapshot.data;
                                  listCheck = dshanhkhachmuave.data;
                                  if (listCheck.length == 0) {
                                    return Center(
                                      child: Column(
                                        children: [
                                          Image.asset('asset/images/warning.png',width: 80,height: 80,),
                                          SizedBox(height: 10,),
                                          Text('Xác nhận chuyển đổi lệnh',style: TextStyle(fontSize: 18),),
                                          Text('Bạn có chắc chắn muốn chuyên sang lệnh'),
                                          Text('${listdata[0].maLenh}',style: TextStyle(fontSize: 16)),
                                          SizedBox(height: 10,)
                                        ],
                                      ),
                                    );
                                  }
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Danh sách vé chuyển đổi lệnh',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      Expanded(
                                        child: ListView(
                                          children: [
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Checkbox(
                                                        value: AllChecked,
                                                        onChanged:
                                                            setAllChecked),
                                                    Text(
                                                        'Tất cả(${listCheck.length})')
                                                  ],
                                                ),
                                                Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.7,
                                                    child: Divider(
                                                      color: Colors.black,
                                                    ))
                                              ],
                                            ),
                                            ...listCheck
                                                .map(itemChuyenDoiLenh)
                                                .toList()
                                          ],
                                        ),
                                      ),
                                      
                                    ],
                                  );
                                }
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text('Lỗi'),
                                  );
                                }
                                return Center(
                                  child: Text('Không có dữ liệu'),
                                );
                              }),
                              Divider(
                                        thickness: 1.5,
                                        height: 1,
                                      ),
                                      IntrinsicHeight(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            FlatButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('HỦY',
                                                  style: TextStyle(
                                                      color: Colors.red)),
                                              height: 18,
                                              // color: Colors.black,
                                            ),
                                            VerticalDivider(
                                              width: 2,
                                              thickness: 1.5,
                                            ),
                                            FlatButton(
                                                onPressed: () {
                                                  print('idlenh cu: ${widget.idLenhdientu}');
                                                   print('idlenh moi: ${listdata.first.guidLenh}');
                                                var resp = ApiHelper.post('http://113.176.29.57:19666/api/Driver/lai-xe-chuyen-doi-chuyen-di', {
                                                  'ToaDo':'',
                                                  'idDonHangs':[],
                                                  'idLenhCu':'${widget.idLenhdientu}',
                                                  'idLenhMoi':'${listdata.first.guidLenh}'
                                                });
                                                },
                                                child: Text('ĐỒNG Ý',
                                                    style: TextStyle(
                                                        color: Colors.blue)),
                                                height: 18)
                                          ],
                                        ),
                                      )
                          ],),
                        );
                      });
                    });
              },
              child:
                  Text('CHỌN LỆNH NÀY', style: TextStyle(color: Colors.blue)),
              height: 15,
              // color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Column itemChuyenDoiLenh(DataDSHangKhachMuaVe vl) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Checkbox(
                value: vl.check,
                onChanged: (value) {
                  setstatecheck(() {
                    print(value);
                    vl.check = value;
                  });
                }),
            SizedBox(
              width: 10,
            ),
            Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Số điện thoại: ', style: TextStyle(color: Colors.black)),
                SizedBox(
                  height: 5,
                ),
                Text('Giá vé: ', style: TextStyle(color: Colors.black)),
                SizedBox(
                  height: 5,
                ),
                Text('Điểm xuống: ', style: TextStyle(color: Colors.black)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${vl.soDienThoai}',
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text('${vl.thanhTien}đ',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 5,
                ),
                Text('${vl.tenDiemXuong}',
                    style: TextStyle(
                        color: Colors.orange, fontWeight: FontWeight.bold)),
              ],
            )
          ],
        ),
        Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Divider(
              color: Colors.black,
            ))
      ],
    );
  }
}
