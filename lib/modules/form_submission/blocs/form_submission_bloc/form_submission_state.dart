part of 'form_submission_bloc.dart';

abstract class FormSubmissionState extends Equatable {
  const FormSubmissionState();

  @override
  List<Object> get props => [];
}

class FormSubmissionInitial extends FormSubmissionState {}

class FormSubmissionLoading extends FormSubmissionState {}

class FormSubmissionFailure extends FormSubmissionState {
  final Object error;
  final StackTrace stackTrace;

  const FormSubmissionFailure({required this.error, required this.stackTrace});
  @override
  List<Object> get props => [error, stackTrace];
}

class FormSubmissionSuccess extends FormSubmissionState {
  final FormSubmissionModel data;

  const FormSubmissionSuccess({required this.data});
  @override
  List<Object> get props => [data];
}
