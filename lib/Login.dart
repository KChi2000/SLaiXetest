import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter_js/flutter_js.dart';
import 'package:flutter_js/javascript_runtime.dart';
import 'package:flutter_ui_kit/SignUp.dart';
import 'package:flutter_ui_kit/helpers/LoginHelper.dart';
import 'package:flutter_ui_kit/model/thongtincanhan.dart';
import 'package:flutter_ui_kit/uikit.dart';
import 'package:intl/intl.dart';
import 'helpers/ApiHelper.dart';
// import 'dart:js' as js; ???

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  State<Login> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Login> {
  bool showPass = true;
  String username = '';
  String password = '';
  JavascriptRuntime flutterJs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   
  }

  // final passController = TextEditingController(text: password);
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final formkey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.only(top: screenHeight * 0.1),
          height: screenHeight,
          width: screenWidth,
          child: SingleChildScrollView(
            child: Column(
              // fit: StackFit.passthrough,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 45,
                      width: 45,
                      child: Image.asset(
                        'asset/images/logo.png',
                        colorBlendMode: BlendMode.modulate,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Text(
                      'Sơn Phát C&T',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          foreground: Paint()
                            ..shader = LinearGradient(
                              colors: <Color>[Colors.red, Colors.blue],
                            ).createShader(Rect.fromLTWH(100, 0, 200, 0))),
                    ),
                  ],
                ),
                SizedBox(
                  height: 75,
                ),
                 Column(
                    children: [
                      SizedBox(
                        width: screenWidth * 0.8,
                        child: TextFormField(
                            initialValue: username,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                isDense: true,
                                labelText: 'Tài khoản',
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.blue),
                                )),
                            validator: (tk) {
                              if (tk == null || tk.isEmpty) {
                                return 'Chưa nhập tài khoản';
                              } else
                                return null;
                            },
                            onChanged: (vl) => username = vl),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      SizedBox(
                        width: screenWidth * 0.8,
                        child: TextFormField(
                          // controller: passController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscuringCharacter: '*',
                          obscureText: showPass,
                          initialValue: password,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  showPass
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    showPass = !showPass;
                                    print(showPass);
                                  });
                                  // showPass = !showPass;
                                },
                              ),
                              isDense: true,
                              labelText: 'Mật khẩu',
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.blue),
                              )),
                          validator: (mk) {
                            if (mk == null || mk.isEmpty) {
                              return 'Chưa nhập mật khẩu';
                            } else
                              return null;
                          },
                          onChanged: (vl) {
                            password = vl;
                          },
                        ),
                      ),
                    ],
                  ),
            
                SizedBox(
                  height: 65,
                ),
                FlatButton(
                  onPressed: () async {
                      
                      try {
                        await LoginHelper.Default.login(username, password);
                        String token = LoginHelper.Default.access_token;
          
                        print('Login done, token is: $token');
                      
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UIKitPage(0)));
                      } catch (ex) {
                       
                        print("Login error: $ex");
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text('Lỗi',style: TextStyle(color: Colors.red),),
                                  content: Text("${LoginHelper.Default.error}"),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Đã hiểu'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ));
                      }

                    },
                  
                  child: Text(
                    'ĐĂNG NHẬP',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Chưa có tài khoản?',
                        style: TextStyle(color: Colors.black)),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => SignUp()));
                        },
                        child:
                            Text('Đăng kí', style: TextStyle(color: Colors.red)))
                  ],
                )
              ],
            ),
          )),
    );
  }
}
