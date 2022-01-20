import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/core/settings/models/common_model.dart';
import 'package:geraisdm/env/env.dart';
import 'package:geraisdm/modules/complaint/models/complaint_model.dart';
import 'package:geraisdm/modules/complaint/repositories/complaint_repository_interface.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';

part 'complaint_list_event.dart';
part 'complaint_list_state.dart';

@injectable
class ComplaintListBloc extends Bloc<ComplaintListEvent, ComplaintListState> {
  final ComplaintRepositoryInterface complaintRepository;
  ComplaintListBloc({required this.complaintRepository})
      : super(ComplaintListInitial()) {
    late final PagingController<int, ComplaintModel> pagingController =
        PagingController(firstPageKey: 0);

    const int _pageSize = Env.defaultPaginationLimit;
    const PaginationControlModel filter =
        PaginationControlModel(pageOffset: 0, pageSize: _pageSize);

    void _fetchList(int pageOffset) {
      add(ComplaintListFetch(pageOffset));
    }

    on<ComplaintListStarted>((event, emit) {
      if (pagingController.nextPageKey != null &&
          pagingController.nextPageKey! > 0) {
        pagingController.refresh();
      }
      pagingController.removePageRequestListener(_fetchList);
      pagingController.addPageRequestListener(_fetchList);
      emit(ComplaintListStartSuccess(pagingController));
    });

    on<ComplaintListFetch>((event, emit) async {
      try {
        late List<ComplaintModel> items;
        items = await complaintRepository.getComplaint(
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

    on<ComplaintRefresh>((event, emit) {
      pagingController.refresh();
    });
  }
}
