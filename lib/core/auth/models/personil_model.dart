import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'personil_model.g.dart';

enum GenderType {
  @JsonValue("m")
  male,
  @JsonValue("f")
  female,
  unknown
}

@CopyWith()
@JsonSerializable(fieldRename: FieldRename.snake)
class PersonilModel {
  final String nrp;
  final String pangkat;
  final String golongan;
  final String jabatan;
  final String satker;
  final String agama;
  final String sukuBangsa;
  @JsonKey(unknownEnumValue: GenderType.unknown)
  final GenderType kelamin;
  final String bahasaAsing;
  final String bahasaDaerah;
  final int tinggi;
  final int berat;
  final String kulit;
  final String mata;
  final String darah;

  const PersonilModel(
      {required this.nrp,
      required this.pangkat,
      required this.golongan,
      required this.jabatan,
      required this.satker,
      required this.agama,
      required this.sukuBangsa,
      required this.kelamin,
      required this.bahasaAsing,
      required this.bahasaDaerah,
      required this.tinggi,
      required this.berat,
      required this.kulit,
      required this.mata,
      required this.darah});

  factory PersonilModel.fromJson(Map<String, dynamic> json) =>
      _$PersonilModelFromJson(json);
  Map<String, dynamic> toJson() => _$PersonilModelToJson(this);
}
