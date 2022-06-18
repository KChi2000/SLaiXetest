class sodocho {
  String id;
  String idTang;
  KieuCho kieuCho;
  LoaiCho loaiCho;
  int viTriHang;
  int viTriCot;
  String tenCho;
  int giaTien;
  TrangThai trangThai;
  String soDienThoaiKhachHang;
  bool kichHoatGhePhu;

  sodocho(
      {this.id,
      this.idTang,
      this.kieuCho,
      this.loaiCho,
      this.viTriHang,
      this.viTriCot,
      this.tenCho,
      this.giaTien,
      this.trangThai,
      this.soDienThoaiKhachHang,
      this.kichHoatGhePhu});

  sodocho.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idTang = json['idTang'];
    kieuCho =
        json['kieuCho'] != null ? new KieuCho.fromJson(json['kieuCho']) : null;
    loaiCho =
        json['loaiCho'] != null ? new LoaiCho.fromJson(json['loaiCho']) : null;
    viTriHang = json['viTriHang'];
    viTriCot = json['viTriCot'];
    tenCho = json['tenCho'];
    giaTien = json['giaTien'];
    trangThai = json['trangThai'] != null
        ? new TrangThai.fromJson(json['trangThai'])
        : null;
    soDienThoaiKhachHang = json['soDienThoaiKhachHang'];
    kichHoatGhePhu = json['kichHoatGhePhu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idTang'] = this.idTang;
    if (this.kieuCho != null) {
      data['kieuCho'] = this.kieuCho.toJson();
    }
    if (this.loaiCho != null) {
      data['loaiCho'] = this.loaiCho.toJson();
    }
    data['viTriHang'] = this.viTriHang;
    data['viTriCot'] = this.viTriCot;
    data['tenCho'] = this.tenCho;
    data['giaTien'] = this.giaTien;
    if (this.trangThai != null) {
      data['trangThai'] = this.trangThai.toJson();
    }
    data['soDienThoaiKhachHang'] = this.soDienThoaiKhachHang;
    data['kichHoatGhePhu'] = this.kichHoatGhePhu;
    return data;
  }
}

class KieuCho {
  int id;
  String kyHieu;
  String tenKieuCho;

  KieuCho({this.id, this.kyHieu, this.tenKieuCho});

  KieuCho.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kyHieu = json['kyHieu'];
    tenKieuCho = json['tenKieuCho'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kyHieu'] = this.kyHieu;
    data['tenKieuCho'] = this.tenKieuCho;
    return data;
  }
}

class LoaiCho {
  int id;
  String tenLoaiCho;
  String maMau;

  LoaiCho({this.id, this.tenLoaiCho, this.maMau});

  LoaiCho.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tenLoaiCho = json['tenLoaiCho'];
    maMau = json['maMau'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tenLoaiCho'] = this.tenLoaiCho;
    data['maMau'] = this.maMau;
    return data;
  }
}

class TrangThai {
  int idTrangThai;
  String tenTrangThai;
  String maMau;

  TrangThai({this.idTrangThai, this.tenTrangThai, this.maMau});

  TrangThai.fromJson(Map<String, dynamic> json) {
    idTrangThai = json['idTrangThai'];
    tenTrangThai = json['tenTrangThai'];
    maMau = json['maMau'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idTrangThai'] = this.idTrangThai;
    data['tenTrangThai'] = this.tenTrangThai;
    data['maMau'] = this.maMau;
    return data;
  }
}