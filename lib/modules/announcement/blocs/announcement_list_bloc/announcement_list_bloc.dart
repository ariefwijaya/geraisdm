import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/core/settings/models/common_model.dart';
import 'package:geraisdm/env/env.dart';
import 'package:geraisdm/modules/announcement/models/announcement_model.dart';
import 'package:geraisdm/modules/announcement/repositories/announcement_repository_interface.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';

part 'announcement_list_event.dart';
part 'announcement_list_state.dart';

@injectable
class AnnouncementListBloc
    extends Bloc<AnnouncementListEvent, AnnouncementListState> {
  final AnnouncementRepositoryInterface announcementRepository;
  AnnouncementListBloc({required this.announcementRepository})
      : super(AnnouncementListInitial()) {
    late final PagingController<int, AnnouncementModel> pagingController =
        PagingController(firstPageKey: 0);

    const int _pageSize = Env.defaultPaginationLimit;
    const PaginationControlModel filter =
        PaginationControlModel(pageOffset: 0, pageSize: _pageSize);

    void _fetchList(int pageOffset) {
      add(AnnouncementListFetch(pageOffset));
    }

    on<AnnouncementListStarted>((event, emit) {
      if (pagingController.nextPageKey != null &&
          pagingController.nextPageKey! > 0) {
        pagingController.refresh();
      }
      pagingController.removePageRequestListener(_fetchList);
      pagingController.addPageRequestListener(_fetchList);
      emit(AnnouncementListStartSuccess(pagingController));
    });

    on<AnnouncementListFetch>((event, emit) async {
      try {
        late List<AnnouncementModel> items;
        items = await announcementRepository.getAnnouncement(
            filter: filter.copyWith(
                pageOffset: event.pageKey, pageSize: _pageSize));

        final isLastPage = items.length < _pageSize;
        if (isLastPage) {
          pagingController.appendLastPage(items);
        } else {
          final nextPageKey = event.pageKey + items.length;
          pagingController.appendPage(items, nextPageKey);
        }
      } catch (error) {
        pagingController.error = error;
      }
    });

    on<AnnouncementRefresh>((event, emit) {
      pagingController.refresh();
    });
  }
}
