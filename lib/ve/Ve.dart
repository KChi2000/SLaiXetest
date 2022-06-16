import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_ui_kit/other/homeConstant.dart';
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

class Ve extends StatefulWidget {
  @override
  VeState createState() {
    return VeState();
  }
}

class VeState extends State<Ve> {
  var _articleTitle = ['Knife Skills', 'Everyday basics', 'Some beautiful'];
double spacebetween = 20;
double spaceRow = 20; 
double marginRowLeft = 15;
bool flag=false;
  int choose = 0;
  String title = moveList.first.name;
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return StatefulBuilder(builder: (context, setState) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                          vertical: paddingVertical, horizontal: paddingHori),
                      height: bottomSheetHeight,
                      child: Column(
                        children: [
                          Text(titleBottomSheet,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: fontStyle,
                                  fontSize: fontSize)),
                          SizedBox(
                            height: spaceBetween,
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
                                            iconBottomSheet,
                                            color: choose == index
                                                ? selectedColor
                                                : unselectedColor,
                                            width: iconSizeBottomSheet,
                                            height: iconSizeBottomSheet,
                                          ),
                                          Text(
                                            ' ${moveList[index].name}',
                                            style: TextStyle(
                                                color: choose == index
                                                    ? selectedColor
                                                    : unselectedColor),
                                          ),
                                          Text(' | ',
                                              style: TextStyle(
                                                  color: choose == index
                                                      ? selectedColor
                                                      : unselectedColor)),
                                          Text('${moveList[index].time}',
                                              style: TextStyle(
                                                  color: choose == index
                                                      ? selectedColor
                                                      : unselectedColor))
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
                  color: appBartextColor,
                  fontWeight: fontStyleappBar,
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
                      arrowDown,
                      size: arrowDownSize,
                      color: arrowDownColor,
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
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Text('Sơ đồ chỗ xe khách',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18)),
            Expanded(
                child: Column(
              children: [
                Row(
                  children: [Text('aaaa')],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 50,
                          width: 6,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8))),
                        ),
                        SizedBox(
                          height: 230,
                        ),
                        Container(
                          height: 50,
                          width: 6,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8))),
                        ),
                      ],
                    ),
                    Container(
                      width: widthScreen - 35,
                      height: heightScreen * 0.65,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey[400], width: 3.5),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 2,
                          ),
                          Container(
                            width: widthScreen - 35 - 20,
                            height: 20,
                            decoration: BoxDecoration(
                                color: Colors.grey[350],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                    height: 15,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10)))),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                    height: 13,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 0,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Stack(
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      seatItem('LX',(){
                                          setState(() {
                                            flag== !flag;
                                          });
                                      },flag),
                                    ],
                                  ),
                                  Positioned(
                                      bottom: 35,
                                      left: 12,
                                      child: Image.asset(
                                        'asset/images/volant.png',
                                        width: 20,
                                        height: 20,
                                      ))
                                ],
                              ),
                              SizedBox(
                                width: 150,
                              ),
                              seatItem('17',(){
                                          setState(() {
                                            flag= !flag;
                                          });
                                      },flag),
                              SizedBox(
                                width: spacebetween,
                              ),
                              seatItem('23',(){
                                          setState(() {
                                            flag== !flag;
                                          });
                                      },flag)
                            ],
                          ),
                          SizedBox(
                            height: spaceRow,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              seatItem('2',(){
                                          setState(() {
                                            flag== !flag;
                                          });
                                      },flag),
                              SizedBox(
                                width: spacebetween,
                              ),
                              seatItem('9',(){
                                          setState(() {
                                            flag== !flag;
                                          });
                                      },flag),
                              SizedBox(
                                width: 150,
                              ),
                              seatItem('24',(){
                                          setState(() {
                                            flag== !flag;
                                          });
                                      },flag)
                            ],
                          ),
                          SizedBox(
                            height: spaceRow,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              seatItem('3',(){
                                          setState(() {
                                            flag== !flag;
                                          });
                                      },flag),
                              SizedBox(
                                width: spacebetween,
                              ),
                              seatItem('10',(){
                                          setState(() {
                                            flag== !flag;
                                          });
                                      },flag),
                            ],
                          ),
                          SizedBox(
                            height: spaceRow,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              seatItem('4',(){
                                          setState(() {
                                            flag== !flag;
                                          });
                                      },flag),
                              SizedBox(
                                width: spacebetween,
                              ),
                              seatItem('11',(){
                                          setState(() {
                                            flag== !flag;
                                          });
                                      },flag),
                              SizedBox(
                                width: 85,
                              ),
                              seatItem('18',(){
                                          setState(() {
                                            flag== !flag;
                                          });
                                      },flag),
                              SizedBox(
                                width: spacebetween,
                              ),
                              seatItem('25',(){
                                          setState(() {
                                            flag== !flag;
                                          });
                                      },flag)
                            ],
                          ),
                          SizedBox(
                            height: spaceRow,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              seatItem('5',(){
                                          setState(() {
                                            flag== !flag;
                                          });
                                      },flag),
                              SizedBox(
                                width: spacebetween,
                              ),
                              seatItem('12',(){
                                          setState(() {
                                            flag== !flag;
                                          });
                                      },flag),
                              SizedBox(
                                width: 85,
                              ),
                              seatItem('19',(){
                                          setState(() {
                                            flag== !flag;
                                          });
                                      },flag),
                              SizedBox(
                                width: spacebetween,
                              ),
                              seatItem('26',(){
                                          setState(() {
                                            flag== !flag;
                                          });
                                      },flag)
                            ],
                          ),
                          SizedBox(
                            height: spaceRow,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              seatItem('6',(){
                                          setState(() {
                                            flag== !flag;
                                          });
                                      },flag),
                              SizedBox(
                                width: spacebetween,
                              ),
                              seatItem('13',(){
                                          setState(() {
                                            flag== !flag;
                                          });
                                      },flag),
                              SizedBox(
                                width: 85,
                              ),
                              seatItem('20',(){
                                          setState(() {
                                            flag== !flag;
                                          });
                                      },flag),
                              SizedBox(
                                width: spacebetween,
                              ),
                              seatItem('27',(){
                                          setState(() {
                                            flag== !flag;
                                          });
                                      },flag)
                            ],
                          ),
                          SizedBox(
                            height: spaceRow,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              seatItem('7',(){
                                          setState(() {
                                            flag== !flag;
                                          });
                                      },flag),
                              SizedBox(
                                width: spacebetween,
                              ),
                              seatItem('14',(){
                                          setState(() {
                                            flag== !flag;
                                          });
                                      },flag),
                              SizedBox(
                                width: 85,
                              ),
                              seatItem('21',(){
                                          setState(() {
                                            flag== !flag;
                                          });
                                      },flag),
                              SizedBox(
                                width: spacebetween,
                              ),
                              seatItem('28',(){
                                          setState(() {
                                            flag== !flag;
                                          });
                                      },flag)
                            ],
                          ),
                          SizedBox(
                            height: spaceRow,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              seatItem('8',(){
                                          setState(() {
                                            flag== !flag;
                                          });
                                      },flag),
                              SizedBox(
                                width: spacebetween,
                              ),
                              seatItem('15',(){
                                          setState(() {
                                            flag== !flag;
                                          });
                                      },flag),
                              SizedBox(
                                width: spacebetween,
                              ),
                              seatItem('16',(){
                                          setState(() {
                                            flag== !flag;
                                          });
                                      },flag),
                              SizedBox(
                                width: spacebetween,
                              ),
                              seatItem('22',(){
                                          setState(() {
                                            flag== !flag;
                                          });
                                      },flag),
                              SizedBox(
                                width: spacebetween,
                              ),
                              seatItem('29',(){
                                          setState(() {
                                            flag== !flag;
                                          });
                                      },flag)
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          height: 50,
                          width: 6,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  bottomRight: Radius.circular(8))),
                        ),
                        SizedBox(
                          height: 230,
                        ),
                        Container(
                          height: 50,
                          width: 6,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  bottomRight: Radius.circular(8))),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => banve()));
        },
        label: Text(
          buttonText,
          style: TextStyle(
            color: buttonColorText,
          ),
        ),
        icon: SvgPicture.asset(
          iconButton,
          color: buttonColor,
        ),
        backgroundColor: buttonBackground,
      ),
    );
  }

  Stack seatItem(String num, VoidCallback click,bool fla) {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Container(
              height: 35,
              width: 45,
              decoration: BoxDecoration(
                color: Colors.grey[350],
              ),
            ),
          ],
        ),
        Positioned(
            left: 3,
            child: Stack(
              children: [
                InkWell(
                  onTap: click,
                  child: fla == true?Container(
                    height: 35,
                    width: 39,
                    decoration: BoxDecoration(
                        color: Colors.blue[600],
                        // border: Border.all(color: Colors.grey[350]),
                        borderRadius: BorderRadius.circular(4)),
                    child: Center(child: SvgPicture.asset('asset/icons/account-check.svg',color: Colors.white,)),
                  ) :Container(
                    height: 35,
                    width: 39,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey[350]),
                        borderRadius: BorderRadius.circular(4)),
                    child: Center(child: Text(num)),
                  ),
                ),
                Positioned(
                    top: 30,
                    left: 7,
                    child: Container(
                      height: 5,
                      width: 24,
                      decoration: BoxDecoration(
                          color: Colors.grey[350],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(3),
                              topRight: Radius.circular(3))),
                    )),
              ],
            )),
      ],
    );
  }
}
// Column(
            //   children: [
            //     Text('Xe của bạn chưa có trên sơ đồ ghế.'),
            //     Text('Vui lòng liên hệ Công ty của bạn để được cập nhật !')
            //   ],
            // )