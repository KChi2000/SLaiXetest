import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_ui_kit/Login.dart';
import 'package:flutter_ui_kit/uikit.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/LoginHelper.dart';

class checkAccount extends StatefulWidget {
  const checkAccount({Key key}) : super(key: key);

  @override
  State<checkAccount> createState() => _checkAccountState();
}

class _checkAccountState extends State<checkAccount> {
  final storage = new FlutterSecureStorage();
  var userModel;
  var token;

  var waitingFlag;

  @override
  void initState() {
    waitingFlag = checkLogined();
    // TODO: implement initState
    super.initState();
  }

  Future checkLogined() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('first_run') ?? true) {
      await storage.deleteAll();

      prefs.setBool('first_run', false);
    }
    token = await storage.read(key: 'token');
    print('token check: $token');
    if (token == null) {
      userModel = null;
    } else {
      userModel = await storage.read(key: 'userModel');
      print(userModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: FutureBuilder(
            future: waitingFlag,
            builder: (context, snashot) {
              if (snashot.connectionState == ConnectionState.waiting) {
                print('loading');
                return Center(
                  child: Lottie.asset('asset/json/loading.json'),
                );
              } else {
                print(token);
                print(userModel);
                if (token == 'delete' ||
                    token == null ||
                    token == "" ||
                    userModel == null ||
                    userModel == "") {
                  return Login();
                } else {
                  LoginHelper.Default.access_token = token;
                  LoginHelper.Default.userToken =
                      UserTokenModel.fromJson(jsonDecode(userModel));
                  // WidgetsBinding.instance.addPostFrameCallback((_) {
                  //   //When finish, call actions inside
                  //   Navigator.pushReplacement(context,
                  //       MaterialPageRoute(builder: (context) => UIKitPage(0)));
                  // });
                  return UIKitPage(0);
                }
              }
            }),
      ),
    );
  }
}
