import 'package:json_annotation/json_annotation.dart';
import 'langspec_operation.dart';

export 'langspec_operation.dart';
export 'langspec_raw.dart';

part 'langspec.g.dart';

@JsonSerializable()
class LangSpec {
  @JsonKey(name: 'Version', defaultValue: 0)
  final int version;

  @JsonKey(name: 'LogicSigVersion', defaultValue: 0)
  final int logicSigVersion;

  @JsonKey(name: 'Ops', defaultValue: [])
  final List<Operation> operations;

  LangSpec({
    required this.version,
    required this.logicSigVersion,
    required this.operations,
  });

  factory LangSpec.fromJson(Map<String, dynamic> json) =>
      _$LangSpecFromJson(json);

  Map<String, dynamic> toJson() => _$LangSpecToJson(this);
}
