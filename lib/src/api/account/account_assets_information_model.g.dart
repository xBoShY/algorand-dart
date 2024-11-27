// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_assets_information_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountAssetsInformation _$AccountAssetsInformationFromJson(
        Map<String, dynamic> json) =>
    AccountAssetsInformation(
      round: const BigIntSerializer().fromJson(json['round']),
      nextToken: json['next-token'] as String?,
      assetHoldings: (json['asset-holdings'] as List<dynamic>?)
              ?.map((e) =>
                  AccountAssetHolding.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$AccountAssetsInformationToJson(
        AccountAssetsInformation instance) =>
    <String, dynamic>{
      'round': const BigIntSerializer().toJson(instance.round),
      'next-token': instance.nextToken,
      'asset-holdings': instance.assetHoldings,
    };
