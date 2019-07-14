class AssetModel {
  List<Data> data;
  String status;

  AssetModel({this.data, this.status});

  AssetModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Data {
  String assetName;
  int id;

  Data({this.assetName, this.id});

  Data.fromJson(Map<String, dynamic> json) {
    assetName = json['asset_name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['asset_name'] = this.assetName;
    data['id'] = this.id;
    return data;
  }
}