part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadHomeData extends HomeEvent {}

final class RefreshTokenEvent extends HomeEvent {}

class FilterTasksByTab extends HomeEvent {
  final int tabIndex;

  FilterTasksByTab(this.tabIndex);

  @override
  List<Object> get props => [tabIndex];
}
