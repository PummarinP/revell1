class ScannerData {
  int id;
  String data;
  String scanType;
  String name;
  String createdDate;

  ScannerData(
      this.id,
      this.scanType,
      this.data,
      this.name,
      this.createdDate
      );

  ScannerData.map(dynamic obj) {
    this.id = obj['id'];
    this.scanType = obj['scanType'];
    this.data = obj['data'];
    this.name = obj['name'];
    this.createdDate = obj['createdDate'];
  }


  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["id"] = id;
    map["scanType"] = scanType;
    map["data"] = data;
    map["name"] = name;
    map["createdDate"] = createdDate;
    return map;
  }
}