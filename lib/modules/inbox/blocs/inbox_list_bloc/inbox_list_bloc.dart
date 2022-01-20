import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/core/settings/models/common_model.dart';
import 'package:geraisdm/env/env.dart';
import 'package:geraisdm/modules/inbox/models/inbox_model.dart';
import 'package:geraisdm/modules/inbox/repositories/inbox_repository_interface.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';

part 'inbox_list_event.dart';
part 'inbox_list_state.dart';

@injectable
class InboxListBloc extends Bloc<InboxListEvent, InboxListState> {
  final InboxRepositoryInterface inboxRepository;
  InboxListBloc({required this.inboxRepository}) : super(InboxListInitial()) {
    late final PagingController<int, InboxModel> pagingController =
        PagingController(firstPageKey: 0);

    const _pageSize = Env.defaultPaginationLimit;
    const PaginationControlModel filter =
        PaginationControlModel(pageOffset: 0, pageSize: _pageSize);

    void _fetchList(int pageOffset) {
      add(InboxListFetch(pageOffset));
    }

    on<InboxListStarted>((event, emit) {
      if (pagingController.nextPageKey != null &&
          pagingController.nextPageKey! > 0) {
        pagingController.refresh();
      }
      pagingController.removePageRequestListener(_fetchList);
      pagingController.addPageRequestListener(_fetchList);
      emit(InboxListStartSuccess(pagingController));
    });

    on<InboxListFetch>((event, emit) async {
      try {
        late List<InboxModel> items;
        items = await inboxRepository.getInbox(
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

    on<InboxRefresh>((event, emit) {
      pagingController.refresh();
    });
  }
}
