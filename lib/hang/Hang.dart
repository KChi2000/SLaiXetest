import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_ui_kit/model/chuyendiList.dart';
import 'package:image_picker/image_picker.dart';
import '../other/homeConstant.dart';
import 'hangDetail.dart';
import 'hangDetail.dart';
import 'layhangInfo.dart';
import '../model/hangList.dart';

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

class Hang extends StatefulWidget {
  @override
  HangState createState() {
    return HangState();
  }
}

class HangState extends State<Hang> {
  int choose = 0;
  String title='';
  String value=moveList.first.name;
  XFile imageitem;
  final image = [];
  final List<hangList> itemList = [
    hangList('Bến xe Hà Nam', '200,000', '0986747472', false),
    hangList('Bến xe Hà Nội', '100,000', '0986747472', false),
  ];
  int count, itemclick;
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print('init');
  }

  @override
  Widget build(BuildContext context) {
    // title = moveList.first.name;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          title: Container(
              height: itemListHeightHang,
              width: MediaQuery.of(context).size.width * itemListwidthtHang,
              child: TextField(
                // autofocus: true,
                // textAlign: TextAlign.start,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    prefixIcon: Icon(searchIcon),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(searchBoxRadius)),
                      borderSide: const BorderSide(
                        color: searchBoxColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    hintText: 'nhập để tìm kiếm'),
              )),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          actions: <Widget>[
            GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(right: 5),
                  width: 40,
                  // height: 40,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue),
                  child: Center(
                      child: Text(
                    '0',
                    style: TextStyle(color: Colors.black),
                  )),
                ),
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 30),
                            height: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                itemBottomSheet(
                                    Colors.orange, 'Chưa giao: ', '0'),
                                itemBottomSheet(
                                    Colors.green, 'Đang giao: ', '0'),
                                itemBottomSheet(Colors.red, 'Hủy: ', '0'),
                              ],
                            ));
                      });
                })
          ],
          actionsIconTheme: IconThemeData(
            color: Colors.pink,
          ),
        ),
      ),
      body: itemList.length != 0
          ? Container(
              padding: EdgeInsets.only(right: 15, top: 15, left: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          print('you tapped me');
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(
                                    builder: (context, setstate) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 30),
                                    height: 350,
                                    child: Column(
                                      children: [
                                        Text('Lịch sử chuyến đi',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: fontStyleTitleBottomSheet,
                                                fontSize: fontsizetitleBottomSheet)),
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
                                                    title =
                                                        moveList[index].name;
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
                                                              ? Colors.blue
                                                              : Colors.black,
                                                          width: 17,
                                                          height: 17,
                                                        ),
                                                        Text(
                                                          ' ${moveList[index].name}',
                                                          style: TextStyle(
                                                              color: choose ==
                                                                      index
                                                                  ? selectedColor
                                                                  : unselectedColor),
                                                        ),
                                                        Text(' | ',
                                                            style: TextStyle(
                                                                color: choose ==
                                                                        index
                                                                    ? selectedColor
                                                                    : unselectedColor)),
                                                        Text(
                                                            '${moveList[index].time}',
                                                            style: TextStyle(
                                                                color: choose ==
                                                                        index
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
                              }).whenComplete(() {
                                setState(() {
                                  value = title;
                                  print('value: '+title);
                                });
                              });
                        },
                        child: Container(
                          decoration: BoxDecoration(),
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            Text(value),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 5),
                              child: RotatedBox(
                                  quarterTurns: 3,
                                  child: Icon(
                                    arrowDown,
                                    size: arrowDownSizehang,
                                  )),
                            )
                          ]),
                        ),
                      ),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: 'Tổng: ',
                            style: TextStyle(color: Colors.black)),
                        TextSpan(
                            text: '100,000đ',
                            style: TextStyle(
                                color: tongtienColor,
                                fontWeight: FontWeight.bold)),
                      ]))
                    ],
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: itemList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(top: marginItemList),
                              decoration: BoxDecoration(
                                  color: itemListColor,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(0, 0))
                                  ],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              padding: EdgeInsets.only(
                                  top: 10, left: 10, right: 10, bottom: 0),
                              child: Banner(
                                message: 'Chưa thu',
                                location: bannerLocation,
                                color: bannerColorhang,
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              print('image');
                                            },
                                            child: Image.asset(
                                              'asset/images/11.jpg',
                                              width: imageItemListWidth,
                                              height: 80,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                itemclick = index;
                                              });
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          hangDetail(
                                                              itemclick)));
                                              print(itemclick);
                                            },
                                            child: Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  itemListHang(
                                                      'Trả tại: ',
                                                      '${itemList[index].diemtra}',
                                                      Colors.black,
                                                      null),
                                                  itemListHang(
                                                      'Cước: ',
                                                      '${itemList[index].cuoc}',
                                                      Colors.orange,
                                                      null),
                                                  itemListHang(
                                                      'Người nhận: ',
                                                      '${itemList[index].sdtNhan}',
                                                      Colors.blue,
                                                      TextDecoration.underline),
                                                  RichText(
                                                      text: TextSpan(children: [
                                                    TextSpan(
                                                        text: 'Chưa giao ',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.red)),
                                                    TextSpan(
                                                        text:
                                                            '(Dự kiến: 10:23\n06/06/2022)',
                                                        style: TextStyle(
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            fontSize: 12,
                                                            color: Colors.red)),
                                                  ]))
                                                ],
                                              ),
                                            ),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            FlatButton(
                                              onPressed: () {},
                                              child: Text('IN PHIẾU',
                                                  style: TextStyle(
                                                      color: Colors.blue)),
                                              height: 20,
                                              // color: Colors.black,
                                            ),
                                            VerticalDivider(
                                              width: 2,
                                              thickness: 1.5,
                                            ),
                                            FlatButton(
                                                onPressed: () {
                                                  showModalBottomSheet(
                                                      context: context,
                                                      builder: (context) {
                                                        return Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  15),
                                                          height: 300,
                                                          child: Column(
                                                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child:
                                                                    GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          'Thoát',
                                                                          style: TextStyle(
                                                                              fontSize: 15,
                                                                              color: Colors.red),
                                                                        )),
                                                              ),
                                                              SizedBox(
                                                                height: 15,
                                                              ),
                                                              Text(
                                                                'Xác nhận trả hàng',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        18),
                                                              ),
                                                              Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                        'Ảnh: 0/2'),
                                                                    Row(
                                                                        children: [
                                                                          Checkbox(
                                                                              value: false,
                                                                              onChanged: (a) {}),
                                                                          Text(
                                                                              'In phiếu'),
                                                                        ]),
                                                                  ]),
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child:
                                                                    DottedBorder(
                                                                  child:
                                                                      GestureDetector(
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          75,
                                                                      width: 65,
                                                                      child: Center(
                                                                          child: SvgPicture.asset(
                                                                        'asset/icons/camera-plus.svg',
                                                                        color: Colors
                                                                            .black54,
                                                                      )),
                                                                    ),
                                                                    onTap: () {
                                                                      return showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (context) {
                                                                            return AlertDialog(
                                                                              content: Container(
                                                                                width: 60,
                                                                                child: Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                                  GestureDetector(
                                                                                    child: Text('Chụp ảnh mới'),
                                                                                    onTap: () async {
                                                                                      print('chọn chụp ảnh');
                                                                                      Navigator.pop(context);
                                                                                      await ImagePicker().pickImage(source: ImageSource.camera);
                                                                                    },
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 20,
                                                                                  ),
                                                                                  GestureDetector(
                                                                                    child: Text('Chọn ảnh'),
                                                                                    onTap: () async {
                                                                                      print('chọn ảnh');
                                                                                      Navigator.pop(context);
                                                                                      imageitem = await ImagePicker().pickImage(source: ImageSource.gallery);
                                                                                      if (imageitem == null) {
                                                                                        return;
                                                                                      }
                                                                                      image.add(imageitem);
                                                                                      setState(() {
                                                                                        count = image.length;
                                                                                      });
                                                                                    },
                                                                                  ),
                                                                                ]),
                                                                              ),
                                                                            );
                                                                          });
                                                                    },
                                                                  ),
                                                                  color: Colors
                                                                      .black54,
                                                                  strokeWidth:
                                                                      1,
                                                                  radius: Radius
                                                                      .circular(
                                                                          10),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Divider(
                                                                thickness: 1.5,
                                                                height: 1,
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .bottomRight,
                                                                  child: SizedBox(
                                                                      height:
                                                                          28,
                                                                      child: ElevatedButton(
                                                                          onPressed:
                                                                              () {},
                                                                          child:
                                                                              Text('XÁC NHẬN'))))
                                                            ],
                                                          ),
                                                        );
                                                      });
                                                },
                                                child: Text('TRẢ HÀNG',
                                                    style: TextStyle(
                                                        color: Colors.blue)),
                                                height: 20)
                                          ],
                                        ),
                                      )
                                    ]),
                              ),
                            );
                          }))
                ],
              ),
            )
          : Center(
              child: Text('Không tìm thấy thông tin chuyến đi'),
            ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 6,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => layhangInfo()));
        },
        label: Text('LẤY HÀNG',
            style: TextStyle(fontSize: 12, color: Colors.black)),
        icon: SvgPicture.asset(
          "asset/icons/goods.svg",
          width: 16,
          height: 16,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
      ),
    );
  }

//String title1,String title2,Color color,
  RichText itemListHang(
      String title1, String title2, Color color, TextDecoration deco) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(text: title1, style: TextStyle(color: Colors.black)),
      TextSpan(
          text: title2,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
            decoration: deco,
          )),
    ]));
  }

  Row itemBottomSheet(Color color, String title, String value) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: 5),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
              color: color),
          child: Center(
              child: Text(
            '0',
            style: TextStyle(color: Colors.white),
          )),
        ),
        Text(
          title,
          style: TextStyle(color: Colors.black),
        ),
        Text(
          value,
          style: TextStyle(color: Colors.black),
        ),
      ],
    );
  }
}
