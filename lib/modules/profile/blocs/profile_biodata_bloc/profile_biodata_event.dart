part of 'profile_biodata_bloc.dart';

abstract class ProfileBiodataEvent extends Equatable {
  const ProfileBiodataEvent();

  @override
  List<Object> get props => [];
}

class ProfileBiodataFetch extends ProfileBiodataEvent {}
