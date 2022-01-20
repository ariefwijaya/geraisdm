part of 'form_submission_submit_bloc.dart';

abstract class FormSubmissionSubmitState extends Equatable {
  const FormSubmissionSubmitState();

  @override
  List<Object> get props => [];
}

class FormSubmissionSubmitInitial extends FormSubmissionSubmitState {}

class FormSubmissionSubmitLoading extends FormSubmissionSubmitState {}

class FormSubmissionSubmitFailure extends FormSubmissionSubmitState {
  final Object error;
  final StackTrace stackTrace;

  const FormSubmissionSubmitFailure(
      {required this.error, required this.stackTrace});

  @override
  List<Object> get props => [error, stackTrace];
}

class FormSubmissionSubmitSuccess extends FormSubmissionSubmitState {}
