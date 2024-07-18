// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LangSpec _$LangSpecFromJson(Map<String, dynamic> json) => LangSpec(
      version: (json['Version'] as num?)?.toInt() ?? 0,
      logicSigVersion: (json['LogicSigVersion'] as num?)?.toInt() ?? 0,
      operations: (json['Ops'] as List<dynamic>?)
              ?.map((e) => Operation.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$LangSpecToJson(LangSpec instance) => <String, dynamic>{
      'Version': instance.version,
      'LogicSigVersion': instance.logicSigVersion,
      'Ops': instance.operations,
    };

Operation _$OperationFromJson(Map<String, dynamic> json) => Operation(
      opCode: (json['Opcode'] as num).toInt(),
      name: json['Name'] as String,
      opCost: Operation._costFromDocCost(json['DocCost'] as String),
      size: (json['Size'] as num).toInt(),
      returns: (json['Returns'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      argEnum: (json['ArgEnum'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      argEnumTypes: (json['ArgEnumTypes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      doc: json['Doc'] as String?,
      immediateNote: (json['ImmediateNote'] as List<dynamic>?)
          ?.map((e) => ImmediateNote.fromJson(e as Map<String, dynamic>))
          .toList(),
      group:
          (json['Group'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
    );

Map<String, dynamic> _$OperationToJson(Operation instance) => <String, dynamic>{
      'Opcode': instance.opCode,
      'Name': instance.name,
      'DocCost': Operation._costToDocCost(instance.opCost),
      'Size': instance.size,
      'Returns': instance.returns,
      'ArgEnum': instance.argEnum,
      'ArgEnumTypes': instance.argEnumTypes,
      'Doc': instance.doc,
      'ImmediateNote': instance.immediateNote,
      'Group': instance.group,
    };

ImmediateNote _$ImmediateNoteFromJson(Map<String, dynamic> json) =>
    ImmediateNote(
      json['Comment'] as String?,
      json['Encoding'] as String?,
      json['Name'] as String?,
      json['Reference'] as String?,
    );

Map<String, dynamic> _$ImmediateNoteToJson(ImmediateNote instance) =>
    <String, dynamic>{
      'Comment': instance.Comment,
      'Encoding': instance.Encoding,
      'Name': instance.Name,
      'Reference': instance.Reference,
    };
