// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Helpers/applocalization.dart';
import 'package:http/http.dart' as http;
import '../Models/taskmodel.dart';
import '../Services/api.dart';
import '../constant/theme.dart';

class TaskHelper {
  static Future<File?> selectImage(BuildContext context) async {
    return await showModalBottomSheet<File?>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: Text(
                "Camera".tr(context),
                style: GoogleFonts.dmSans(
                    fontSize: 14,
                    color: ThemeColor.textPrimaryColor,
                    fontWeight: FontWeight.w400),
              ),
              onTap: () async {
                final XFile? pickedFile =
                    await ImagePicker().pickImage(source: ImageSource.camera);
                if (pickedFile != null) {
                  Navigator.pop(context, File(pickedFile.path));
                } else {
                  Navigator.pop(context);
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text(
                "gallery".tr(context),
                style: GoogleFonts.dmSans(
                    fontSize: 14,
                    color: ThemeColor.textPrimaryColor,
                    fontWeight: FontWeight.w400),
              ),
              onTap: () async {
                final XFile? pickedFile =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  Navigator.pop(context, File(pickedFile.path));
                } else {
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  static Future<TextEditingController?> changeDate(BuildContext context) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (date != null) {
      String formattedDate = "${date.year}/${date.month}/${date.day}";
      return TextEditingController(text: formattedDate);
    }
    return null;
  }

  static Future<TaskModel> getData(String iD) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString("Token") ?? "";
    final link = Uri.parse("$api/todos/$iD");

    final response = await http.get(
      link,
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseData = jsonDecode(response.body);
      return TaskModel.fromJson(responseData);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
