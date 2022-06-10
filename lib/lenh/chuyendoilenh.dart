import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class chuyndoilenh extends StatefulWidget {
  const chuyndoilenh({Key key}) : super(key: key);

  @override
  State<chuyndoilenh> createState() => _chuyndoilenhState();
}

class _chuyndoilenhState extends State<chuyndoilenh> {
  DateTime date = DateTime.now();
  String dateString = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     
  }

  @override
  Widget build(BuildContext context) {
    dateString = DateFormat('dd-MM-yyyy').format(date);
    return Scaffold(
      appBar: AppBar(
        title: Text('CHUYỂN ĐỔI LỆNH'),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              print('aaaaa');
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
                          if(value==null){
                            return;
                          }
                          else{
                            setState(() {
                              date = value;
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
            )
          ],
        ),
      ),
    );
  }
}
