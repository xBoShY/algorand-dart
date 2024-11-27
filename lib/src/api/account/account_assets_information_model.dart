import 'package:algorand_dart/src/utils/serializers/serializers.dart';
import 'package:json_annotation/json_annotation.dart';
import 'account_asset_holding.dart';
part 'account_assets_information_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.kebab)
class AccountAssetsInformation {
  /// Round at which the results were computed.
  @JsonKey(name: 'round')
  @BigIntSerializer()
  final BigInt round;

  /// Used for pagination, when making another request provide this token
  /// with the next parameter.
  @JsonKey(name: 'next-token')
  final String? nextToken;

  /// list of assets held by the address
  @JsonKey(name: 'asset-holdings', defaultValue: [])
  final List<AccountAssetHolding> assetHoldings;

  AccountAssetsInformation({
    required this.round,
    required this.nextToken,
    required this.assetHoldings,
  });

  factory AccountAssetsInformation.empty(String address) {
    return AccountAssetsInformation(
      round: BigInt.zero,
      nextToken: null,
      assetHoldings: [],
    );
  }

  factory AccountAssetsInformation.fromJson(Map<String, dynamic> json) =>
      _$AccountAssetsInformationFromJson(json);

  Map<String, dynamic> toJson() => _$AccountAssetsInformationToJson(this);
}
