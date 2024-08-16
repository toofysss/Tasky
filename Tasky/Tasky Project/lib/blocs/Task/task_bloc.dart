// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../Helpers/taskhelper.dart';
import '../../blocs/HomePage/home_bloc.dart';
import '../../Helpers/applocalization.dart';
import '../../Models/taskmodel.dart';
import '../../Services/api.dart';
import '../../constant/theme.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  BuildContext context;
  TaskBloc(this.context) : super(TaskState(isLoading: false)) {
    //////////////////// Change Priority ////////////////

    on<ChangePriority>((event, emit) {
      emit(state.copyWith(priority: event.priority));
    });
    //////////////////// Change Date ////////////////

    on<ChangeDate>((event, emit) async {
      final date = await TaskHelper.changeDate(context);
      if (date != null) {
        emit(state.copyWith(date: date));
      }
    });
    //////////////////// Change Status ////////////////

    on<ChangeStatus>((event, emit) async {
      emit(state.copyWith(status: event.status));
    });
    ////////////////////Upload Image////////////////

    on<UploadImage>((event, emit) async {
      final File? image = await TaskHelper.selectImage(context);
      if (image != null) {
        emit(state.copyWith(taskImg: image));
      }
    });

    ////////////////////Upload Task////////////////

    on<UploadTask>((event, emit) async {
      if (state.formKey.currentState!.validate()) {
        emit(state.copyWith(isLoading: true));
        final sharedPreferences = await SharedPreferences.getInstance();
        final token = sharedPreferences.getString("Token") ?? "";

        var request =
            http.MultipartRequest("POST", Uri.parse('$api/upload/image'));
        request.headers.addAll({'Authorization': 'Bearer $token'});

        var multipartFile = await http.MultipartFile.fromPath(
          'image',
          state.taskImg!.path,
          contentType: MediaType('image', 'jpeg'),
        );
        request.files.add(multipartFile);

        var responseImage = await request.send();
        if (responseImage.statusCode == 200 ||
            responseImage.statusCode == 201) {
          String responseImageBody = await responseImage.stream.bytesToString();
          var decodedResponse = jsonDecode(responseImageBody);
          Map<String, dynamic> data = {
            "image": decodedResponse['image'],
            "title": event.title,
            "desc": event.desc,
            "priority": event.priority,
            "dueDate": event.dueDate
          };

          var response = await http.post(Uri.parse("$api/todos"),
              headers: {
                'Authorization': 'Bearer $token',
                'Content-Type': 'application/json',
              },
              body: jsonEncode(data));

          if (response.statusCode == 200 || response.statusCode == 201) {
            context.read<HomeBloc>().add(LoadHomeData());
            emit(state.copyWith(isLoading: false));
            Navigator.of(context).pop();
          }
        } else {
          emit(state.copyWith(isLoading: false));

          final snackBar = SnackBar(
            content: Text(
              "TaskImgError".tr(context),
              style: GoogleFonts.dmSans(
                fontSize: 16,
                color: ThemeColor.primaryColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            duration: const Duration(seconds: 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: ThemeColor.secondaryBackground,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    });
    ////////////////////Remove Task////////////////

    on<RemoveTask>((event, emit) async {
      final sharedPreferences = await SharedPreferences.getInstance();
      final token = sharedPreferences.getString("Token") ?? "";
      Map<String, String> header = {
        'Authorization': 'Bearer $token',
      };
      var response = await http.delete(Uri.parse("$api/todos/${event.iD}"),
          headers: header);
      if (response.statusCode == 200 || response.statusCode == 201) {
        context.read<HomeBloc>().add(LoadHomeData());
      }
    });
    ////////////////////Update Task////////////////

    on<UpdateTask>((event, emit) async {
      final sharedPreferences = await SharedPreferences.getInstance();
      final token = sharedPreferences.getString("Token") ?? "";
      Map<String, String> header = {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json",
      };

      Map<String, String> data = {
        "image": event.image,
        "title": event.title,
        "desc": event.desc,
        "priority": event.priority,
        "status": event.status,
        "user": event.user,
      };

      var response = await http.put(Uri.parse("$api/todos/${event.iD}"),
          body: jsonEncode(data), headers: header);
      if (response.statusCode == 200 || response.statusCode == 201) {
        context.read<HomeBloc>().add(LoadHomeData());
      }
    });
    //////////////////// Task Details////////////////

    on<TaskLoadingData>((event, emit) async {
      emit(TaskLoading(isLoading: true));
      try {
        final data = await TaskHelper.getData(event.iD);
        emit(TaskLoaded(taskDetails: data, isLoading: false));
      } catch (e) {
        emit(TaskError(isLoading: false));
      }
    });
  }
}
