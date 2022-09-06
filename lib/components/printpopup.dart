import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_ui_kit/model/printModel.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class printpopup {
  static void showpopup(context, List<printModel> list) {
    Size size = MediaQuery.of(context).size;
    bool fade = false;
    showMaterialModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Color.fromRGBO(34, 34, 34, 1),
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Container(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(34, 34, 34, 1),
                  borderRadius: BorderRadius.circular(10)),
              padding:
                  EdgeInsets.only(top: 20, right: 10, left: 10, bottom: 10),
              height: size.height * 0.95,
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Chọn máy in',
                    style: TextStyle(
                        fontFamily: 'Roboto Medium',
                        fontSize: 24,
                        color: Colors.white),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              setState(
                                () {
                                  Navigator.pop(context);
                                  showToast(
                                      '${list[index].printname} is working...........',
                                      textStyle: TextStyle(
                                          fontFamily: 'Roboto Medium',
                                          fontSize: 14,
                                          color: Colors.white),
                                      context: context,
                                      animation: StyledToastAnimation.scale,
                                      reverseAnimation:
                                          StyledToastAnimation.fade,
                                      position: StyledToastPosition.top,
                                      animDuration: Duration(seconds: 1),
                                      duration: Duration(seconds: 4),
                                      curve: Curves.elasticOut,
                                      reverseCurve: Curves.linear,
                                      backgroundColor: Color.fromARGB(255, 83, 170, 242),
                                      textPadding: EdgeInsets.all(15),
                                      fullWidth: true);
                                },
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 20, right: 10, left: 10, bottom: 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Icon(
                                      //   Icons.print,
                                      //   size: 30,
                                      //   color: Colors.white,
                                      // ),
                                      Text('🖨',style: TextStyle(
                                              
                                              fontSize: 25,
                                              )),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(list[index].printname,
                                          style: TextStyle(
                                              fontFamily: 'Roboto Regular',
                                              fontSize: 20,
                                              color: Colors.blue))
                                    ],
                                  ),
                                  Text(list[index].statusprint,
                                      style: TextStyle(
                                          fontFamily: 'Roboto Regular',
                                          fontSize: 12,
                                          color: Colors.white.withOpacity(0.7)))
                                ],
                              ),
                            ),
                          );
                        
                      }),
                  Text(
                      'Vui lòng đảm bảo máy in nhiệt đã được bật và ở trạng thái chờ',
                      style: TextStyle(
                          fontFamily: 'Roboto Regular',
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.7)))
                ],
              ),
            );
          });
        });
  }
}

List<printModel> listprint = [
  printModel('MPT-II', 'đã dùng gần đây'),
  printModel('Printer001', ''),
  printModel('Printer001', ''),
];
