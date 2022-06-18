import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class thanhtoanbanve extends StatelessWidget {
  const thanhtoanbanve({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('THANH TOÁN BÁN VÉ'),),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             SizedBox(height: 15,),
             Text('Hướng dẫn hành khách quét camera vào mã QR',style:TextStyle(fontWeight: FontWeight.bold)),
             SizedBox(height: 20,),
             Container(
               padding: EdgeInsets.all(20),
               height: 250,
               width: 250,
               decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.all(Radius.circular(10)),
               boxShadow: [
               BoxShadow(offset: Offset(0,2),blurRadius: 4,spreadRadius: 6,color: Colors.black.withOpacity(0.15))
             ]),
             child: Image.asset('asset/images/qrimage.png'),
             ),
             SizedBox(height: 20,),
             Row(
               mainAxisSize: MainAxisSize.min,
               children: [
               Text('Thời gian thanh toán: ',style:TextStyle(color: Colors.blue)),
               Text('10:00',style:TextStyle(color: Colors.blue)),
             ],),
              SizedBox(height: 5,),
             Row(
               mainAxisSize: MainAxisSize.min,
               children: [
               Text('Số tiền thanh toán: ',style:TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
               Text('50,000đ',style:TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
             ],),
              SizedBox(height: 10,),
             Container(
               padding: EdgeInsets.all(20),
               width: MediaQuery.of(context).size.width*0.85,
              //  height: 100,
               decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
               child: Column(children: [
                  Text('Thông tin người nhận',style:TextStyle(fontWeight: FontWeight.bold)),
                   SizedBox(height: 10,),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
               Text('Người nhận: ',style:TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
               Text('CTCP SON PHAT',style:TextStyle(color: Colors.black)),
             ],),
              SizedBox(height: 5,),
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
               Text('Số tài khoản nhận: ',style:TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
               Text('043853753272',style:TextStyle(color: Colors.black)),
             ],),
              SizedBox(height: 5,),
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
               Text('Số điện thoại: ',style:TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
               Text('0432374236',style:TextStyle(color: Colors.black)),
             ],),
              SizedBox(height: 5,),
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
               Text('Ngân hàng: ',style:TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
               Text('Ngân hàng công thương',style:TextStyle(color: Colors.black)),
             ],),
               ]),
             )
          ],
        ),
      ),
    );
  }
}