class AllDataModel {
  Data data;
  String status;

  AllDataModel({this.data, this.status});

  AllDataModel.fromJson(Map<String, dynamic> json) {
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
  List<Assets> assets;
  List<Tasks> tasks;
  List<Workers> workers;

  Data({this.assets, this.tasks, this.workers});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['assets'] != null) {
      assets = new List<Assets>();
      json['assets'].forEach((v) {
        assets.add(new Assets.fromJson(v));
      });
    }
    if (json['tasks'] != null) {
      tasks = new List<Tasks>();
      json['tasks'].forEach((v) {
        tasks.add(new Tasks.fromJson(v));
      });
    }
    if (json['workers'] != null) {
      workers = new List<Workers>();
      json['workers'].forEach((v) {
        workers.add(new Workers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.assets != null) {
      data['assets'] = this.assets.map((v) => v.toJson()).toList();
    }
    if (this.tasks != null) {
      data['tasks'] = this.tasks.map((v) => v.toJson()).toList();
    }
    if (this.workers != null) {
      data['workers'] = this.workers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Assets {
  int id;
  String name;

  Assets({this.id, this.name});

  Assets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Tasks {
  int id;
  String name;

  Tasks({this.id, this.name});

  Tasks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Workers {
  int id;
  String name;

  Workers({this.id, this.name});

  Workers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
