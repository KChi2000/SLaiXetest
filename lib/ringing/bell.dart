import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Bell extends StatelessWidget {
  const Bell({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Thông Báo'),),
      body: Container(color: Colors.white,
      child: Center(child: Text('Không có thông báo mới !')),),
    );
  }
}