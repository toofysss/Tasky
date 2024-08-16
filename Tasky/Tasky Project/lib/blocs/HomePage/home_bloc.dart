import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Helpers/homehelper.dart';
import '../../Helpers/refreshhelper.dart';
import '../../Models/homemodel.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  BuildContext context;
  HomeBloc(this.context) : super(HomeInitial()) {
    //////////////////// Get Tasks ////////////////

    on<LoadHomeData>((event, emit) async {
      final currentState = state;
      if (currentState is HomeLoaded && currentState.isLoadingMore) return;

      emit(currentState is HomeLoaded
          ? currentState.copyWith(isLoadingMore: true)
          : HomeLoading());

      try {
        // Load data for the current page (or initial page if currentState is not HomeLoaded)
        final nextPage =
            currentState is HomeLoaded ? currentState.currentPage + 1 : 1;
        final newData = await HomeHelper.getData(nextPage);

        if (currentState is HomeLoaded) {
          emit(currentState.copyWith(
            allTasks: List.of(currentState.allTasks)..addAll(newData),
            filteredTasks: List.of(currentState.filteredTasks)..addAll(newData),
            currentPage: nextPage,
            isLoadingMore: false,
          ));
        } else {
          emit(HomeLoaded(
            allTasks: newData,
            filteredTasks: newData,
            selectedTabIndex: 0,
            currentPage: nextPage,
            isLoadingMore: false,
          ));
        }
      } catch (e) {
        emit(HomeError());
      }
    });
    //////////////////// Refresh Token ////////////////

    on<RefreshTokenEvent>(
      (event, emit) async {
        await RefreshHelper.refreshToken();
        add(LoadHomeData());
      },
    );
    //////////////////// Filter Task ////////////////

    on<FilterTasksByTab>((event, emit) async {
      final currentState = state as HomeLoaded;
      final filteredTasks =
          HomeHelper.filterTasks(currentState.allTasks, event.tabIndex);
      emit(
        HomeLoaded(
            allTasks: currentState.allTasks,
            filteredTasks: filteredTasks,
            selectedTabIndex: event.tabIndex),
      );
    });
  }
}
