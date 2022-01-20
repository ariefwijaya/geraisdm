import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/modules/announcement/models/announcement_model.dart';
import 'package:geraisdm/modules/home/repositories/home_repository_interface.dart';
import 'package:injectable/injectable.dart';

part 'home_announcement_event.dart';
part 'home_announcement_state.dart';

@injectable
class HomeAnnouncementBloc
    extends Bloc<HomeAnnouncementEvent, HomeAnnouncementState> {
  final HomeRepositoryInterface homeRepositoryInterface;
  HomeAnnouncementBloc({required this.homeRepositoryInterface})
      : super(HomeAnnouncementInitial()) {
    on<HomeAnnouncementFetch>((event, emit) async {
      try {
        emit(HomeAnnouncementLoading());
        final res = await homeRepositoryInterface.getLatestAnnouncements();
        emit(HomeAnnouncementSuccess(listData: res));
      } catch (e, s) {
        emit(HomeAnnouncementFailure(error: e, stackTrace: s));
      }
    });
  }
}
