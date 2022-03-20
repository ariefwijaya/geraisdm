import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/core/settings/models/common_model.dart';
import 'package:geraisdm/env/env.dart';
import 'package:geraisdm/modules/polri_belajar/models/polri_belajar_model.dart';
import 'package:geraisdm/modules/polri_belajar/repositories/polri_belajar_repository_interface.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';

part 'polri_belajar_list_event.dart';
part 'polri_belajar_list_state.dart';

@injectable
class PolriBelajarListBloc
    extends Bloc<PolriBelajarListEvent, PolriBelajarListState> {
  final PolriBelajarRepositoryInterface polriBelajarRepository;
  PolriBelajarListBloc({required this.polriBelajarRepository})
      : super(PolriBelajarListInitial()) {
    late final PagingController<int, PolriBelajarModel> pagingController =
        PagingController(firstPageKey: 0);

    const int _pageSize = Env.defaultPaginationLimit;
    const PaginationControlModel filter =
        PaginationControlModel(pageOffset: 0, pageSize: _pageSize);
    int? refId;

    void _fetchList(int pageOffset) {
      add(PolriBelajarListFetch(pageOffset));
    }

    on<PolriBelajarListStarted>((event, emit) {
      if (pagingController.nextPageKey != null &&
          pagingController.nextPageKey! > 0) {
        pagingController.refresh();
      }
      refId = event.refId;
      pagingController.removePageRequestListener(_fetchList);
      pagingController.addPageRequestListener(_fetchList);
      emit(PolriBelajarListStartSuccess(pagingController));
    });

    on<PolriBelajarListFetch>((event, emit) async {
      try {
        late List<PolriBelajarModel> items;
        items = await polriBelajarRepository.getPolriBelajar(refId!,
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

    on<PolriBelajarRefresh>((event, emit) {
      pagingController.refresh();
    });
  }
}
