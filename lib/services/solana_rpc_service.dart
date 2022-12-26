import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:solana/solana.dart';

class SolanaRpcService {
  static final SolanaRpcService _singleton = SolanaRpcService._internal();

  factory SolanaRpcService() => _singleton;

  SolanaRpcService._internal();

  SolanaClient get _solanaClient => SolanaClient(
        rpcUrl: Uri.parse('${dotenv.env['SOLANA_DEVNET_RPC']}'),
        websocketUrl: Uri.parse('${dotenv.env['SOLANA_DEVNET_WS']}'),
      );

  RpcClient get rpcClient => _solanaClient.rpcClient;
}
