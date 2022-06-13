import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_ui_kit/details/cookdetails.dart';

import '../model/chuyendiList.dart';
import '../ve/banve.dart';

final moveList = [
  chuyendiList('HNA.22.05.001', '8.00'),
  chuyendiList('HNA.22.05.002', '9.00'),
  chuyendiList('HNA.22.05.003', '10.00'),
  chuyendiList('HNA.22.05.004', '11.00'),
  chuyendiList('HNA.22.05.005', '12.00'),
  chuyendiList('HNA.22.05.006', '13.00'),
  chuyendiList('HNA.22.05.007', '14.00'),
  chuyendiList('HNA.22.05.007', '14.00'),
  chuyendiList('HNA.22.05.007', '14.00'),
];

class HowToMakeTabPage extends StatefulWidget {
  @override
  HowToMakeTabPageState createState() {
    return HowToMakeTabPageState();
  }
}

class HowToMakeTabPageState extends State<HowToMakeTabPage> {
  var _articleTitle = ['Knife Skills', 'Everyday basics', 'Some beautiful'];

  int choose = 0;
  String title = moveList.first.name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return StatefulBuilder(builder: (context, setState) {
                    return Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      height: 350,
                      child: Column(
                        children: [
                          Text('Lịch sử chuyến đi',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      choose = index;
                                      title = moveList[index].name;
                                      print(title);
                                      Navigator.pop(context);
                                    });
                                  },
                                  child: Container(
                                      height: 45,
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            'asset/icons/bus.svg',
                                            color: choose == index
                                                ? Colors.blue
                                                : Colors.black,
                                            width: 17,
                                            height: 17,
                                          ),
                                          Text(
                                            ' ${moveList[index].name}',
                                            style: TextStyle(
                                                color: choose == index
                                                    ? Colors.blue
                                                    : Colors.black),
                                          ),
                                          Text(' | ',
                                              style: TextStyle(
                                                  color: choose == index
                                                      ? Colors.blue
                                                      : Colors.black)),
                                          Text('${moveList[index].time}',
                                              style: TextStyle(
                                                  color: choose == index
                                                      ? Colors.blue
                                                      : Colors.black))
                                        ],
                                      )),
                                );
                              },
                              itemCount: moveList.length,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                            ),
                          )
                        ],
                      ),
                    );
                  });
                });
          },
          child: Row(
            children: [
              Text(
                "PTH.22.06.0009",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 25,
                      color: Colors.white,
                    ),
                  ))
            ],
          ),
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.qr_code_scanner_rounded,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
        actionsIconTheme: IconThemeData(
          color: Colors.grey,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Xe của bạn chưa có trên sơ đồ ghế.'),
            Text('Vui lòng liên hệ Công ty của bạn để được cập nhật !')
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>banve()));
        },
        label: Text(
          'BÁN VÉ',
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
        icon: SvgPicture.asset(
          'asset/icons/ticket.svg',
          color: Colors.blue,
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
