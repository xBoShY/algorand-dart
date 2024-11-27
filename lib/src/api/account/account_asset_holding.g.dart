// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_asset_holding.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountAssetHolding _$AccountAssetHoldingFromJson(Map<String, dynamic> json) =>
    AccountAssetHolding(
      assetHolding:
          AssetHolding.fromJson(json['asset-holding'] as Map<String, dynamic>),
      assetParams: json['asset-params'] == null
          ? null
          : AssetParameters.fromJson(
              json['asset-params'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AccountAssetHoldingToJson(
        AccountAssetHolding instance) =>
    <String, dynamic>{
      'asset-holding': instance.assetHolding,
      'asset-params': instance.assetParams,
    };
