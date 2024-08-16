import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Models/homemodel.dart';
import '../Services/api.dart';

class HomeHelper {
  static Future<List<HomeModel>> getData(int page) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString("Token") ?? "";
    final link = Uri.parse("$api/todos?page=$page");

    final response = await http.get(
      link,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      return HomeModel.fromJsonList(responseData);
    } else {
      throw Exception('Failed to load data');
    }
  }

  static List<HomeModel> filterTasks(List<HomeModel> tasks, int tabIndex) {
    switch (tabIndex) {
      case 1:
        return tasks.where((task) => task.status == 'Inprogress').toList();
      case 2:
        return tasks.where((task) => task.status == 'waiting').toList();
      case 3:
        return tasks.where((task) => task.status == 'Finished').toList();
      default:
        return tasks;
    }
  }
}
