import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:image_picker/image_picker.dart';
import '../lenh/chuyendoilenh.dart';
import '../lenh/lenhvanchuyenList.dart';
import '../other/homeConstant.dart';

class Lenh extends StatefulWidget {
  @override
  LenhState createState() {
    return LenhState();
  }
}

class LenhState extends State<Lenh> {
  bool activefab = false;
  XFile imageitem;
  final formkey = GlobalKey<FormState>();
  final lidoController = TextEditingController();
  // final image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            appbarTitle,
            style: TextStyle(
              color: titleColor,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
              icon: SvgPicture.asset(
                'asset/icons/close.svg',
                color: appbarIconColor,
                width: appbarIconSize,
                height: appbarIconSize,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => lenhvanchuyenList()));
              }),
        ),
        body: Banner(
          message: 'Chờ bến đi kí',
          location: bannerLocation,
          color: bannerColor,
          child: Container(
            padding: EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'LVC-0000187/SPCT',
                  style: TextStyle(
                      color: Colors.blue, decoration: TextDecoration.underline),
                ),
                Image.asset(
                  'asset/images/qrimage.png',
                  width: 150,
                  height: 150,
                ),
                Text('20B-00111',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                Text('08:00 09/06/2022',
                    style: TextStyle(
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                        fontSize: 13)),
                SizedBox(
                  height: 10,
                ),
                itemRowLenh('Mã tuyến', '1920.1111.A', valueTextColor),
                SizedBox(
                  height: spacerItem,
                ),
                itemRowLenh('Tên bến đi', 'TT TP Thái Nguyên', valueTextColor),
                SizedBox(
                  height: spacerItem,
                ),
                itemRowLenh('Tên bến đến', 'Bến xe Thanh Sơn', valueTextColor),
                SizedBox(
                  height: spacerItem,
                ),
                itemRowLenh('Số khách đã mua vé', '0', numberPassengerBuyTicketColor),
                SizedBox(
                  height: spacerItem,
                ),
                itemRowLenh('Số khách trên xe', '0', numberPassengeronBusColor),
              ],
            ),
          ),
        ),
        floatingActionButton: SpeedDial(
          overlayColor: Colors.grey,
          backgroundColor: activeColor,
          activeBackgroundColor: inactiveColor,
          activeIcon: activeIcon,
          animationAngle: 3.14 / 2,
          buttonSize: activefab ? Size(activeButtonSize, activeButtonSize) : Size(inactiveButtonSize, inactiveButtonSize),
          icon: inactiveIcon,
          onOpen: () {
            setState(() {
              activefab = true;
            });
          },
          onClose: () {
            setState(() {
              activefab = false;
            });
          },
          children: [
            SpeedDialChild(
                backgroundColor: chuyendoilenhButtonColor,
                onTap: () {
                  print('chuyn doi lenh');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => chuyndoilenh()));
                },
                label: 'Chuyển đổi lệnh',
                child: Icon(
                  Icons.change_circle_sharp,
                  color: Colors.black,
                )),
            SpeedDialChild(
                // backgroundColor: Colors.red,
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          padding: EdgeInsets.all(15),
                          height: 350,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text('Hủy',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 15)),
                                ),
                              ),
                              Text('Dừng hành trình',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                              Row(children: [
                                Text('Mã số lệnh: ',
                                    style: TextStyle(fontSize: 13)),
                                Text('LCV-0000187/SPCT',
                                    style: TextStyle(fontSize: 16)),
                              ]),
                              Form(
                                key: formkey,
                                child: TextFormField(
                                  controller: lidoController,
                                  decoration: InputDecoration(
                                      labelText: 'Dừng vì lí do()*'),
                                      validator: (vl){
                                        if(vl==null || vl.isEmpty){
                                          return 'Chưa nhập lí do';
                                        } else return null;
                                      },
                                ),
                              ),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: 'Hình ảnh cho sự cố ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 15)),
                                    TextSpan(
                                        text: '0/6',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15)),
                                  ]))),
                              Row(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        child: Container(
                                          height: 60,
                                          width: 50,
                                          child: Image.asset(
                                            'asset/images/6.jpg',
                                            width: 60,
                                            height: 50,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 45,
                                        left: 35,
                                        child: IconButton(
                                          icon: SvgPicture.asset(
                                            'asset/icons/cancel.svg',
                                            width: 20,
                                            height: 20,
                                          ),
                                          onPressed: () {},
                                        ),
                                      )
                                    ],
                                  ),
                                  Stack(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        child: Container(
                                          height: 60,
                                          width: 50,
                                          child: Image.asset(
                                            'asset/images/6.jpg',
                                            width: 50,
                                            height: 45,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 45,
                                        left: 35,
                                        child: IconButton(
                                          icon: SvgPicture.asset(
                                            'asset/icons/cancel.svg',
                                            width: 20,
                                            height: 20,
                                          ),
                                          onPressed: () {},
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: DottedBorder(
                                      child: GestureDetector(
                                        child: Container(
                                          height: 55,
                                          width: 50,
                                          child: Center(
                                              child: SvgPicture.asset(
                                            'asset/icons/camera-plus.svg',
                                            color: Colors.black54,
                                          )),
                                        ),
                                        onTap: () {
                                          return showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  content: Container(
                                                    width: 60,
                                                    child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          GestureDetector(
                                                            child: Text(
                                                                'Chụp ảnh mới'),
                                                            onTap: () async {
                                                              print(
                                                                  'chọn chụp ảnh');
                                                              Navigator.pop(
                                                                  context);
                                                              await ImagePicker()
                                                                  .pickImage(
                                                                      source: ImageSource
                                                                          .camera);
                                                            },
                                                          ),
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          GestureDetector(
                                                            child: Text(
                                                                'Chọn ảnh'),
                                                            onTap: () async {
                                                              print('chọn ảnh');
                                                              Navigator.pop(
                                                                  context);
                                                              imageitem = await ImagePicker()
                                                                  .pickImage(
                                                                      source: ImageSource
                                                                          .gallery);
                                                              if (imageitem ==
                                                                  null) {
                                                                return;
                                                              }
                                                              // image.add(imageitem);
                                                              setState(() {
                                                                // count = image.length;
                                                              });
                                                            },
                                                          ),
                                                        ]),
                                                  ),
                                                );
                                              });
                                        },
                                      ),
                                      color: Colors.black54,
                                      strokeWidth: 1,
                                      radius: Radius.circular(10),
                                    ),
                                  ),
                                ],
                              ),
                              RaisedButton(
                                onPressed: () {
                                  formkey.currentState.validate();
                                },
                                child: Text('XÁC NHẬN',style: TextStyle(color: Colors.white,)),
                                color: Colors.blue,
                              )
                            ],
                          ),
                        );
                      });
                  print('dung hanh trinh');
                },
                label: 'Dừng hành trình',
                child: Icon(Icons.stop, color: Colors.black))
          ],
        ));
  }

  Row itemRowLenh(String title, String name, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('$title',
            style: TextStyle(
              color: Colors.black,
            )),
        Text('$name',
            style: TextStyle(color: color, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
