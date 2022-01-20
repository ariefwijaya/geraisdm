import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/core/settings/models/common_model.dart';
import 'package:geraisdm/env/env.dart';
import 'package:geraisdm/modules/bookmark/models/bookmark_model.dart';
import 'package:geraisdm/modules/bookmark/repositories/bookmark_repository_interface.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';

part 'bookmark_list_event.dart';
part 'bookmark_list_state.dart';

@injectable
class BookmarkListBloc extends Bloc<BookmarkListEvent, BookmarkListState> {
  final BookmarkRepositoryInterface bookmarkRepository;
  BookmarkListBloc({required this.bookmarkRepository})
      : super(BookmarkListInitial()) {
    late final PagingController<int, BookmarkModel> pagingController =
        PagingController(firstPageKey: 0);

    const int _pageSize = Env.defaultPaginationLimit;
    const PaginationControlModel filter =
        PaginationControlModel(pageOffset: 0, pageSize: _pageSize);

    void _fetchList(int pageOffset) {
      add(BookmarkListFetch(pageOffset));
    }

    on<BookmarkListStarted>((event, emit) {
      if (pagingController.nextPageKey != null &&
          pagingController.nextPageKey! > 0) {
        pagingController.refresh();
      }
      pagingController.removePageRequestListener(_fetchList);
      pagingController.addPageRequestListener(_fetchList);
      emit(BookmarkListStartSuccess(pagingController));
    });

    on<BookmarkListFetch>((event, emit) async {
      try {
        late List<BookmarkModel> items;
        items = await bookmarkRepository.getBookmark(
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

    on<BookmarkRefresh>((event, emit) {
      pagingController.refresh();
    });
  }
}
