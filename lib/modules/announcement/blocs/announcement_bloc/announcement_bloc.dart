import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/modules/announcement/models/announcement_model.dart';
import 'package:geraisdm/modules/announcement/repositories/announcement_repository_interface.dart';
import 'package:injectable/injectable.dart';

part 'announcement_event.dart';
part 'announcement_state.dart';

@injectable
class AnnouncementBloc extends Bloc<AnnouncementEvent, AnnouncementState> {
  final AnnouncementRepositoryInterface announcementRepository;

  AnnouncementBloc({required this.announcementRepository})
      : super(AnnouncementInitial()) {
    on<AnnouncementFetchDetail>((event, emit) async {
      try {
        emit(AnnouncementLoading());
        final res = await announcementRepository.getAnnouncementById(event.id);
        emit(AnnouncementDetailSuccess(data: res));
      } catch (e, s) {
        emit(AnnouncementFailure(error: e, stackTrace: s));
      }
    });
  }
}
