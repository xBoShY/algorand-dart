import 'package:algorand_dart/algorand_dart.dart';
import 'package:algorand_dart/src/api/account/account_algod_service.dart';
import 'package:dio/dio.dart';

class AccountsAlgodApi {
  final AlgorandApi _api;
  final AccountAlgodService _service;

  AccountsAlgodApi({
    required AlgorandApi api,
    required AccountAlgodService service,
  })  : _api = api,
        _service = service;

  /// Get the account information of the given address.
  /// Given a specific account public key, this call returns the accounts
  /// status, balance and spendable amounts
  ///
  /// Throws an [AlgorandException] if there is an HTTP error.
  /// Returns the account information.
  Future<AccountInformation> getAccountByAddress(
    String address, {
    Exclude? exclude,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return _api.execute<AccountInformation>(
      () => _service.getAccountByAddress(
        address: address,
        exclude: exclude,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      ),
    );
  }

  /// Lookup assets information by a given account id.
  ///
  /// Throws an [AlgorandException] if there is an HTTP error.
  /// Returns the assets information for the given account id.
  Future<AccountAssetsInformation> getAssetsByAddress(
    String address, {
    String? nextToken,
    int? perPage,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return _api.execute<AccountAssetsInformation>(
      () => _service.getAssetsByAddress(
        address: address,
        limit: perPage,
        next: nextToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      ),
    );
  }

  /// Lookup the asset information by a given account id.
  ///
  /// Throws an [AlgorandException] if there is an HTTP error.
  /// Returns the assets information for the given account id.
  Future<AccountAssetInformation> getAssetByAddress(
    String address,
    BigInt asset, {
    String? nextToken,
    int? perPage,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return _api.execute<AccountAssetInformation>(
      () => _service.getAssetByAddress(
        address: address,
        asset: asset,
        limit: perPage,
        next: nextToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      ),
    );
  }
}
