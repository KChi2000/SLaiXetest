import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class chooseImage extends StatelessWidget {
  double width;
  double height;
  XFile imageitem;
  List<XFile> image;
  Function(void Function()) setState;
  chooseImage(
      this.width, this.height, this.imageitem, this.image, this.setState);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Align(
        alignment: Alignment.topLeft,
        child: DottedBorder(
          child: Container(
            height: height,
            width: width,
            child: Center(
                child: SvgPicture.asset(
              'asset/icons/camera-plus.svg',
              color: Colors.black54,
            )),
          ),
          color: Colors.black54,
          strokeWidth: 1,
          radius: Radius.circular(10),
        ),
      ),
      onTap: () {
        return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Container(
                  width: 60,
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          child: Text('Chụp ảnh mới',
                              style: TextStyle(
                                  fontSize: 14, fontFamily: 'Roboto Regular')),
                          onTap: () async {
                            print('chọn chụp ảnh');
                            Navigator.pop(context);
                            imageitem = await ImagePicker()
                                .pickImage(source: ImageSource.camera);
                            if (imageitem == null) {
                              return;
                            }

                            setState(() {
                              image.add(imageitem);
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          child: Text('Chọn ảnh',
                              style: TextStyle(
                                  fontSize: 14, fontFamily: 'Roboto Regular')),
                          onTap: () async {
                            print('chọn ảnh');
                            Navigator.pop(context);
                            imageitem = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            if (imageitem == null) {
                              return;
                            }
                            // image.add(imageitem);
                            setState(() {
                              image.add(imageitem);
                              // count = image.length;
                            });
                            // print('count: $count');
                          },
                        ),
                      ]),
                ),
              );
            });
      },
    );
  }
}