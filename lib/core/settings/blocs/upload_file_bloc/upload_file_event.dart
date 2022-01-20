part of 'upload_file_bloc.dart';

abstract class UploadFileEvent extends Equatable {
  const UploadFileEvent();

  @override
  List<Object?> get props => [];
}

class UploadFileStarted extends UploadFileEvent {
  final String? id;

  const UploadFileStarted({this.id});

  @override
  List<Object?> get props => [id];
}
