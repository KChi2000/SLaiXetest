import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_ui_kit/model/lenhvanchuyen.dart';
import 'package:intl/intl.dart';

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
  final vanchuyenList = [
    lenhvanchuyen(
        '11:00',
        '11/06/2022',
        '20B-00111',
        'LVC-0000202/SPCT',
        'Bến xe Thái Nguyên',
        'Bến xe Việt trì',
        'TT TP Thái Nguyên',
        'Nguyễn Công Tuyến',
        'Chờ kích hoạt')
  ];
  final formKey = GlobalKey<FormState>();
  DateTime date = DateTime.now();
  final timeController = TextEditingController(
      text: DateFormat('dd-MM-yyyy').format(DateTime.now()));
  final lidoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
      body: vanchuyenList.length != 0
          ? Container(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.all(0),
              child: ListView.builder(
                  itemCount: vanchuyenList.length,
                  itemBuilder: (context, index) {
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
                                    '${vanchuyenList[index].time} ${vanchuyenList[index].date}',
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
                              SvgPicture.asset('asset/icons/sohieu.svg',
                                  width: 18, height: 18),
                              SizedBox(
                                width: 10,
                              ),
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: '${vanchuyenList[index].bienso}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                                TextSpan(
                                    text: '(',
                                    style: TextStyle(
                                        // fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                                TextSpan(
                                    text: '${vanchuyenList[index].sohieu}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue)),
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
                                '${vanchuyenList[index].diemdi} - ${vanchuyenList[index].diemden}\n(1920.1111.A)',
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
                                '${vanchuyenList[index].diadiem}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                  'asset/icons/card-account-details-outline.svg',
                                  width: 18,
                                  height: 18),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${vanchuyenList[index].laixe}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                  'asset/icons/format-list-checks.svg',
                                  width: 18,
                                  height: 18),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${vanchuyenList[index].status}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange),
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
                                          return StatefulBuilder(
                                              builder: (context, setState) {
                                            return Container(
                                              padding: EdgeInsets.all(15),
                                              height: 250,
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: widthScreen *
                                                                0.32),
                                                        child: Text(
                                                            'Từ chối lệnh',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18)),
                                                      ),
                                                      Expanded(
                                                        child: Align(
                                                          alignment: Alignment
                                                              .topRight,
                                                          child: InkWell(
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text('Hủy',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red,
                                                                    fontSize:
                                                                        15)),
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
                                                        style: TextStyle(
                                                            fontSize: 13)),
                                                    Text('LCV-0000187/SPCT',
                                                        style: TextStyle(
                                                            fontSize: 16)),
                                                  ]),
                                                  Form(
                                                    key: formKey,
                                                    child: TextFormField(
                                                      controller: lidoController,
                                                      decoration: InputDecoration(
                                                          labelText: 'Lí do(*)'),
                                                      validator: (vl) {
                                                        if (vl == null ||
                                                            vl.isEmpty) {
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
                                  child: Text('TỪ CHỐI',
                                      style: TextStyle(color: Colors.red)),
                                  height: 18,
                                  // color: Colors.black,
                                ),
                                VerticalDivider(
                                  width: 2,
                                  thickness: 1.5,
                                ),
                                FlatButton(
                                    onPressed: () {
                                      showDialog(context: context, builder: (context){
                                        return AlertDialog(
                                          title: Text('Bạn có chắc chắn muốn tiếp nhận lệnh điện tử ${vanchuyenList[index].sohieu} không?'),
                                          actions: [
                                            TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Hủy'),
                                child: const Text('Hủy',style: TextStyle(color: Colors.red),),
                              ),
                              TextButton(
                                onPressed: () {
                                  
                                },
                                child: const Text('Xác nhận'),
                              ),
                                          ],
                                        );
                                      });
                                    },
                                    child: Text('TIẾP NHẬN',
                                        style: TextStyle(color: Colors.blue)),
                                    height: 18)
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            )
          : Center(
              child: Text('Không có dữ liệu !'),
            ),
    );
  }
}
