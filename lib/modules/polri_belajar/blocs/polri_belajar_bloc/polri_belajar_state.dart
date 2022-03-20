part of 'polri_belajar_bloc.dart';

abstract class PolriBelajarState extends Equatable {
  const PolriBelajarState();

  @override
  List<Object> get props => [];
}

class PolriBelajarInitial extends PolriBelajarState {}

class PolriBelajarLoading extends PolriBelajarState {}

class PolriBelajarDetailSuccess extends PolriBelajarState {
  final PolriBelajarModel data;
  const PolriBelajarDetailSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class PolriBelajarFailure extends PolriBelajarState {
  final Object error;
  final StackTrace stackTrace;

  const PolriBelajarFailure({required this.error, required this.stackTrace});

  @override
  List<Object> get props => [error, stackTrace];
}
