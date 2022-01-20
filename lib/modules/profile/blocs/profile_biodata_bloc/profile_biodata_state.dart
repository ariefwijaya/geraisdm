part of 'profile_biodata_bloc.dart';

abstract class ProfileBiodataState extends Equatable {
  const ProfileBiodataState();

  @override
  List<Object> get props => [];
}

class ProfileBiodataInitial extends ProfileBiodataState {}

class ProfileBiodataLoading extends ProfileBiodataState {}

class ProfileBiodataFailure extends ProfileBiodataState {
  final Object error;
  final StackTrace stackTrace;

  const ProfileBiodataFailure({required this.error, required this.stackTrace});

  @override
  List<Object> get props => [error, stackTrace];
}

class ProfileBiodataSuccess extends ProfileBiodataState {
  final List<ProfileBiodataModel> listData;
  const ProfileBiodataSuccess({required this.listData});

  @override
  List<Object> get props => [listData];
}
