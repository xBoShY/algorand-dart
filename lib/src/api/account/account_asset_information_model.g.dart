// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_asset_information_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountAssetInformation _$AccountAssetInformationFromJson(
        Map<String, dynamic> json) =>
    AccountAssetInformation(
      round: const BigIntSerializer().fromJson(json['round']),
      nextToken: json['next-token'] as String?,
      assetHolding:
          AssetHolding.fromJson(json['asset-holding'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AccountAssetInformationToJson(
        AccountAssetInformation instance) =>
    <String, dynamic>{
      'round': const BigIntSerializer().toJson(instance.round),
      'next-token': instance.nextToken,
      'asset-holding': instance.assetHolding,
    };
