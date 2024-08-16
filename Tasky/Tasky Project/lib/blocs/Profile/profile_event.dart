part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class LoadProfileData extends ProfileEvent {}

final class RefreshToken extends ProfileEvent {}
