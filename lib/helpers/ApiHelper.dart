import 'dart:convert';

import 'package:flutter_ui_kit/helpers/LoginHelper.dart';
import 'package:flutter_ui_kit/model/thongtincanhan.dart';
import 'package:http/http.dart' as http;


// Theo quy ước, các backends hiện tại đều hỗ trợ định dạng dữ liệu json vả input và output.
class ApiHelper {

  // Sau khi đã đăng nhập và lấy được token thì khi truy vấn api ta đưa thêm header authorization như dưới đây để server hiểu và cho phép xác thực.
  static Future<thongtincanhan> get (String url) async {
    return await http
      .get(
        Uri.parse(url),
        headers: {
          "authorization": "Bearer ${LoginHelper.Default.access_token}",
        }
      )
      .then((resp) {
       if(resp.body.isNotEmpty){
          print('infoapi ${resp.body.toString()}');
        return thongtincanhan.fromJson(jsonDecode(resp.body));
       }
      });
      
  }

  static Future<Map<String, dynamic>> post (String url, dynamic data) async {
    return await http
      .post(
        Uri.parse(url),
        headers: {
          "authorization": "Bearer ${LoginHelper.Default.access_token}",
          "Content-Type": "application/json",
        },
        body: jsonEncode(data)
      )
      .then((resp) => jsonDecode(resp.body));
  }

  demo () async {
    ApiHelper.get("https://api-dnvt.sbus.vn/api/Driver/lay-thong-tin-ca-nhan");
    // ApiHelper.post("https://api.kingdark.org/me", {
    //   "key1": "value",
    //   "key2": "value",
    //   "key3": "value",
    // });
  }
}