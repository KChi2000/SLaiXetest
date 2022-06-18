import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';

import '../other/homeConstant.dart';

class componentArea extends StatefulWidget {
  String name,phone;
  componentArea(this.name,this.phone);

  @override
  State<componentArea> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<componentArea> {
  String sdt;
  String ten;
  final nameController = TextEditingController();
   final phoneController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.phone==null || widget.phone.isEmpty){
        sdt = 'Nhập số điện thoại giúp kiểm soát dịch Covid-19';
    }
    else{
      sdt = widget.phone;
    }
    if(widget.name==null || widget.name.isEmpty){
      ten = "Chưa nhập";
    } else{
      ten = widget.name;
  }}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          padding: EdgeInsets.all(20),
                          height: 300,
                          child: Column(
                            // mainAxisAlignment:
                            // MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text('Hủy',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 15)),
                                ),
                              ),
                              Text('Thông tin hành khách',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                             Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                     Row(
                                      
                                       children: [
                                       SvgPicture.asset('asset/icons/card-account-phone-outline.svg',color: Colors.blue,),
                                      SizedBox(
                                        width: spaceBetween,
                                      ),
                                      Text(
                                        '$sdt',
                                        style: TextStyle(
                                            // fontWeight: fontStyleListItem,
                                            fontSize: 11
                                            ),
                                      ),
                                     ],),
                                     IconButton(onPressed: (){
                                       Navigator.pop(context);
                                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                padding: EdgeInsets.all(20),
                                height: 400,
                                child: Column(
                                  // mainAxisAlignment:
                                      // MainAxisAlignment.spaceAround,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text('Hủy',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 15)),
                                      ),
                                    ),
                                    Text('Thông tin hành khách',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18)),
                                    Form(
                                      // key: formkey1,
                                      child:  Column(children: [
                                      TextFormField(
                                        controller: phoneController,
                                        decoration: InputDecoration(
                                            // hintText: 'nhập số điện thoại',
                                            labelText: 'Số điện thoại',
                                           ),

                                        // controller: sdtNhanController,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9]')),
                                          FilteringTextInputFormatter.deny(
                                              RegExp(r'^[1-9]+')),
                                          LengthLimitingTextInputFormatter(10)
                                        ],
                                        validator: (sodt) {
                                          if (sodt == null || sodt.isEmpty) {
                                            return 'Điện thoại không được để trống';
                                          } else if (sodt.length <= 10) {
                                            return 'Sai định dạng số điện thoại';
                                          }
                                          return null;
                                        },
                                        onChanged: (vl1) {
                                          setState(() {
                                            sdt = vl1;
                                          });
                                        },
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                      ),
                                    
                                   
                                      TextFormField(
                                        controller: nameController,
                                        decoration: InputDecoration(
                                            // hintText: 'nhập số điện thoại',
                                            labelText: 'Họ tên: ',
                                           ),

                                        // controller: sdtNhanController,
                                        inputFormatters: [
                                          // FilteringTextInputFormatter.allow(
                                          //     RegExp(r'[0-9]')),
                                          FilteringTextInputFormatter.deny(
                                              RegExp(r'[0-9]+')),
                                          // LengthLimitingTextInputFormatter(10)
                                        ],
                                        validator: (ht) {
                                          if (ht == null || ht.isEmpty) {
                                            return 'Họ tên không được để trống';
                                          } 
                                          return null;
                                        },
                                        onChanged: (vl1) {
                                          setState(() {
                                            sdt = vl1;
                                          });
                                        },
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                      ),])
                                    ),
                                     SizedBox(
                                      height: 15,
                                    ),
                                     Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                        SvgPicture.asset('asset/icons/currency-usd.svg',
                                          width: 24, height: 24),
                                     
                                      SizedBox(
                                        width: spaceBetween,
                                      ),
                                      Text(
                                        'Thanh toán',
                                        style: TextStyle(
                                          // fontWeight: fontStyleListItem,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Đã thanh toán',
                                    style: TextStyle(
                                        // fontWeight: fontStyleListStatus,
                                        color: Colors.black),
                                  )
                                ],
                              ),
                               Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                     Icon(Icons.location_on,size: 24,),
                                      SizedBox(
                                        width: spaceBetween,
                                      ),
                                      Text(
                                        'Điểm xuống',
                                        style: TextStyle(
                                          // fontWeight: fontStyleListItem,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Yên Nghĩa',
                                    style: TextStyle(
                                        // fontWeight: fontStyleListStatus,
                                        color: Colors.black),
                                  )
                                ],
                              ),
                               SizedBox(
                                      height: 20,
                                    ),
                              FlatButton(onPressed: (){
                                // formTTHK.currentState.validate();
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> componentArea(nameController.text,phoneController.text)));
                              }, child: Text('XÁC NHẬN',style: TextStyle(color: Colors.white),),color: Colors.blue,)
                                   
                                  ],
                                ),
                              );
                            });
                                     }, icon:  Icon(Icons.edit,size: 20,color: Colors.blue,))
                                    ],
                                 
                              ),
                              Row(
                                children: [
                                 SvgPicture.asset('asset/icons/account-circle-outline.svg'),
                                  SizedBox(
                                    width: spaceBetween,
                                  ),
                                  Text(
                                    '$ten',
                                    style: TextStyle(
                                        // fontWeight: fontStyleListItem,
                                        fontSize: 11
                                        ),
                                  ),
                                 
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                          'asset/icons/currency-usd.svg',
                                          width: 24,
                                          height: 24),
                                      SizedBox(
                                        width: spaceBetween,
                                      ),
                                      Text(
                                        'Thanh toán',
                                        style: TextStyle(
                                            // fontWeight: fontStyleListItem,
                                            ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Đã thanh toán',
                                    style: TextStyle(
                                        // fontWeight: fontStyleListStatus,
                                        color: Colors.green),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: 24,
                                      ),
                                      SizedBox(
                                        width: spaceBetween,
                                      ),
                                      Text(
                                        'Điểm xuống',
                                        style: TextStyle(
                                            // fontWeight: fontStyleListItem,
                                            ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Yên Nghĩa',
                                    style: TextStyle(
                                        // fontWeight: fontStyleListStatus,
                                        color: Colors.black),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Divider(
                                height: 2,
                                thickness: 0.3,
                                color: Colors.black,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  FlatButton(
                                      onPressed: () {
                                        // formTTHK.currentState.validate();
                                      },
                                      child: Text(
                                        'IN VÉ',
                                        style: TextStyle(color: Colors.blue),
                                      )),
                                  FlatButton(
                                    onPressed: () {
                                      // formTTHK.currentState.validate();
                                    },
                                    child: Text(
                                      'XUỐNG XE',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: Colors.blue,
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      });
                },
                child: Text('editTTKH'))
          ],
        ),
      ),
    );
  }
}
