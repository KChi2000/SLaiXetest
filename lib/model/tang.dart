class tang {
  String idTang;
  String tenTang;
  int soHang;
  int soCot;

  tang({this.idTang, this.tenTang, this.soHang, this.soCot});

  tang.fromJson(Map<String, dynamic> json) {
    idTang = json['idTang'];
    tenTang = json['tenTang'];
    soHang = json['soHang'];
    soCot = json['soCot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idTang'] = this.idTang;
    data['tenTang'] = this.tenTang;
    data['soHang'] = this.soHang;
    data['soCot'] = this.soCot;
    return data;
  }
}