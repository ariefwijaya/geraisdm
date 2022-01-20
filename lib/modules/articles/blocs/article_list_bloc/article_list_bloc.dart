import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/core/settings/models/common_model.dart';
import 'package:geraisdm/env/env.dart';
import 'package:geraisdm/modules/articles/models/article_model.dart';
import 'package:geraisdm/modules/articles/repositories/article_repository_interface.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';

part 'article_list_event.dart';
part 'article_list_state.dart';

@injectable
class ArticleListBloc extends Bloc<ArticleListEvent, ArticleListState> {
  final ArticleRepositoryInterface articleRepository;
  ArticleListBloc({required this.articleRepository})
      : super(ArticleListInitial()) {
    late final PagingController<int, ArticleModel> pagingController =
        PagingController(firstPageKey: 0);

    const int _pageSize = Env.defaultPaginationLimit;
    const PaginationControlModel filter =
        PaginationControlModel(pageOffset: 0, pageSize: _pageSize);

    void _fetchList(int pageOffset) {
      add(ArticleListFetch(pageOffset));
    }

    on<ArticleListStarted>((event, emit) {
      if (pagingController.nextPageKey != null &&
          pagingController.nextPageKey! > 0) {
        pagingController.refresh();
      }
      pagingController.removePageRequestListener(_fetchList);
      pagingController.addPageRequestListener(_fetchList);
      emit(ArticleListStartSuccess(pagingController));
    });

    on<ArticleListFetch>((event, emit) async {
      try {
        late List<ArticleModel> items;
        items = await articleRepository.getArticle(
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

    on<ArticleRefresh>((event, emit) {
      pagingController.refresh();
    });
  }
}
