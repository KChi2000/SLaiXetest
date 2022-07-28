import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_ui_kit/helpers/ApiHelper.dart';
import 'package:flutter_ui_kit/uikit.dart';
import 'package:image_picker/image_picker.dart';

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
 XFile imageitem;
  final image = [];
  int count;
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
            if(datachitiet.thoiGianGiaoHangThucTe == null || datachitiet.thoiGianGiaoHangThucTe.isEmpty){
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
                                                showModalBottomSheet(
                                                                context: context,
                                                                builder:
                                                                    (context) {
                                                                  return Container(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(
                                                                                15),
                                                                    height: 300,
                                                                    child: Column(
                                                                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                      children: [
                                                                        Align(
                                                                          alignment:
                                                                              Alignment.topLeft,
                                                                          child: GestureDetector(
                                                                              onTap: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: Text(
                                                                                'Thoát',
                                                                                style: TextStyle(fontSize: 15, color: Colors.red),
                                                                              )),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              15,
                                                                        ),
                                                                        Text(
                                                                          'Xác nhận trả hàng',
                                                                          style: TextStyle(
                                                                              fontWeight:
                                                                                  FontWeight.bold,
                                                                              fontSize: 18),
                                                                        ),
                                                                        Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text('Ảnh: 0/2'),
                                                                              Row(children: [
                                                                                Checkbox(value: false, onChanged: (a) {}),
                                                                                Text('In phiếu'),
                                                                              ]),
                                                                            ]),
                                                                        Align(
                                                                          alignment:
                                                                              Alignment.topLeft,
                                                                          child:
                                                                              DottedBorder(
                                                                            child:
                                                                                GestureDetector(
                                                                              child:
                                                                                  Container(
                                                                                height: 75,
                                                                                width: 65,
                                                                                child: Center(
                                                                                    child: SvgPicture.asset(
                                                                                  'asset/icons/camera-plus.svg',
                                                                                  color: Colors.black54,
                                                                                )),
                                                                              ),
                                                                              onTap:
                                                                                  () {
                                                                                return showDialog(
                                                                                    context: context,
                                                                                    builder: (context) {
                                                                                      return AlertDialog(
                                                                                        content: Container(
                                                                                          width: 60,
                                                                                          child: Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                                            GestureDetector(
                                                                                              child: Text('Chụp ảnh mới'),
                                                                                              onTap: () async {
                                                                                                print('chọn chụp ảnh');
                                                                                                Navigator.pop(context);
                                                                                                await ImagePicker().pickImage(source: ImageSource.camera);
                                                                                              },
                                                                                            ),
                                                                                            SizedBox(
                                                                                              height: 20,
                                                                                            ),
                                                                                            GestureDetector(
                                                                                              child: Text('Chọn ảnh'),
                                                                                              onTap: () async {
                                                                                                print('chọn ảnh');
                                                                                                Navigator.pop(context);
                                                                                                imageitem = await ImagePicker().pickImage(source: ImageSource.gallery);
                                                                                                if (imageitem == null) {
                                                                                                  return;
                                                                                                }
                                                                                                image.add(imageitem);
                                                                                                setState(() {
                                                                                                  count = image.length;
                                                                                                });
                                                                                              },
                                                                                            ),
                                                                                          ]),
                                                                                        ),
                                                                                      );
                                                                                    });
                                                                              },
                                                                            ),
                                                                            color:
                                                                                Colors.black54,
                                                                            strokeWidth:
                                                                                1,
                                                                            radius:
                                                                                Radius.circular(10),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        Divider(
                                                                          thickness:
                                                                              1.5,
                                                                          height:
                                                                              1,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        Align(
                                                                            alignment:
                                                                                Alignment.bottomRight,
                                                                            child: SizedBox(
                                                                                height: 28,
                                                                                child: ElevatedButton(
                                                                                    onPressed: () async {
                                                                                    
                                                                                      var res = await ApiHelper.postMultipart('http://113.176.29.57:19666/api/HangHoa/thuc-hien-giao-tra-hang-hoa', {
                                                                                        'idNhatKy': '${widget.idnhatki}',
                                                                                        'toaDo': ''
                                                                                      });
                                                                                      if (res == 'Uploadd') {
                                                                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> UIKitPage(3)));
                                                                                      } else {
                                                                                        showDialog(
                                                                                          context: context, barrierDismissible: false, // user must tap button!
                                                                                          builder: (BuildContext context) {
                                                                                            return AlertDialog(
                                                                                              title: const Text('Lỗi'),
                                                                                              content: 
                                                                                               Text('Lỗi kết nối'),
                                                                                              
                                                                                              actions: <Widget>[
                                                                                                TextButton(
                                                                                                  child: const Text('Đã hiểu'),
                                                                                                  onPressed: () {
                                                                                                    Navigator.of(context).pop();
                                                                                                  },
                                                                                                ),
                                                                                              ],
                                                                                            );
                                                                                          },
                                                                                        );
                                                                                      }
                                                                                    },
                                                                                    child: Text('XÁC NHẬN'))))
                                                                      ],
                                                                    ),
                                                                  );
                                                                });
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
