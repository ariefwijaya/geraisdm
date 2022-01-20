import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/modules/form_submission/models/form_submission_model.dart';
import 'package:geraisdm/modules/form_submission/repositories/form_submission_repository_interface.dart';
import 'package:injectable/injectable.dart';

part 'form_submission_event.dart';
part 'form_submission_state.dart';

@injectable
class FormSubmissionBloc
    extends Bloc<FormSubmissionEvent, FormSubmissionState> {
  final FormSubmissionRepositoryInterface formSubmissionRepositoryInterface;

  FormSubmissionBloc({required this.formSubmissionRepositoryInterface})
      : super(FormSubmissionInitial()) {
    on<FormSubmissionFetch>((event, emit) async {
      try {
        emit(FormSubmissionLoading());
        final res = await formSubmissionRepositoryInterface.getForm(event.id);
        emit(FormSubmissionSuccess(data: res));
      } catch (e, s) {
        emit(FormSubmissionFailure(error: e, stackTrace: s));
      }
    });
  }
}
