import 'package:morph_wallet/models/transaction/transaction_detail.dart';

class UnsupportedTransaction extends TransactionDetail {
  UnsupportedTransaction(int blockTime)
      : super('Unknown', 'Unknown', 0.0, false, 'Unknown', blockTime);
}
