import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../other/homeConstant.dart';

class Thongbao extends StatelessWidget {
  const Thongbao({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Thông Báo',style: TextStyle(color: titleColor),),),
      body: Container(color: Colors.white,
      child: Center(child: Text('Không có thông báo mới !')),),
    );
  }
}