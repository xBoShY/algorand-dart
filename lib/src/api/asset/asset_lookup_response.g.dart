// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_lookup_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetResponse _$AssetResponseFromJson(Map<String, dynamic> json) =>
    AssetResponse(
      currentRound: const BigIntSerializer().fromJson(json['current-round']),
      asset: Asset.fromJson(json['asset'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AssetResponseToJson(AssetResponse instance) =>
    <String, dynamic>{
      'current-round': const BigIntSerializer().toJson(instance.currentRound),
      'asset': instance.asset,
    };
