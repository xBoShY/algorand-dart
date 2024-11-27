// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'langspec.dart';

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
