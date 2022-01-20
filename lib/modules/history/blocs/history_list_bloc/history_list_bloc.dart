import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/core/settings/models/common_model.dart';
import 'package:geraisdm/env/env.dart';
import 'package:geraisdm/modules/history/models/history_model.dart';
import 'package:geraisdm/modules/history/repositories/history_repository_interface.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';

part 'history_list_event.dart';
part 'history_list_state.dart';

@injectable
class HistoryListBloc extends Bloc<HistoryListEvent, HistoryListState> {
  final HistoryRepositoryInterface historyRepository;
  HistoryListBloc({required this.historyRepository})
      : super(HistoryListInitial()) {
    late final PagingController<int, HistoryModel> pagingController =
        PagingController(firstPageKey: 0);

    const _pageSize = Env.defaultPaginationLimit;
    const PaginationControlModel filter =
        PaginationControlModel(pageOffset: 0, pageSize: _pageSize);

    void _fetchList(int pageOffset) {
      add(HistoryListFetch(pageOffset));
    }

    on<HistoryListStarted>((event, emit) {
      if (pagingController.nextPageKey != null &&
          pagingController.nextPageKey! > 0) {
        pagingController.refresh();
      }
      pagingController.removePageRequestListener(_fetchList);
      pagingController.addPageRequestListener(_fetchList);
      emit(HistoryListStartSuccess(pagingController));
    });

    on<HistoryListFetch>((event, emit) async {
      try {
        late List<HistoryModel> items;
        items = await historyRepository.getHistories(
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

    on<HistoryRefresh>((event, emit) {
      pagingController.refresh();
    });
  }
}
