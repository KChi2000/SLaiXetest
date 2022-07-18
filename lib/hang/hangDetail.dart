import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_ui_kit/helpers/ApiHelper.dart';

import '../model/LayChiTietNhatKyVanChuyen.dart';
import 'package:intl/intl.dart';

class hangDetail extends StatefulWidget {
  int num;
  String idnhatki;
  hangDetail(this.num, this.idnhatki);

  @override
  State<hangDetail> createState() => _hangDetailState();
}

class _hangDetailState extends State<hangDetail> {
  var chitietnhatkyFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('ahihi '+widget.idnhatki);
   if(widget.idnhatki != null || !(widget.idnhatki.isEmpty)){
     loadchitietNhatky(widget.idnhatki);
   }
  }

  void loadchitietNhatky(String idNhatKi) {
    chitietnhatkyFuture = ApiHelper.getLayChiTietNhatKyVanChuyen(idNhatKi);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('XEM CHI TIẾT'),
      ),
      body: FutureBuilder<LayChiTietNhatKyVanChuyen>(
        future: chitietnhatkyFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Lỗi'),
            );
          } else if (snapshot.hasData) {
            LayChiTietNhatKyVanChuyen chitietnhatky = snapshot.data;
            DataNhatKyChiTiet datachitiet = chitietnhatky.data;
            var datetime;
            if(datetime == null || datetime.toString().isEmpty){
              print('nulllllll');
              datetime = DateTime.parse(datachitiet.thoiGianGiaoHangDuKien).toLocal();
            } else{
              datetime =
                DateTime.parse(datachitiet.thoiGianGiaoHangThucTe).toLocal();
            }
            String datetimegiaohang =
                DateFormat('kk:mm dd/MM/yyyy ').format(datetime);
            return Banner(
              message: '${datachitiet.trangThaiThanhToan}',
              location: BannerLocation.topEnd,
              color: datachitiet.thoiGianGiaoHangThucTe != null
                  ? Colors.green
                  : Colors.pink[800],
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
                              text: '${datachitiet.trangThaiVanChuyen}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      datachitiet.thoiGianGiaoHangThucTe != null
                                          ? Colors.green
                                          :Colors.red )),
                          TextSpan(
                        text: datachitiet.thoiGianGiaoHangThucTe != null?'($datetimegiaohang)' :'(Dự kiến: $datetimegiaohang)',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 12,
                            color: datachitiet.thoiGianGiaoHangThucTe != null
                                          ? Colors.green
                                          :Colors.red)),
                        
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
                          'Cước: ${datachitiet.tongTien}đ'),
                      SizedBox(
                        height: 10,
                      ),
                      rowItemDetail(
                          SvgPicture.asset(
                            'asset/icons/barcode.svg',
                            height: 20,
                            width: 20,
                          ),
                          'Mã tra cứu: ${datachitiet.maTraCuu}'),
                      SizedBox(
                        height: 10,
                      ),
                      rowItemDetail(
                          SvgPicture.asset(
                            'asset/icons/link.svg',
                            height: 20,
                            width: 20,
                          ),
                          'Link tra cứu: ${datachitiet.linkTraCuu}'),
                      SizedBox(
                        height: 10,
                      ),
                      rowItemDetail(
                          SvgPicture.asset(
                            'asset/icons/location.svg',
                            height: 20,
                            width: 20,
                          ),
                          'Trả tại: ${datachitiet.tenDiemNhanHang}'),
                      SizedBox(
                        height: 10,
                      ),
                      rowItemDetail(
                          SvgPicture.asset(
                            'asset/icons/emailreceive.svg',
                            height: 20,
                            width: 20,
                          ),
                          'SĐT người nhận: ${datachitiet.soDienThoaiNhan}'),
                      SizedBox(
                        height: 10,
                      ),
                      rowItemDetail(
                          SvgPicture.asset(
                            'asset/icons/emailsend.svg',
                            height: 20,
                            width: 20,
                          ),
                          'SĐT người gửi: ${datachitiet.soDienThoaiGui != null ? datachitiet.soDienThoaiGui :'' }'),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      FlatButton(
                                        onPressed: () {
                                          // html.window.open('https://www.google.com/search?q=kimi+lin&oq=kimi+lin&aqs=chrome..69i57j46i512j0i22i30l8.3083j0j7&sourceid=chrome&ie=UTF-8', 'abc');
                                        },
                                        child: Text('IN PHIẾU',
                                            style:
                                                TextStyle(color: Colors.blue)),
                                        height: 20,
                                        // color: Colors.black,
                                      ),
                                      //  VerticalDivider(
                                      //     width: 2,
                                      //     thickness: 2,
                                      //   ),
                                      GestureDetector(
                                        onTap: datachitiet.trangThaiVanChuyen ==
                                                'Đã giao'
                                            ? null
                                            : () {
                                                print('pickkkk');
                                              },
                                        child: Container(
                                          height: 50,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          decoration: BoxDecoration(
                                              color: datachitiet
                                                          .trangThaiVanChuyen ==
                                                      'Đã giao'
                                                  ? Colors.grey[400]
                                                  : Colors.blue),
                                          child:
                                              Center(child: Text('TRẢ HÀNG')),
                                        ),
                                      )
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
            );
          }
          return Center(
            child: Text('Không có dữ liệu'),
          );
        },
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
