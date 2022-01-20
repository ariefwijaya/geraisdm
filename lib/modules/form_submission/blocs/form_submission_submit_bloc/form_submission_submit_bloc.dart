import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/modules/form_submission/repositories/form_submission_repository_interface.dart';
import 'package:injectable/injectable.dart';

part 'form_submission_submit_event.dart';
part 'form_submission_submit_state.dart';

@injectable
class FormSubmissionSubmitBloc
    extends Bloc<FormSubmissionSubmitEvent, FormSubmissionSubmitState> {
  final FormSubmissionRepositoryInterface formSubmissionRepositoryInterface;
  FormSubmissionSubmitBloc({required this.formSubmissionRepositoryInterface})
      : super(FormSubmissionSubmitInitial()) {
    on<FormSubmissionSubmitStart>((event, emit) async {
      try {
        emit(FormSubmissionSubmitLoading());
        await formSubmissionRepositoryInterface.submit(event.id,
            form: event.form);
        emit(FormSubmissionSubmitSuccess());
      } catch (e, s) {
        emit(FormSubmissionSubmitFailure(error: e, stackTrace: s));
      }
    });
  }
}
