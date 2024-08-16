import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Models/profilemodel.dart';
import '../Services/api.dart';

class ProfileHelper {
  static Future<ProfileModel> getData() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString("Token") ?? "";
    final link = Uri.parse("$api/auth/profile");

    final response = await http.get(
      link,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      return ProfileModel.fromJson(responseData);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
