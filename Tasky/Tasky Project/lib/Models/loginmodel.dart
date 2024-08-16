class LoginModels {
  String? sId;
  String? accessToken;
  String? refreshToken;

  LoginModels({this.sId, this.accessToken, this.refreshToken});

  LoginModels.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
  }
}
