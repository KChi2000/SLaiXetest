import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter_ui_kit/checkAccount.dart';

import 'package:flutter_ui_kit/lenh/lenh.dart';

import 'package:flutter_ui_kit/lenh/lenhvanchuyenList.dart';
import 'package:flutter_ui_kit/model/lenhModel.dart';

import '../helpers/ApiHelper.dart';


class lenhMain extends StatefulWidget {
  const lenhMain({Key key}) : super(key: key);

  @override
  State<lenhMain> createState() => _lenhMainState();
}

class _lenhMainState extends State<lenhMain> {
  var chitietlenhFuture;
  ChiTietLenh chitietlenh;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadchitietlenh();
  }
  void loadchitietlenh(){
    chitietlenhFuture =  ApiHelper.getChiTietLenh();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: chitietlenhFuture,
      builder: (context,snapshot){
      if(snapshot.connectionState == ConnectionState.waiting){
        return Scaffold(body: Center(child: CircularProgressIndicator()),);
      }
      else if(snapshot.hasData) {
        chitietlenh = snapshot.data;
        if(chitietlenh.message == 'Không tìm thấy dữ liệu'){
          return lenhvanchuyenList();
        }
        else {
        return Lenh(chitietlenh);
        }
      }
      return null;
    });
  }
}