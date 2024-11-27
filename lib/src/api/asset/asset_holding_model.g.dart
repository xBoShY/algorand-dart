// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_holding_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetHolding _$AssetHoldingFromJson(Map<String, dynamic> json) => AssetHolding(
      amount: const BigIntSerializer().fromJson(json['amount']),
      assetId: const BigIntSerializer().fromJson(json['asset-id']),
      creator: json['creator'] as String?,
      isFrozen: json['is-frozen'] as bool,
      deleted: json['deleted'] as bool?,
      optedInAtRound: (json['opted-in-at-round'] as num?)?.toInt(),
      optedOutAtRound: (json['opted-out-at-round'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AssetHoldingToJson(AssetHolding instance) =>
    <String, dynamic>{
      'amount': const BigIntSerializer().toJson(instance.amount),
      'asset-id': const BigIntSerializer().toJson(instance.assetId),
      'creator': instance.creator,
      'deleted': instance.deleted,
      'is-frozen': instance.isFrozen,
      'opted-in-at-round': instance.optedInAtRound,
      'opted-out-at-round': instance.optedOutAtRound,
    };
