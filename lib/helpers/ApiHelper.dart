import 'dart:convert';

import 'package:flutter_ui_kit/helpers/LoginHelper.dart';
import 'package:flutter_ui_kit/model/Huyen.dart';
import 'package:flutter_ui_kit/model/LenhHienTai.dart';
import 'package:flutter_ui_kit/model/Tinh.dart';
import 'package:flutter_ui_kit/model/lenhModel.dart';
import 'package:flutter_ui_kit/model/tang.dart';
import 'package:flutter_ui_kit/model/thongtincanhan.dart';
import 'package:http/http.dart' as http;

import '../model/DSDiemXuong.dart';
import '../model/DSDiemxuongLotrinh.dart';
import '../model/DSHHTheoChuyenDi.dart';
import '../model/DSHanhKhachGhePhu.dart';
import '../model/DSHanhKhachMuaVe.dart';
import '../model/DSTrangThai.dart';
import '../model/DSTuyenVanChuyenTheoNgay.dart';
import '../model/DonGiaTheoTuyen.dart';
import '../model/KhachTrenXe.dart';
import '../model/LayChiTietNhatKyVanChuyen.dart';
import '../model/LenhHienTai.dart';
import '../model/LichSuChuyenDi.dart';
import '../model/SLVe.dart';
import '../model/ThongTinHanhKhachGhe.dart';
import '../model/ThongTinThem.dart';
import '../model/TrangThaiChoNgoi.dart';
import '../model/chuyendiganday.dart';
import '../model/sodocho.dart';

final backend_url = 'https://api-ve.nguyencongtuyen.sonphat.dev/';

// Theo quy ước, các backends hiện tại đều hỗ trợ định dạng dữ liệu json vả input và output.
class ApiHelper {
  
  static final API_KiemSoatVeTaiBen = backend_url + 'be_api/kiemsoatvetaiben/';
  static final API_Print = backend_url;
  static final API_TuyenDuong = backend_url + 'be_api/tuyenduong/';
  static final API_ThanhToan = backend_url + 'be_api/thanhtoan/';
  static final API_PhongChongDich = backend_url + 'be_api/phongchongdich/';
  static final API_DoiSoat = backend_url + 'be_api/chuyendi/doi-soat/';
  static final API_ThongTin = backend_url + 'api/';
  static final API_PhienBan = backend_url + 'PhienBan/api/';
  static final API_HangHoa = 'https://api-hanghoa.nguyencongtuyen.sonphat.dev/api/';
  static final API_LenhDienTu = 'https://api-lenhdientu.nguyencongtuyen.sonphat.dev/api/Driver/';
  static final API_File = 'https://file-ve.nguyencongtuyen.sonphat.dev/api/';
  static final API_DoanhNghiepVanTai = backend_url + 'be_api/doanhnghiepvantai/';
  static final API_CauHinhHeThong = backend_url + 'be_api/cauhinhhethong/';
  static final API_BaoCao = backend_url + 'be_api/baocao/';
  static final API_Ve = backend_url + 'be_api/ve/';
  static final API_Xe = backend_url + 'be_api/xe/';
  static final API_TaiKhoan = backend_url + 'api/taikhoan/';
  static final API_ChuyenDi = backend_url + 'be_api/chuyendi/ChuyenDi/';
  static final API_DiemXuongCuaKhachHang = backend_url;
  static final API_Default_BaseUrl = backend_url + 'be_api/chuyendi/';
  static final API_DonHang = backend_url + 'be_api/donhang/';
  static final API_BaseUrl = backend_url + 'be_api/chuyendi/';
  static final API_BenXe = backend_url + 'be_api/benxe/';
  // Sau khi đã đăng nhập và lấy được token thì khi truy vấn api ta đưa thêm header authorization như dưới đây để server hiểu và cho phép xác thực.
  static Future<Map<String, dynamic>> get(String url) async {
    return await http.get(Uri.parse(url), headers: {
      "authorization": "Bearer ${LoginHelper.Default.access_token}",
    }).then((resp) {
      if (resp.body.isNotEmpty) print('infoapi ${resp.body.toString()}');
      return json.decode(resp.body);
    });
  }

//tinh
  static Future<Tinh> getProvince(String url) async {
    return await http.get(Uri.parse(url), headers: {
      "authorization": "Bearer ${LoginHelper.Default.access_token}",
    }).then((resp) {
      if (resp.body.isNotEmpty) print('infoapi ${resp.body.toString()}');
      return Tinh.fromJson(jsonDecode(resp.body));
    });
  }

  //huyen
  static Future<Huyen> getDistrict(String url) async {
    return await http.get(Uri.parse(url), headers: {
      "authorization": "Bearer ${LoginHelper.Default.access_token}",
    }).then((resp) {
      if (resp.body.isNotEmpty) print('infoapi ${resp.body.toString()}');
      return Huyen.fromJson(jsonDecode(resp.body));
    });
  }

  //chi tiet lenh
  static Future<ChiTietLenh> getChiTietLenh(String url) async {
    return await http.get(Uri.parse(url), headers: {
      "authorization": "Bearer ${LoginHelper.Default.access_token}",
    }).then((resp) {
      if (resp.body.isNotEmpty) print('infoapi ${resp.body.toString()}');
      return ChiTietLenh.fromJson(json.decode(resp.body));
    });
  }

  // khach tren xe
  static Future<KhachTrenXe> getKhachTrenXe(String url) async {
    return await http.get(Uri.parse(url), headers: {
      "authorization": "Bearer ${LoginHelper.Default.access_token}",
    }).then((resp) {
      if (resp.body.isNotEmpty) print('infoapi ${resp.body.toString()}');
      return KhachTrenXe.fromJson(jsonDecode(resp.body));
    });
  }

  //lenh hien tai
  static Future<LenhHienTai> getLenhHienTai(String url) async {
    return await http.get(Uri.parse(url), headers: {
      "authorization": "Bearer ${LoginHelper.Default.access_token}",
    }).then((resp) {
      if (resp.body.isNotEmpty) print('infoapi ${resp.body.toString()}');
      return LenhHienTai.fromJson(jsonDecode(resp.body));
    });
  }

  // tim kiem chuyen di gan day
  static Future<chuyendiganday> getchuyendiganday() async {
    return await http.get(
        Uri.parse(
            API_DoiSoat+'tim-kiem-chuyen-di-gan-day'),
        headers: {
          "authorization": "Bearer ${LoginHelper.Default.access_token}",
        }).then((resp) {
      if (resp.body.isNotEmpty) {
        print('infoapi ${resp.body.toString()}');
        return chuyendiganday.fromJson(jsonDecode(resp.body));
      } else
        return chuyendiganday.fromJson(jsonDecode(resp.body));
    });
  }

  // danh sach hang hoa theo chuyen di
  static Future<DSHHTheoChuyenDi> getDSHHTheoChuyenDi(String url) async {
    return await http.get(Uri.parse(url), headers: {
      "authorization": "Bearer ${LoginHelper.Default.access_token}",
    }).then((resp) {
      if (resp.body.isNotEmpty) print('infoapi ${resp.body.toString()}');
      return DSHHTheoChuyenDi.fromJson(jsonDecode(resp.body));
    });
  }

  // thong tin them chuyen di
  static Future<ThongTinThem> getThongTinThem(String guidChuyendi) async {
    return await http.get(
        Uri.parse(
           API_ChuyenDi+ 'lay-thong-tin-them-cua-chuyen-di?GuidChuyenDi=${guidChuyendi}'),
        headers: {
          "authorization": "Bearer ${LoginHelper.Default.access_token}",
        }).then((resp) {
      if (resp.body.isNotEmpty) print('infoapi ${resp.body.toString()}');
      return ThongTinThem.fromJson(jsonDecode(resp.body));
    });
  }

  //ds trang thai
  static Future<DSTrangThai> getDSTrangThai(String url) async {
    return await http.get(Uri.parse(url), headers: {
      "authorization": "Bearer ${LoginHelper.Default.access_token}",
    }).then((resp) {
      if (resp.body.isNotEmpty) print('infoapi ${resp.body.toString()}');
      return DSTrangThai.fromJson(jsonDecode(resp.body));
    });
  }

  //lich su chuyen di cua lai xe
  static Future<LichSuChuyenDi> getLichSuChuyenDi(String url) async {
    return await http.get(Uri.parse(url), headers: {
      "authorization": "Bearer ${LoginHelper.Default.access_token}",
    }).then((resp) {
      if (resp.body.isNotEmpty) print('infoapi ${resp.body.toString()}');
      return LichSuChuyenDi.fromJson(jsonDecode(resp.body));
    });
  }

  //get tang xe
  static Future<tang> gettang(String idChuyenDi) async {
    return await http.get(
        Uri.parse(
            API_BaseUrl+'dat-ve/danh-sach-tang-xe?IdChuyenDi=${idChuyenDi}'),
        headers: {
          "authorization": "Bearer ${LoginHelper.Default.access_token}",
        }).then((resp) {
      if (resp.body.isNotEmpty) print('infoapi ${resp.body.toString()}');
      return tang.fromJson(jsonDecode(resp.body));
    });
  }

  //get so do xe
  static Future<sodocho> getsodocho(String idchuyendi, String idtang) async {
    return await http.get(
        Uri.parse(
            API_ThongTin+'dat-ve/ma-tran-cho-ngoi?IdChuyenDi=${idchuyendi}&IdTang=${idtang}'),
        headers: {
          "authorization": "Bearer ${LoginHelper.Default.access_token}",
        }).then((resp) {
      if (resp.body.isNotEmpty) print('infoapi ${resp.body.toString()}');
      return sodocho.fromJson(jsonDecode(resp.body));
    });
  }

  // get trang thai cho ngoi
  static Future<TrangThaiChoNgoi> getTrangThaiChoNgoi(
      String guidchuyendi) async {
    return await http.get(
        Uri.parse(
            API_DoiSoat+'lay-trang-thai-cho-ngoi-soat-ve?GuidChuyenDi=${guidchuyendi}'),
        headers: {
          "authorization": "Bearer ${LoginHelper.Default.access_token}",
        }).then((resp) {
      if (resp.body.isNotEmpty)
        print('infoapi trang thai ${resp.body.toString()}');
      return TrangThaiChoNgoi.fromJson(jsonDecode(resp.body));
    });
  }

  // get danh sach diem xuong
  static Future<DSDiemXuong> getDSDiemXuong(String guidlotrinh) async {
    return await http.get(
        Uri.parse(
            API_ThongTin+'DiemDung/lay-danh-sach-diem-xuong-cua-lo-trinh?guidLoTrinh=${guidlotrinh}'),
        headers: {
          "authorization": "Bearer ${LoginHelper.Default.access_token}",
        }).then((resp) {
      if (resp.body.isNotEmpty)
        print('infoapi ds diem xuong    ${resp.body.toString()}');
      return DSDiemXuong.fromJson(jsonDecode(resp.body));
    });
  }

  // get danh sach tuyen van chuyen theo ngay
  static Future<DSTuyenVanChuyenTheoNgay> getDSTuyenVanChuyenTheoNgay(
      String ngay) async {
    return await http.get(
        Uri.parse(
            API_LenhDienTu+'lay-danh-sach-tuyen-van-chuyen-theo-ngay?Ngay=${ngay}'),
        headers: {
          "authorization": "Bearer ${LoginHelper.Default.access_token}",
        }).then((resp) {
      if (resp.body.isNotEmpty)
        print('infoapi dstuyen theo ngay   ${resp.body.toString()}');
      return DSTuyenVanChuyenTheoNgay.fromJson(jsonDecode(resp.body));
    });
  }

  // get chi tiet nhat ky van chuyen
  static Future<LayChiTietNhatKyVanChuyen> getLayChiTietNhatKyVanChuyen(
      String idnhatky) async {
    return await http.get(
        Uri.parse(
           API_HangHoa+ 'HangHoa/lay-chi-tiet-nhat-ky-van-chuyen?idNhatKy=${idnhatky}'),
        headers: {
          "authorization": "Bearer ${LoginHelper.Default.access_token}",
        }).then((resp) {
      if (resp.body.isNotEmpty)
        print('infoapi didnhatky   ${resp.body.toString()}');
      return LayChiTietNhatKyVanChuyen.fromJson(jsonDecode(resp.body));
    });
  }

  // get ds hanh khach tren xe
  static Future<DSHanhKhachMuaVe> getDSHanhKhachMuaVe(
      String idlenhdientu) async {
    return await http.get(
        Uri.parse(
           API_ThongTin+ 'QuanLyThongTin/lay-danh-sach-hanh-khach-mua-ve-tren-xe?idLenhDienTu=${idlenhdientu}'),
        headers: {
          "authorization": "Bearer ${LoginHelper.Default.access_token}",
        }).then((resp) {
      if (resp.body.isNotEmpty)
        print('infoapi hanh khach   ${resp.body.toString()}');
      return DSHanhKhachMuaVe.fromJson(jsonDecode(resp.body));
    });
  }

  //get thong tin hanh khach ngoi tren ghe
  static Future<ThongTinHanhKhachGhe> getThongTinHanhKhachGhe(
      String machuyendi, String guidchongoi) async {
    return await http.get(
        Uri.parse(
            API_DoiSoat+'lay-thong-tin-hanh-khach-qua-cho-ngoi?MaChuyenDi=${machuyendi}&GuidChoNgoi=${guidchongoi}'),
        headers: {
          "authorization": "Bearer ${LoginHelper.Default.access_token}",
        }).then((resp) {
      if (resp.body.isNotEmpty)
        print('infoapi hanh khach  ghe  ${resp.body.toString()}');
      return ThongTinHanhKhachGhe.fromJson(jsonDecode(resp.body));
    });
  }

  //get thong tin hanh khach ngoi tren ghe phu
  static Future<DSHanhKhachGhePhu> getDSHanhKhachGhePhu(
      String guidchuyendi) async {
    return await http.get(
        Uri.parse(
            API_DonHang+'lay-danh-sach-hanh-khach-mua-ve-ghe-phu?guidChuyenDi=${guidchuyendi}'),
        headers: {
          "authorization": "Bearer ${LoginHelper.Default.access_token}",
        }).then((resp) {
      if (resp.body.isNotEmpty)
        print('infoapi hanh khach  ghe phu ${resp.body.toString()}');
      return DSHanhKhachGhePhu.fromJson(jsonDecode(resp.body));
    });
  }

  //get ds diem xuong cua lo trinh
  static Future<DSDiemXuongLoTrinh> getDSDiemXuongLoTrinh(
      String guidlotrinh) async {
    return await http.get(
        Uri.parse(
            API_TuyenDuong+'DiemDung/lay-danh-sach-diem-xuong-cua-lo-trinh?guidLoTrinh=${guidlotrinh}'),
        headers: {
          "authorization": "Bearer ${LoginHelper.Default.access_token}",
        }).then((resp) {
      if (resp.body.isNotEmpty)
        print('infoapi diem xuong lo trinh ${resp.body.toString()}');
      return DSDiemXuongLoTrinh.fromJson(jsonDecode(resp.body));
    });
  }

  //get so luong ve ban dc
  static Future<SLVe> getSLVe(String guidchuyendi) async {
    return await http.get(
        Uri.parse(
            API_DonHang+'lay-so-luong-ve-ban-theo-loai-diem-ban?GuidChuyenDi=${guidchuyendi}'),
        headers: {
          "authorization": "Bearer ${LoginHelper.Default.access_token}",
        }).then((resp) {
      if (resp.body.isNotEmpty) print('infoapi ve ${resp.body.toString()}');
      return SLVe.fromJson(jsonDecode(resp.body));
    });
  }

  //get don gia theo tuyen
  static Future<DonGiaTheoTuyen> getDonGiaTheoTuyen(String idlotrinh) async {
    return await http.get(
        Uri.parse(
            API_ThongTin+'QuanLyThongTin/lay-don-gia-theo-tuyen?idLoTrinh=${idlotrinh}'),
        headers: {
          "authorization": "Bearer ${LoginHelper.Default.access_token}",
        }).then((resp) {
      if (resp.body.isNotEmpty) print('infoapi ve ${resp.body.toString()}');
      return DonGiaTheoTuyen.fromJson(jsonDecode(resp.body));
    });
  }

  static Future<DSLenh> postDsLenh(String url, dynamic data) async {
    return await http
        .post(Uri.parse(url),
            headers: {
              "authorization": "Bearer ${LoginHelper.Default.access_token}",
              "Content-Type": "application/json",
            },
            body: jsonEncode(data))
        .then((resp) => DSLenh.fromJson(jsonDecode(resp.body)));
  }

  static Future<Map<String, dynamic>> post(String url, dynamic data) async {
    return await http
        .post(Uri.parse(url),
            headers: {
              "authorization": "Bearer ${LoginHelper.Default.access_token}",
              "Content-Type": "application/json",
            },
            body: jsonEncode(data))
        .then((resp) => jsonDecode(resp.body));
  }

  static Future<String> postMultipart(
      String url, Map<String, String> data) async {
    var request = http.MultipartRequest('POST', Uri.parse(url))
      ..fields.addAll(data);
    request.headers.addAll(
      {
        "authorization": "Bearer ${LoginHelper.Default.access_token}",
        "Content-Type": "application/json",
      },
    );
    var resp = await request.send();
    if (resp.statusCode == 200) {
      print('Uploadd');
      print(resp);
      return 'Uploadd';
    }
    return resp.statusCode.toString();
  }

  static Future<thongtincanhan> getTinh() async {
    await ApiHelper.get(
           API_LenhDienTu+ "lay-danh-sach-tinh")
        .then((data) => Tinh.fromJson(data));
    //
    // ApiHelper.post("https://api.kingdark.org/me", {
    //   "key1": "value",
    //   "key2": "value",
    //   "key3": "value",
    // });
  }
}


//  .post(Uri.parse(url),
//             headers: {
//               "authorization": "Bearer ${LoginHelper.Default.access_token}",
//               "Content-Type": "application/json",
//             },
//             body: jsonEncode(data))
//         .then((resp) => jsonDecode(resp.body));