import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/core/auth/models/user_model.dart';
import 'package:geraisdm/core/auth/repositories/auth_repository_interface.dart';
import 'package:injectable/injectable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthRepositoryInterface authRepositoryInterface;
  ProfileBloc({required this.authRepositoryInterface})
      : super(ProfileInitial()) {
    on<ProfileFetch>((event, emit) async {
      try {
        emit(ProfileLoading());
        final res = await authRepositoryInterface.getUserData();
        emit(ProfileSuccess(data: res));
      } catch (e, s) {
        emit(ProfileFailure(error: e, stackTrace: s));
      }
    });
  }
}
