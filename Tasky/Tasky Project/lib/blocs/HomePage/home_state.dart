part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {}

class HomeLoaded extends HomeState {
  final List<HomeModel> allTasks;
  final int selectedTabIndex;
  final List<HomeModel> filteredTasks;
  final int currentPage;
  final bool isLoadingMore;

  HomeLoaded({
    required this.allTasks,
    required this.selectedTabIndex,
    required this.filteredTasks,
    this.currentPage = 1,
    this.isLoadingMore = false,
  });

  @override
  List<Object> get props =>
      [allTasks, filteredTasks, currentPage, isLoadingMore];

  HomeLoaded copyWith({
    List<HomeModel>? allTasks,
    int? selectedTabIndex,
    List<HomeModel>? filteredTasks,
    int? currentPage,
    bool? isLoadingMore,
  }) {
    return HomeLoaded(
      allTasks: allTasks ?? this.allTasks,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      filteredTasks: filteredTasks ?? this.filteredTasks,
      currentPage: currentPage ?? this.currentPage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}
