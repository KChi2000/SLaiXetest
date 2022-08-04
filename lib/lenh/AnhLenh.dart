import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_ui_kit/helpers/ApiHelper.dart';

import '../other/homeConstant.dart';

class AnhLenh extends StatefulWidget {
  String guidlenh;
   AnhLenh(this.guidlenh);

  @override
  State<AnhLenh> createState() => _AnhLenhState();
}
class _AnhLenhState extends State<AnhLenh> {
  var picLenhFuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.guidlenh);
    loadPic();
  
  }
  void loadPic(){
    try{
      picLenhFuture = ApiHelper.get(ApiHelper.API_LenhDienTu+'lay-link-xem-ban-the-hien-lenh?GuidLenh=${widget.guidlenh}');
    } catch(ex){
      // setState(() {
      //   picLenh['status'] = false;
      // });
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: picLenhFuture,
          builder: (context,snapshot){
          if(snapshot.hasError){
            return 
            Container(
          color: Colors.black,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: SvgPicture.asset(
                  'asset/icons/close.svg',
                  color: appbarIconColor,
                  width: appbarIconSize,
                  height: appbarIconSize,
                              ),),
                ),
               Container(
                height: 100,
                width: 100,
                child: Image.asset('asset/images/pagernotFound.png',fit: BoxFit.contain))
          ]),
        );
          }
          else if(snapshot.hasData){
            Map<String,dynamic> picLenh = snapshot.data;
            final imageUrl = picLenh['data'];
            return  Container(
          color: Colors.black,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: SvgPicture.asset(
                  'asset/icons/close.svg',
                  color: appbarIconColor,
                  width: appbarIconSize,
                  height: appbarIconSize,
                  
                              ),),
                ),
               Container(
                 width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.3,
                child: Image.network(imageUrl, fit: BoxFit.fill))
          ]),
        );
          }
          return Center(child: CircularProgressIndicator(),);
        })
       
      ),
    );
  }
}