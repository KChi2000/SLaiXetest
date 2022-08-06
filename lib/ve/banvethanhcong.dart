import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_ui_kit/uikit.dart';
import 'package:flutter_ui_kit/ve/Ve.dart';
import 'package:flutter_ui_kit/ve/banveghephu.dart';
import 'package:intl/intl.dart';
class banvethanhcong extends StatelessWidget {
  String tongtien,sdt,hinhthucthanhtoan;
  banvethanhcong(this.tongtien,this.sdt,this.hinhthucthanhtoan);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'asset/images/success.jpg',
              width: 350,
              height: 300,
            ),
            Icon(Icons.check_circle,color: Colors.green,size: 35,),
            SizedBox(
                    height: 15,
                  ),
            Text(
              'Bán vé thành công !',
              style: TextStyle(fontFamily: 'Roboto Medium',fontSize: 16),
            ),
            Container(
              width: 250,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  iteminfoBVTC('Tổng tiền:',tongtien != null? '${NumberFormat('#,###')
                                                .format(int.parse(tongtien))+'đ'}':'0đ'),
                  SizedBox(
                    height: 8,
                  ),
                  iteminfoBVTC('Số điện thoại:',sdt !=null? '$sdt':'null'),
                  SizedBox(
                    height: 8,
                  ),
                  iteminfoBVTC(
                      'Hình thức thanh\ntoán',hinhthucthanhtoan != null? '$hinhthucthanhtoan':'null' ),
                ],
              ),
            ),
            Spacer(),
            Column(
              // mainAxisSize: MainAxisSize.min,
              // crossAxisAlignment: CrossAxisAlignment.end,
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Divider(
                  height: 2,
                  thickness: 0.3,
                  color: Colors.black,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).popUntil((route) => route.isFirst);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> UIKitPage(0)));
                        },
                        child: Text(
                          'TRANG CHỦ',
                          style: TextStyle(color: Colors.blue,fontFamily: 'Roboto Medium',fontSize: 14,letterSpacing: 1.25),
                        )),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).popUntil((route) => route.isFirst);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UIKitPage(1)));
                      },
                      child: Text(
                        'TIẾP TỤC',
                        style: TextStyle(color: Colors.white,fontFamily: 'Roboto Medium',fontSize: 14,letterSpacing: 1.25),
                      ),
                      color: Colors.blue,
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row iteminfoBVTC(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$title',
          style: TextStyle(fontFamily: 'Roboto Regular',fontSize: 14),
        ),
        Text(
          '$value',
          style: TextStyle(fontFamily: 'Roboto Regular',fontSize: 14),
        ),
      ],
    );
  }
}
