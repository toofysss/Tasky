import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Helpers/profilehelper.dart';
import '../../Helpers/refreshhelper.dart';
import '../../Models/profilemodel.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    //////////////////// Loading Profile ////////////////

    on<LoadProfileData>((event, emit) async {
      emit(ProfileLoadingState());
      try {
        final data = await ProfileHelper.getData();
        emit(ProfileLoaded(data));
      } catch (e) {
        emit(ProfileErrorState());
      }
    });
    //////////////////// Refresh Token ////////////////

    on<RefreshToken>(
      (event, emit) async {
        await RefreshHelper.refreshToken();
        add(LoadProfileData());
      },
    );
  }
}
