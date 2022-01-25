import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/core/settings/models/api_res_upload_model.dart';
import 'package:geraisdm/modules/profile/repositories/profile_repository_interface.dart';
import 'package:injectable/injectable.dart';

part 'profile_avatar_update_event.dart';
part 'profile_avatar_update_state.dart';

@injectable
class ProfileAvatarUpdateBloc
    extends Bloc<ProfileAvatarUpdateEvent, ProfileAvatarUpdateState> {
  final ProfileRepositoryInterface profileRepositoryInterface;

  ProfileAvatarUpdateBloc({required this.profileRepositoryInterface})
      : super(ProfileAvatarUpdateInitial()) {
    on<ProfileAvatarUpdateCameraStarted>((event, emit) async {
      try {
        emit(ProfileAvatarUpdateLoading());
        final res = await profileRepositoryInterface.uploadAvatarFromCamera();
        if (res != null) {
          emit(ProfileAvatarUpdateSuccess(data: res));
        } else {
          emit(ProfileAvatarUpdateCancelled());
        }
      } catch (e, s) {
        emit(ProfileAvatarUpdateFailed(error: e, stackTrace: s));
      }
    });

    on<ProfileAvatarUpdateGalleryStarted>((event, emit) async {
      try {
        emit(ProfileAvatarUpdateLoading());
        final res = await profileRepositoryInterface.uploadAvatarFromGallery();
        if (res != null) {
          emit(ProfileAvatarUpdateSuccess(data: res));
        } else {
          emit(ProfileAvatarUpdateCancelled());
        }
      } catch (e, s) {
        emit(ProfileAvatarUpdateFailed(error: e, stackTrace: s));
      }
    });
  }
}
