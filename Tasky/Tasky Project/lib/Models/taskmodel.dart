class TaskModel {
  String? sId;
  String? image;
  String? title;
  String? desc;
  String? priority;
  String? status;
  String? user;
  String? createdAt;
  String? updatedAt;
  int? iV;

  TaskModel(
      {String? sId,
      String? image,
      String? title,
      String? desc,
      String? priority,
      String? status,
      String? user,
      String? createdAt,
      String? updatedAt,
      int? iV}) {
    if (sId != null) {
      sId = sId;
    }
    if (image != null) {
      image = image;
    }
    if (title != null) {
      title = title;
    }
    if (desc != null) {
      desc = desc;
    }
    if (priority != null) {
      priority = priority;
    }
    if (status != null) {
      status = status;
    }
    if (user != null) {
      user = user;
    }
    if (createdAt != null) {
      createdAt = createdAt;
    }
    if (updatedAt != null) {
      updatedAt = updatedAt;
    }
    if (iV != null) {
      iV = iV;
    }
  }

  TaskModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    image = json['image'];
    title = json['title'];
    desc = json['desc'];
    priority = json['priority'];
    status = json['status'];
    user = json['user'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}
