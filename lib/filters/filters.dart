import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:animated_icon_button/animated_icon_button.dart';

import '../lenh/chuyendoilenh.dart';
class FiltersTabPage extends StatefulWidget {
  @override
  FiltersTabPageState createState() {
    return FiltersTabPageState();
  }
}

class FiltersTabPageState extends State<FiltersTabPage> {
  bool activefab= false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "LỆNH VẬN CHUYỂN",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
              icon: SvgPicture.asset(
                'asset/icons/close.svg',
                color: Colors.white,
                width: 30,
                height: 30,
              ),
              onPressed: () {}),
        ),
        body: Banner(
          message: 'Chờ bến đi kí',
          location: BannerLocation.topEnd,
          color: Colors.orange,
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
                itemRowLenh('Mã tuyến', '1920.1111.A', Colors.black),
                SizedBox(
                  height: 8,
                ),
                itemRowLenh('Tên bến đi', 'TT TP Thái Nguyên', Colors.black),
                SizedBox(
                  height: 8,
                ),
                itemRowLenh('Tên bến đến', 'Bến xe Thanh Sơn', Colors.black),
                SizedBox(
                  height: 8,
                ),
                itemRowLenh('Số khách đã mua vé', '0', Colors.green),
                SizedBox(
                  height: 8,
                ),
                itemRowLenh('Số khách trên xe', '0', Colors.blue),
              ],
            ),
          ),
        ),
        floatingActionButton: SpeedDial(
          overlayColor: Colors.grey,
          backgroundColor: Colors.blue,
          activeBackgroundColor: Colors.red,
          activeIcon: Icons.close,
          animationAngle: 3.14/2,
          buttonSize: activefab? Size(60,60): Size(50,50),
          icon: Icons.menu,
          onOpen: (){
            setState(() {
              activefab = true;
            });
          },
          onClose: (){
            setState(() {
              activefab=false;
            });
          },
          children: [
            SpeedDialChild(
              backgroundColor: Colors.green,
              onTap: (){
                  print('chuyn doi lenh');
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>chuyndoilenh()));
              },
              label: 'Chuyển đổi lệnh',
              child: Icon(Icons.change_circle_sharp,color: Colors.white,)
            ),
            SpeedDialChild(
              // backgroundColor: Colors.red,
               onTap: (){
                 showModalBottomSheet(context: context, builder: (context){
                   return Container(
                     height: 300,
                     child: Column(

                     ),
                   );
                 });
                print('dung hanh trinh');
              },
              label: 'Dừng hành trình',
              child: Icon(Icons.stop,color: Colors.black)
            )
          ],
        )
        );
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
