import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/core/settings/models/api_res_upload_model.dart';
import 'package:geraisdm/core/settings/repositories/upload_file_repository_interface.dart';
import 'package:injectable/injectable.dart';

part 'upload_file_event.dart';
part 'upload_file_state.dart';

@injectable
class UploadFileBloc extends Bloc<UploadFileEvent, UploadFileState> {
  final UploadFileRepositoryInterface uploadFileRepository;

  UploadFileBloc({required this.uploadFileRepository})
      : super(UploadFileInitial()) {
    on<UploadFileStarted>((event, emit) async {
      try {
        emit(UploadFileLoading());
        final res = await uploadFileRepository.uploadFile(id: event.id);
        if (res != null) {
          emit(UploadFileSuccess(data: res));
        } else {
          emit(UploadFileCancelled());
        }
      } catch (e, s) {
        emit(UploadFileFailed(error: e, stackTrace: s));
      }
    });
  }
}
