class thongtincanhan {
  Data data;

  thongtincanhan({this.data});

  thongtincanhan.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  Null hoTen;
  Null ngaySinh;
  Null soDienThoai;
  Null email;
  Null idTinh;
  Null idHuyen;
  Null diaChi;
  Null diaChiThuongTru;
  int namBatDauHanhNghe;
  int soNamKinhNghiem;
  Null soGPLX;
  Null hangBang;
  Null ngayBatDauHieuLuc;
  Null thoiHanHieuLuc;
  Null coQuanCap;
  Null ngayCap;

  Data(
      {this.hoTen,
      this.ngaySinh,
      this.soDienThoai,
      this.email,
      this.idTinh,
      this.idHuyen,
      this.diaChi,
      this.diaChiThuongTru,
      this.namBatDauHanhNghe,
      this.soNamKinhNghiem,
      this.soGPLX,
      this.hangBang,
      this.ngayBatDauHieuLuc,
      this.thoiHanHieuLuc,
      this.coQuanCap,
      this.ngayCap});

  Data.fromJson(Map<String, dynamic> json) {
    hoTen = json['hoTen'];
    ngaySinh = json['ngaySinh'];
    soDienThoai = json['soDienThoai'];
    email = json['email'];
    idTinh = json['idTinh'];
    idHuyen = json['idHuyen'];
    diaChi = json['diaChi'];
    diaChiThuongTru = json['diaChiThuongTru'];
    namBatDauHanhNghe = json['namBatDauHanhNghe'];
    soNamKinhNghiem = json['soNamKinhNghiem'];
    soGPLX = json['soGPLX'];
    hangBang = json['hangBang'];
    ngayBatDauHieuLuc = json['ngayBatDauHieuLuc'];
    thoiHanHieuLuc = json['thoiHanHieuLuc'];
    coQuanCap = json['coQuanCap'];
    ngayCap = json['ngayCap'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hoTen'] = this.hoTen;
    data['ngaySinh'] = this.ngaySinh;
    data['soDienThoai'] = this.soDienThoai;
    data['email'] = this.email;
    data['idTinh'] = this.idTinh;
    data['idHuyen'] = this.idHuyen;
    data['diaChi'] = this.diaChi;
    data['diaChiThuongTru'] = this.diaChiThuongTru;
    data['namBatDauHanhNghe'] = this.namBatDauHanhNghe;
    data['soNamKinhNghiem'] = this.soNamKinhNghiem;
    data['soGPLX'] = this.soGPLX;
    data['hangBang'] = this.hangBang;
    data['ngayBatDauHieuLuc'] = this.ngayBatDauHieuLuc;
    data['thoiHanHieuLuc'] = this.thoiHanHieuLuc;
    data['coQuanCap'] = this.coQuanCap;
    data['ngayCap'] = this.ngayCap;
    return data;
  }
}
