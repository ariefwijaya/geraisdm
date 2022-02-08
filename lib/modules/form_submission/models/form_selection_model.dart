import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'form_selection_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class FormSelectionModel extends Equatable {
  final String name;
  final String? value;
  const FormSelectionModel({required this.name, this.value});

  factory FormSelectionModel.fromJson(Map<String, dynamic> json) =>
      _$FormSelectionModelFromJson(json);
  Map<String, dynamic> toJson() => _$FormSelectionModelToJson(this);

  @override
  List<Object?> get props => [name, value];
}
