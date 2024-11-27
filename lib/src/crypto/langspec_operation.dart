import 'package:json_annotation/json_annotation.dart';

part 'langspec_operation.g.dart';

@JsonSerializable()
class Operation {
  @JsonKey(name: 'Opcode')
  final int opCode;

  @JsonKey(name: 'Name')
  final String name;

  @JsonKey(
    name: 'DocCost',
    fromJson: _costFromDocCost,
    toJson: _costToDocCost,
  )
  final OperationCost opCost;

  @JsonKey(name: 'Size')
  final int size;

  @JsonKey(name: 'Returns', defaultValue: [])
  final List<String> returns;

  @JsonKey(name: 'ArgEnum', defaultValue: [])
  final List<String> argEnum;

  @JsonKey(name: 'ArgEnumTypes')
  final List<String>? argEnumTypes;

  @JsonKey(name: 'Doc')
  final String? doc;

  @JsonKey(name: 'ImmediateNote')
  final List<ImmediateNote>? immediateNote;

  @JsonKey(name: 'Group', defaultValue: [])
  final List<String> group;

  Operation({
    required this.opCode,
    required this.name,
    required this.opCost,
    required this.size,
    required this.returns,
    required this.argEnum,
    required this.argEnumTypes,
    required this.doc,
    required this.immediateNote,
    required this.group,
  });

  factory Operation.fromJson(Map<String, dynamic> json) =>
      _$OperationFromJson(json);

  Map<String, dynamic> toJson() => _$OperationToJson(this);

  static OperationCost _costFromDocCost(String docCost) =>
      OperationCost.fromDocCost(docCost);
  static String _costToDocCost(OperationCost cost) => cost.docCost;
}

class OperationCost {
  final String docCost;
  final int cost;
  final bool isVariable;

  OperationCost(
    this.docCost,
    this.cost,
    this.isVariable,
  );

  factory OperationCost.fromDocCost(String docCost) {
    /// It's hard to calculate the final cost for OpCodes with complex
    /// rules.
    /// The rules depend on the opcode's arguments, which might not be
    /// available at compilation time.
    /// ToDo: Determine a base cost.
    final cost = int.tryParse(docCost);
    return OperationCost(docCost, cost ?? 0, cost == null);
  }
}

@JsonSerializable()
class ImmediateNote {
  @JsonKey(name: 'Comment')
  String? Comment;

  @JsonKey(name: 'Encoding')
  String? Encoding;

  @JsonKey(name: 'Name')
  String? Name;

  @JsonKey(name: 'Reference')
  String? Reference;

  ImmediateNote(
    this.Comment,
    this.Encoding,
    this.Name,
    this.Reference,
  );

  factory ImmediateNote.fromJson(Map<String, dynamic> json) =>
      _$ImmediateNoteFromJson(json);
}
