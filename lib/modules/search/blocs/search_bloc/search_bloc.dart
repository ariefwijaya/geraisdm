import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/core/settings/models/common_model.dart';
import 'package:geraisdm/env/env.dart';
import 'package:geraisdm/modules/search/models/search_model.dart';
import 'package:geraisdm/modules/search/repositories/search_repository_interface.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

part 'search_event.dart';
part 'search_state.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepositoryInterface searchRepository;
  SearchBloc({required this.searchRepository}) : super(SearchInitial()) {
    late final PagingController<int, SearchModel> pagingController =
        PagingController(firstPageKey: 0);

    const int _pageSize = Env.defaultPaginationLimit;
    const PaginationControlModel filter =
        PaginationControlModel(pageOffset: 0, pageSize: _pageSize);
    String? query;

    void _fetchList(int pageOffset) {
      add(SearchFetch(pageOffset));
    }

    on<SearchStarted>((event, emit) {
      if (pagingController.nextPageKey != null &&
          pagingController.nextPageKey! > 0) {
        pagingController.refresh();
      }
      pagingController.removePageRequestListener(_fetchList);
      pagingController.addPageRequestListener(_fetchList);
      emit(SearchStartSuccess(pagingController));
    });

    on<SearchFetch>((event, emit) async {
      try {
        late List<SearchModel> items;
        items = await searchRepository.getListByKeywords(
            query: query,
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

    on<SearchRefresh>((event, emit) {
      query = event.query;
      pagingController.refresh();
    }, transformer: debounce(const Duration(milliseconds: 600)));
  }

  EventTransformer<Event> debounce<Event>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
