import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/modules/profile/models/profile_biodata_model.dart';
import 'package:geraisdm/modules/profile/repositories/profile_repository_interface.dart';
import 'package:injectable/injectable.dart';

part 'profile_biodata_event.dart';
part 'profile_biodata_state.dart';

@injectable
class ProfileBiodataBloc
    extends Bloc<ProfileBiodataEvent, ProfileBiodataState> {
  final ProfileRepositoryInterface profileRepositoryInterface;
  ProfileBiodataBloc({required this.profileRepositoryInterface})
      : super(ProfileBiodataInitial()) {
    on<ProfileBiodataFetch>((event, emit) async {
      try {
        emit(ProfileBiodataLoading());
        final res = await profileRepositoryInterface.getBiodata();
        emit(ProfileBiodataSuccess(listData: res));
      } catch (e, s) {
        emit(ProfileBiodataFailure(error: e, stackTrace: s));
      }
    });
  }
}
