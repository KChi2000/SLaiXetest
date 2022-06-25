import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'Login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  DateTime date = DateTime.now();
  final dateController = TextEditingController(
      text: DateFormat('dd-MM-yyyy').format(DateTime.now()));
      final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        child: Stack(children: [
          
          Positioned(
              child: Container(
            width: screenWidth,
            height: screenHeight,
            child: Column(
              children: [
                Text(
                  'THÔNG TIN ĐĂNG KÍ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  height: 75,
                ),
                Form(
                  key: formkey,
                    child: Column(
                  children: [
                    SizedBox(
                      // height: screenHeight * 0.06,
                      width: screenWidth * 0.8,
                      child: TextFormField(
                        decoration: InputDecoration(
                          isDense: true,
                            labelText: 'Họ tên(*)',
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.blue),
                            ),),
                            validator: (name){
                              if(name == null || name.isEmpty){
                                return 'Chưa nhập tên';
                              } else return null;
                            },
                            
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      // height: screenHeight * 0.06,
                      width: screenWidth * 0.8,
                      child: TextFormField(
                        decoration: InputDecoration(
                          isDense: true,
                            labelText: 'Số điện thoại(*)',
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.blue),
                            )),
                             inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    FilteringTextInputFormatter.deny(RegExp(r'^[1-9]+')),
                    LengthLimitingTextInputFormatter(10)
                  ],
                            validator: (sdt){
                              if(sdt == null || sdt.isEmpty){
                                return 'Chưa nhập số điện thoại';
                              } else if(sdt.length <10){
                                return 'Sai định dạng số điện thoại';
                              }
                              else return null;
                            },
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      // height: screenHeight * 0.06,
                      width: screenWidth * 0.8,
                      child: TextFormField(
                        controller: dateController,
                        decoration: InputDecoration(
                          isDense: true,
                            labelText: 'Ngày sinh(*)',
                            suffixIcon: Icon(Icons.calendar_month),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.blue),
                            )),
                        onTap: () async {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(3000));
                          if (date == null) {
                            setState(() {
                              date = DateTime.now();
                            });
                          }
                          setState(() {
                            dateController.text =
                                '${date.day}-${date.month}-${date.year}';
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      // height: screenHeight * 0.06,
                      width: screenWidth * 0.8,
                      child: TextFormField(
                        decoration: InputDecoration(
                          isDense: true,
                          labelText: 'Số GPLX(*)',
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.blue),
                          ),
                        ),
                        validator: (gplx){
                              if(gplx == null || gplx.isEmpty){
                                return 'Chưa nhập số GPLX';
                              } else return null;
                            },
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      // height: screenHeight * 0.06,
                      width: screenWidth * 0.8,
                      child: TextFormField(
                        decoration: InputDecoration(
                          isDense: true,
                            labelText: 'Hạng bằng(*)',
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.blue),
                            )),
                           validator: (bang){
                              if(bang == null || bang.isEmpty){
                                return 'Chưa nhập hạng bằng';
                              } else return null;
                            },  
                      ),
                    ),
                  ],
                )),
                SizedBox(
                  height: 25,
                ),
                FlatButton(
                  onPressed: () {
                    formkey.currentState.validate();
                  },
                  child: Text(
                    'ĐĂNG KÍ',
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
                    Text('Đã có tài khoản?',
                        style: TextStyle(color: Colors.black)),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Text('Đăng nhập',
                            style: TextStyle(color: Colors.red)))
                  ],
                )
              ],
            ),
          ))
        ]),
      ),
    );
  }
}
