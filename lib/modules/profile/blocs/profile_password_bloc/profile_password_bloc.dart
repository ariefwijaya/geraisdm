import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/modules/profile/models/profile_change_password_model.dart';
import 'package:geraisdm/modules/profile/repositories/profile_repository_interface.dart';
import 'package:injectable/injectable.dart';

part 'profile_password_event.dart';
part 'profile_password_state.dart';

@injectable
class ProfilePasswordBloc
    extends Bloc<ProfilePasswordEvent, ProfilePasswordState> {
  final ProfileRepositoryInterface profileRepositoryInterface;
  ProfilePasswordBloc({required this.profileRepositoryInterface})
      : super(ProfilePasswordInitial()) {
    on<ProfilePasswordChange>((event, emit) async {
      try {
        emit(ProfilePasswordLoading());
        await profileRepositoryInterface.changePasssword(event.form);
        emit(ProfilePasswordSuccess());
      } catch (e, s) {
        emit(ProfilePasswordFailure(error: e, stackTrace: s));
      }
    });
  }
}
