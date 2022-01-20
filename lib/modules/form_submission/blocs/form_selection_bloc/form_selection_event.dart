part of 'form_selection_bloc.dart';

abstract class FormSelectionEvent extends Equatable {
  const FormSelectionEvent();

  @override
  List<Object> get props => [];
}

class FormSelectionFetch extends FormSelectionEvent {
  final String url;

  const FormSelectionFetch({required this.url});

  @override
  List<Object> get props => [url];
}
