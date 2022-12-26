import 'package:encrypt/encrypt.dart';
import 'package:morph_wallet/models/wallet_account/keypair.dart';
import 'package:solana/solana.dart' show Ed25519HDKeyPair;

abstract class WalletUtil {
  /// Generate new mnemonic
  List<String> generetaMnemonic();

  /// Encrypt string
  String encryptString(String string);

  /// Decrypt string
  String decryptString(Encrypted encrypted);

  /// Create key pair
  Future<Ed25519HDKeyPair> createKeypair(Keypair keypair);

  /// Load keypair
  // Future<void> loadKeypair();

  /// Import mnemonic
  // Future importWallet(String mnemonic);

  /// Get address
  Future<String?> getAddress();

  /// Get balance
  Future<int> getBalance(String address);
}
