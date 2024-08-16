import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Models/refreshmodel.dart';
import '../Services/api.dart';

class RefreshHelper {
  static Future refreshToken() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString("Token") ?? "";
    final refreshToken = sharedPreferences.getString("RefreshToken") ?? "";
    var link = Uri.parse('$api/auth/refresh-token?token=$refreshToken');
    var headers = {
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(
      link,
      headers: headers,
    );
    //////////////////// Success Refresh Token ////////////////
    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> jsonMap = jsonDecode(response.body);
      RefreshModel refreshToken = RefreshModel.fromJson(jsonMap);
      sharedPreferences.setString("Token", refreshToken.accessToken!);
    }
  }
}
