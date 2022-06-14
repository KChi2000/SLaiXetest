import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter_ui_kit/SignUp.dart';
import 'package:flutter_ui_kit/uikit.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  State<Login> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final formkey= GlobalKey<FormState>();
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
          child: Stack(
            // fit: StackFit.passthrough,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    child: Image.asset(
                      'asset/images/logo.png',
                      color: Colors.white.withOpacity(0.3),
                      colorBlendMode: BlendMode.modulate,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ],
              ),
              Positioned(
                  child: Container(
                width: screenWidth,
                height: screenHeight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                    SizedBox(
                      height: 75,
                    ),
                    Form(
                      key: formkey,
                      child: Column(children: [
                      SizedBox(
                      width: screenWidth * 0.8,
                      child: TextFormField(
                        decoration: InputDecoration(
                            isDense: true,
                            labelText: 'Tài khoản',
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.blue),
                            )),
                             
                             validator: (tk){
                              if(tk == null || tk.isEmpty){
                                return 'Chưa nhập tài khoản';
                              } else return null;
                            },  
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      width: screenWidth * 0.8,
                      child: TextFormField(
                        decoration: InputDecoration(
                            isDense: true,
                            labelText: 'Mật khẩu',
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.blue),
                            )),
                             validator: (mk){
                              if(mk == null || mk.isEmpty){
                                return 'Chưa nhập mật khẩu';
                              } else return null;
                            },  
                      ),
                    ),
                    ],),),
                    SizedBox(
                      height: 25,
                    ),
                    FlatButton(
                      onPressed: () {
                        if(formkey.currentState.validate()){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> UIKitPage(0)));
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Chưa có tài khoản?',
                            style: TextStyle(color: Colors.black)),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUp()));
                            },
                            child: Text('Đăng kí',
                                style: TextStyle(color: Colors.red)))
                      ],
                    )
                  ],
                ),
              ))
            ],
          )),
    );
  }
}
