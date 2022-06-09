import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';

class hangDetail extends StatefulWidget {
  int num;
  hangDetail(this.num);

  @override
  State<hangDetail> createState() => _hangDetailState();
}

class _hangDetailState extends State<hangDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('XEM CHI TIẾT'),
      ),
      body: Banner(
        message: 'Chưa thu',
        location: BannerLocation.topEnd,
        color: Colors.pink[800],
        child: Container(
            padding: EdgeInsets.only(left: 20),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 15,
                ),
                Image.asset(
                  'asset/images/qrimage.png',
                  width: 150,
                  height: 150,
                ),
                Center(
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: 'Chưa giao ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red)),
                    TextSpan(
                        text: '(Dự kiến: 10:23 06/06/2022)',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 12,
                            color: Colors.red)),
                  ])),
                ),
                SizedBox(
                  height: 10,
                ),
                rowItemDetail(
                    SvgPicture.asset(
                      'asset/icons/cuoc.svg',
                      height: 20,
                      width: 20,
                    ),
                    'Cước: 100,000đ'),
                SizedBox(
                  height: 10,
                ),
                rowItemDetail(
                    SvgPicture.asset(
                      'asset/icons/barcode.svg',
                      height: 20,
                      width: 20,
                    ),
                    'Mã tra cứu: 2345445654334556YOT'),
                SizedBox(
                  height: 10,
                ),
                rowItemDetail(
                    SvgPicture.asset(
                      'asset/icons/link.svg',
                      height: 20,
                      width: 20,
                    ),
                    'Link tra cứu: http://tracuuhanghoabenxeaaaaaaaaaaaa.vn'),
                SizedBox(
                  height: 10,
                ),
                rowItemDetail(
                    SvgPicture.asset(
                      'asset/icons/location.svg',
                      height: 20,
                      width: 20,
                    ),
                    'Trả tại: Bến xe Việt Trì'),
                SizedBox(
                  height: 10,
                ),
                rowItemDetail(
                    SvgPicture.asset(
                      'asset/icons/emailreceive.svg',
                      height: 20,
                      width: 20,
                    ),
                    'SĐT người nhận: 0987 345 324'),
                SizedBox(
                  height: 10,
                ),
                rowItemDetail(
                    SvgPicture.asset(
                      'asset/icons/emailsend.svg',
                      height: 20,
                      width: 20,
                    ),
                    'SĐT người gửi: 0987 345 324'),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       mainAxisSize: MainAxisSize.min,
                      children: [
                        Divider(
                          thickness: 2,
                          height: 2,
                        ),
                        IntrinsicHeight(
                          child: Row(
                            // mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FlatButton(
                                  onPressed: () {
                                   // html.window.open('https://www.google.com/search?q=kimi+lin&oq=kimi+lin&aqs=chrome..69i57j46i512j0i22i30l8.3083j0j7&sourceid=chrome&ie=UTF-8', 'abc');
                                   },
                                  child: Text('IN PHIẾU',
                                      style: TextStyle(color: Colors.blue)),
                                  height: 20,
                                  // color: Colors.black,
                                ),
                                //  VerticalDivider(
                                //     width: 2,
                                //     thickness: 2,
                                //   ),
                                Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width*0.5,
                                  decoration: BoxDecoration(color: Colors.blue),
                                  child: Center(child: Text('TRẢ HÀNG')),
                                )
                              ]),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }

//
//
  Row rowItemDetail(SvgPicture image, String title) {
    return Row(children: [
      image,
      SizedBox(
        width: 5,
      ),
      Expanded(
        child: Text('$title', overflow: TextOverflow.ellipsis, maxLines: 1),
      )
    ]);
  }
}
