import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/modules/form_submission/models/form_selection_model.dart';
import 'package:geraisdm/modules/form_submission/repositories/form_submission_repository_interface.dart';
import 'package:injectable/injectable.dart';

part 'form_selection_event.dart';
part 'form_selection_state.dart';

@injectable
class FormSelectionBloc extends Bloc<FormSelectionEvent, FormSelectionState> {
  final FormSubmissionRepositoryInterface formSubmissionRepositoryInterface;
  FormSelectionBloc({required this.formSubmissionRepositoryInterface})
      : super(FormSelectionInitial()) {
    on<FormSelectionFetch>((event, emit) async {
      try {
        emit(FormSelectionLoading());
        final res =
            await formSubmissionRepositoryInterface.getSelections(event.url);
        emit(FormSelectionSuccess(data: res));
      } catch (e, s) {
        emit(FormSelectionFailure(error: e, stackTrace: s));
      }
    });
  }
}
