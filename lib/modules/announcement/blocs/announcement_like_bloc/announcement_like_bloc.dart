import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/modules/announcement/repositories/announcement_repository_interface.dart';
import 'package:injectable/injectable.dart';

part 'announcement_like_event.dart';
part 'announcement_like_state.dart';

@injectable
class AnnouncementLikeBloc
    extends Bloc<AnnouncementLikeEvent, AnnouncementLikeState> {
  final AnnouncementRepositoryInterface announcementRepositoryInterface;
  AnnouncementLikeBloc({required this.announcementRepositoryInterface})
      : super(AnnouncementLikeInitial()) {
    on<AnnouncementLikeStart>((event, emit) async {
      try {
        emit(AnnouncementLikeLoading());
        emit(AnnouncementLikeSuccess(liked: event.like));
        await announcementRepositoryInterface.toggleLiked(event.id,
            liked: event.like);
      } catch (e) {
        emit(AnnouncementLikeSuccess(liked: !event.like));
      }
    });
  }
}
