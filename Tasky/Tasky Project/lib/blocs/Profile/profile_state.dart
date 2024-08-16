part of 'profile_bloc.dart';

@immutable
sealed class ProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoadingState extends ProfileState {}

final class ProfileErrorState extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final ProfileModel profileData;

  ProfileLoaded(this.profileData);
}
