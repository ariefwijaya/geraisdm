part of 'upload_file_bloc.dart';

abstract class UploadFileState extends Equatable {
  const UploadFileState();

  @override
  List<Object> get props => [];
}

class UploadFileInitial extends UploadFileState {}

class UploadFileLoading extends UploadFileState {}

class UploadFileFailed extends UploadFileState {
  final Object error;
  final StackTrace stackTrace;

  const UploadFileFailed({required this.error, required this.stackTrace});
  @override
  List<Object> get props => [error, stackTrace];
}

class UploadFileSuccess extends UploadFileState {
  final ApiResUploadModel data;

  const UploadFileSuccess({required this.data});
  @override
  List<Object> get props => [data];
}

class UploadFileCancelled extends UploadFileState {}
