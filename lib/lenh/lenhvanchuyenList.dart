import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class lenhvanchuyenList extends StatefulWidget {
  const lenhvanchuyenList({Key key}) : super(key: key);

  @override
  State<lenhvanchuyenList> createState() => _lenhvanchuyenListState();
}

class _lenhvanchuyenListState extends State<lenhvanchuyenList> {
  final trangthai = [
    'Tất cả',
    'Chưa thực hiện',
    'Đã hoàn thành',
    'Không hoàn thành'
  ];
  final tuyen=[
    'không có dữ liệu'
  ];
  final diem=[
    'không có dữ liệu'
  ];
  String dropdownValue;
  String dateString = '';
  DateTime date=DateTime.now();
  final timeController = TextEditingController(
      text: DateFormat('dd-MM-yyyy').format(DateTime.now()));
  @override
  Widget build(BuildContext context) {
   dateString = DateFormat('dd-MM-yyyy').format(date);

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
                      return Container(
                        padding: EdgeInsets.all(15),
                        height: 450,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text('Lọc dữ liệu',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Hủy',
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 15)),
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
                              // initialValue: datetime,

                              onTap: () async {
                                // Below line stops keyboard from appearing
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                // Show Date Picker Here
                                await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(3000)).then((value) {
                                       if (value == null) {
                                  setState(() {
                                    date = DateTime.now();
                                  });
                                } else{
                                 setState(() {
                                    date = value;
                                 });
                                }
                                    });
                               
                              },
                            ),
                            DropdownButtonFormField(
                              decoration:
                                  InputDecoration(labelText: 'Tuyến vận chuyển'),
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
                              decoration:
                                  InputDecoration(labelText: 'Giờ xuất bến kế hoạch'),
                              items: diem.map((String text) {
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
                              hint: Text('Chọn điểm đến'),
                              menuMaxHeight: 200,
                              validator: (vl1) {
                                if (vl1 == null || vl1.isEmpty) {
                                  return 'Chưa chọn trạng thái';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15,),
                            RaisedButton(
                              onPressed: () {},
                              child: Text('XÁC NHẬN',style: TextStyle(color: Colors.white,),),
                              color: Colors.blue,
                            )
                          ],
                        ),
                      );
                    });
              },
              icon: Icon(Icons.filter_list))
        ],
      ),
      body: Center(
        child: Text('Không có dữ liệu !'),
      ),
    );
  }
}
