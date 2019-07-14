class LearningPathModel {
  Data data;
  String status;

  LearningPathModel({this.data, this.status});

  LearningPathModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Data {
  List<Path> path;
  Data({this.path});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['path'] != null) {
      path = new List<Path>();
      json['path'].forEach((v) {
        path.add(new Path.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.path != null) {
      data['path'] = this.path.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Path {
  String autofillOption;
  String creator;
  String creatorOrg;
  int pathId;
  String pathName;
  int pathProgress;
  String status;
  int topicCount;

  Path(
      {this.autofillOption,
        this.creator,
        this.creatorOrg,
        this.pathId,
        this.pathName,
        this.pathProgress,
        this.status,
        this.topicCount});

  Path.fromJson(Map<String, dynamic> json) {
    autofillOption = json['autofill_option'];
    creator = json['creator'];
    creatorOrg = json['creator_org'];
    pathId = json['path_id'];
    pathName = json['path_name'];
    pathProgress = json['path_progress'];
    status = json['status'];
    topicCount = json['topic_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['autofill_option'] = this.autofillOption;
    data['creator'] = this.creator;
    data['creator_org'] = this.creatorOrg;
    data['path_id'] = this.pathId;
    data['path_name'] = this.pathName;
    data['path_progress'] = this.pathProgress;
    data['status'] = this.status;
    data['topic_count'] = this.topicCount;
    return data;
  }
}