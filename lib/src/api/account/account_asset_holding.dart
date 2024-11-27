import 'package:algorand_dart/src/api/asset/asset.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account_asset_holding.g.dart';

@JsonSerializable(fieldRename: FieldRename.kebab)
class AccountAssetHolding {
  @JsonKey(name: 'asset-holding')
  final AssetHolding assetHolding;

  @JsonKey(name: 'asset-params')
  final AssetParameters? assetParams;

  AccountAssetHolding({
    required this.assetHolding,
    this.assetParams,
  });

  factory AccountAssetHolding.empty(String address) {
    return AccountAssetHolding(
      assetHolding: AssetHolding(
        amount: BigInt.from(0),
        assetId: BigInt.from(0),
        creator: null,
        isFrozen: false,
      ),
      assetParams: null,
    );
  }

  factory AccountAssetHolding.fromJson(Map<String, dynamic> json) =>
      _$AccountAssetHoldingFromJson(json);

  Map<String, dynamic> toJson() => _$AccountAssetHoldingToJson(this);
}
