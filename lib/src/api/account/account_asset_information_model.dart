import 'package:algorand_dart/src/api/asset/asset.dart';
import 'package:algorand_dart/src/utils/serializers/serializers.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account_asset_information_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.kebab)
class AccountAssetInformation {
  /// Round at which the results were computed.
  @JsonKey(name: 'round')
  @BigIntSerializer()
  final BigInt round;

  /// Used for pagination, when making another request provide this token
  /// with the next parameter.
  @JsonKey(name: 'next-token')
  final String? nextToken;

  /// list of assets held by the address
  @JsonKey(name: 'asset-holding')
  final AssetHolding assetHolding;

  AccountAssetInformation({
    required this.round,
    required this.nextToken,
    required this.assetHolding,
  });

  factory AccountAssetInformation.empty() {
    return AccountAssetInformation(
      round: BigInt.zero,
      nextToken: null,
      assetHolding: AssetHolding.empty(),
    );
  }

  factory AccountAssetInformation.fromJson(Map<String, dynamic> json) =>
      _$AccountAssetInformationFromJson(json);

  Map<String, dynamic> toJson() => _$AccountAssetInformationToJson(this);
}
