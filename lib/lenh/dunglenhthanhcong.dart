import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_ui_kit/uikit.dart';

class dunglenhthanhcong extends StatelessWidget {
  String tendoanhnghiep;
   dunglenhthanhcong(this.tendoanhnghiep);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              ClipPath(
                clipper: CurvedBottomClipper(),
                child: Container(
                  color: Colors.blue[400],
                  height: 290.0,
                ),
              ),
              Positioned(
                width: size.width,
                height: size.height*0.85,
                  top: 80,
                  left: 0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: Colors.white,
                        size: 120,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'ĐÃ DỪNG HÀNH TRÌNH',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Roboto Medium',
                            fontSize: 20),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      Text('Thông báo sẽ được gửi đến đơn vị',
                          style: TextStyle(
                              color: Colors.black,
                             
                            fontFamily: 'Roboto Medium',
                              
                              fontSize: 14)),
                      Text('${tendoanhnghiep}',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Roboto Medium',
                              
                              fontSize: 14)),
                              Spacer(),
                              
                      FlatButton(
                          onPressed: () {
                             Navigator.of(context).popUntil((route) => route.isFirst);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UIKitPage(2)));
                          },
                          color: Colors.blue,
                          child: Container(
                              width: size.width * 0.7,
                              child: Center(
                                  child: Text('VỀ DANH SÁCH LỆNH',
                                      style: TextStyle(
                                        color: Colors.white,fontSize: 14,fontFamily: 'Roboto Medium',letterSpacing: 1.25,
                                      ))))),
                      FlatButton(
                          onPressed: () {
                             Navigator.of(context).popUntil((route) => route.isFirst);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UIKitPage(0)));
                          },
                          color: Colors.white,
                          minWidth: size.width * 0.8,
                          child: Container(
                            
                            padding: EdgeInsets.symmetric(horizontal: 40,vertical: 8),
                              width: size.width * 0.78,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blue)),
                              child: Center(
                                  child: Text('VỀ TRANG CHỦ',
                                      style: TextStyle(
                                        color: Colors.blue,fontSize: 14,fontFamily: 'Roboto Medium',letterSpacing: 1.25,
                                      ))))),
                                      SizedBox(height: 20,)
                    ],
                  ))
            ],
          )),
    );
  }
}

class CurvedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // I've taken approximate height of curved part of view
    // Change it if you have exact spec for it
    final roundingHeight = size.height * 1 / 7;
    final double pi = 3.1415;
    // this is top part of path, rectangle without any rounding
    final filledRectangle =
        Rect.fromLTRB(0, 0, size.width, size.height - roundingHeight);

    // this is rectangle that will be used to draw arc
    // arc is drawn from center of this rectangle, so it's height has to be twice roundingHeight
    // also I made it to go 5 units out of screen on left and right, so curve will have some incline there
    final roundingRectangle = Rect.fromLTRB(
        -5, size.height - roundingHeight * 2, size.width + 5, size.height);

    final path = Path();
    path.addRect(filledRectangle);

    // so as I wrote before: arc is drawn from center of roundingRectangle
    // 2nd and 3rd arguments are angles from center to arc start and end points
    // 4th argument is set to true to move path to rectangle center, so we don't have to move it manually
    path.arcTo(roundingRectangle, pi, -pi, true);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // returning fixed 'true' value here for simplicity, it's not the part of actual question, please read docs if you want to dig into it
    // basically that means that clipping will be redrawn on any changes
    return true;
  }
}
