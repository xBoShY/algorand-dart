import 'package:algorand_dart/src/abi/transaction_signer.dart';
import 'package:algorand_dart/src/crypto/multi_signature_address.dart';
import 'package:algorand_dart/src/models/models.dart';

class MultiSigSigner implements TxnSigner {
  final Account account;
  final MultiSigAddress multiSigAddress;

  MultiSigSigner({
    required this.account,
    required this.multiSigAddress,
  });

  /// Get the public, human readable address of the account,
  /// also known as the Algorand address.
  String get publicAddress => multiSigAddress.toAddress().encodedAddress;

  @override
  Future<List<SignedTransaction>> signTransactions(
    List<RawTransaction> transactions,
    List<int> indicesToSign,
  ) async {
    final signedTxns = <SignedTransaction>[];
    for (var i = 0; i < indicesToSign.length; i++) {
      final txn = transactions[indicesToSign[i]];
      final signedTxn = await multiSigAddress.sign(
        account: account,
        transaction: txn,
      );
      signedTxns.add(signedTxn);
    }

    return signedTxns;
  }
}
