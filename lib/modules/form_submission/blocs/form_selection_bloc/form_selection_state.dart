part of 'form_selection_bloc.dart';

abstract class FormSelectionState extends Equatable {
  const FormSelectionState();

  @override
  List<Object> get props => [];
}

class FormSelectionInitial extends FormSelectionState {}

class FormSelectionLoading extends FormSelectionState {}

class FormSelectionFailure extends FormSelectionState {
  final Object error;
  final StackTrace stackTrace;

  const FormSelectionFailure({required this.error, required this.stackTrace});

  @override
  List<Object> get props => [error, stackTrace];
}

class FormSelectionSuccess extends FormSelectionState {
  final List<FormSelectionModel> data;

  const FormSelectionSuccess({required this.data});

  @override
  List<Object> get props => [data];
}
