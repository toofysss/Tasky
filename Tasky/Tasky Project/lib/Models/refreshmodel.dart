class RefreshModel {
  String? accessToken;

  RefreshModel({this.accessToken});

  RefreshModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
  }
}
