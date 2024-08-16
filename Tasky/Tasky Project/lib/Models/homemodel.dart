class HomeModel {
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

  HomeModel(
      {this.sId,
      this.image,
      this.title,
      this.desc,
      this.priority,
      this.status,
      this.user,
      this.createdAt,
      this.updatedAt,
      this.iV});

  HomeModel.fromJson(Map<String, dynamic> json) {
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

  static List<HomeModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => HomeModel.fromJson(json)).toList();
  }
}
