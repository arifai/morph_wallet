import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:morph_wallet/models/transaction/transaction_detail.dart';
import 'package:solana/solana.dart' show SolanaClient;

class WalletAccount {
  final String name;
  final String mnemonic;
  final String password;
  late String address;
  late double balance;
  late double idrBalance;
  late Map<String, dynamic> tokens;
  late List<TransactionDetail> transactionDetail;
  late SolanaClient solanaClient;

  WalletAccount(
    this.name,
    this.mnemonic,
    this.password,
  ) : super() {
    solanaClient = SolanaClient(
      rpcUrl: Uri.parse(dotenv.env['SOLANA_MAINNET_RPC'].toString()),
      websocketUrl: Uri.parse(dotenv.env['SOLANA_MAINNET_WS'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['name'] = name;
    data['address'] = address;
    data['mnemonic'] = mnemonic;
    data['transaction_detail'] =
        transactionDetail.map((tx) => tx.toJson()).toList();

    return data;
  }
}
