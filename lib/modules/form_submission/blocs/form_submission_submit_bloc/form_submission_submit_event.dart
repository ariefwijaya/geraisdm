part of 'form_submission_submit_bloc.dart';

abstract class FormSubmissionSubmitEvent extends Equatable {
  const FormSubmissionSubmitEvent();

  @override
  List<Object> get props => [];
}

class FormSubmissionSubmitStart extends FormSubmissionSubmitEvent {
  final int id;
  final Map<String, dynamic> form;
  const FormSubmissionSubmitStart({required this.form, required this.id});

  @override
  List<Object> get props => [form, id];
}
