import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class banvethanhcong extends StatelessWidget {
  const banvethanhcong({Key key}) : super(key: key);

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
              style: TextStyle(fontFamily: 'Roboto Medium'),
            ),
            Container(
              width: 250,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  iteminfoBVTC('Tổng tiền:', '50,000đ'),
                  SizedBox(
                    height: 8,
                  ),
                  iteminfoBVTC('Số điện thoại:', '06456543445'),
                  SizedBox(
                    height: 8,
                  ),
                  iteminfoBVTC(
                      'Hình thức thanh\ntoán', 'Tiền mặt/Cash\nchange'),
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
                          // formTTHK.currentState.validate();
                        },
                        child: Text(
                          'TRANG CHỦ',
                          style: TextStyle(color: Colors.blue),
                        )),
                    FlatButton(
                      onPressed: () {
                        // formTTHK.currentState.validate();
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
          style: TextStyle(),
        ),
        Text(
          '$value',
          style: TextStyle(),
        ),
      ],
    );
  }
}
