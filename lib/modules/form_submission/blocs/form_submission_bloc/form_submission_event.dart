part of 'form_submission_bloc.dart';

abstract class FormSubmissionEvent extends Equatable {
  const FormSubmissionEvent();

  @override
  List<Object> get props => [];
}

class FormSubmissionFetch extends FormSubmissionEvent {
  final int id;

  const FormSubmissionFetch({required this.id});

  @override
  List<Object> get props => [id];
}
