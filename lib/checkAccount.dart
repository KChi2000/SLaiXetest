import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_ui_kit/Login.dart';
import 'package:flutter_ui_kit/uikit.dart';
import 'package:lottie/lottie.dart';

import 'helpers/LoginHelper.dart';

class checkAccount extends StatefulWidget {
  const checkAccount({Key key}) : super(key: key);

  @override
  State<checkAccount> createState() => _checkAccountState();
}

var tokenFuture;

class _checkAccountState extends State<checkAccount> {
  final storage = new FlutterSecureStorage();
  var userModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogined();
  }

  void checkLogined() async {
    userModel = await storage.read(key: 'userModel');
    tokenFuture = storage.read(key: 'token');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: FutureBuilder<String>(
            future: tokenFuture,
            builder: (context, snashot) {
              if (snashot.data == null) {
                print('nulllllll');
                 WidgetsBinding.instance.addPostFrameCallback((_) {
                  //When finish, call actions inside
                  Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Login()));
                });
               
              }

              else if(snashot.hasError){
                 WidgetsBinding.instance.addPostFrameCallback((_) {
                  //When finish, call actions inside
                  Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Login()));
                });
              }
             if (snashot.hasData) {
                LoginHelper.Default.access_token = snashot.data;
                LoginHelper.Default.userToken = UserTokenModel.fromJson(userModel);
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  //When finish, call actions inside
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => UIKitPage(0)));
                });
                print(snashot.data);
              }
              return Center(
                child: Lottie.asset('asset/json/loading.json'),
              );
            }),
      ),
    );
  }
}
