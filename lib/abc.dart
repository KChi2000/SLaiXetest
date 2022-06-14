// Positioned(
//                 left: 20,
//                 top: 100,
//                 child: Expanded(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Align(
//                           alignment: Alignment.topCenter,
//                           child: Text(
//                             'Sơn Phát C&T',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 30,
//                                 foreground: Paint()
//                                   ..shader = LinearGradient(
//                                     colors: <Color>[
//                                       Colors.red,
                                      
//                                       Colors.blue
//                                     ],
//                                   ).createShader(
//                                       Rect.fromLTWH(100, 0, 200, 0))),
//                           )),
//                       SizedBox(
//                         height: 25,
//                       ),
//                       Container(
//                         height: screenHeight * 0.06,
//                         width: screenWidth * 0.8,
//                         child: TextFormField(
//                           decoration: InputDecoration(
//                               labelText: 'Tài khoản',
//                               border: OutlineInputBorder(
//                                 borderSide:
//                                     BorderSide(width: 1, color: Colors.blue),
//                               )),
//                         ),
//                       ),
//                       Container(
//                         height: 15,
//                       ),
//                       SizedBox(
//                         height: screenHeight * 0.06,
//                         width: screenWidth * 0.8,
//                         child: TextFormField(
//                           decoration: InputDecoration(
//                               labelText: 'Mật khẩu',
//                               border: OutlineInputBorder(
//                                 borderSide:
//                                     BorderSide(width: 1, color: Colors.blue),
//                               )),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 15,
//                       ),
//                       FlatButton(
//                         onPressed: () {},
//                         child: Text(
//                           'ĐĂNG NHẬP',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         color: Colors.blue,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(8))),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text('Chưa có tài khoản?',
//                               style: TextStyle(color: Colors.black)),
//                           GestureDetector(
//                               onTap: () {
//                                 Navigator.pushReplacement(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => SignUp()));
//                               },
//                               child: Text('Đăng kí',
//                                   style: TextStyle(color: Colors.blue)))
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ),