import 'package:bip39/bip39.dart' as bip39;

class MnemonicUtil {
  /// Generate mnemonic for a new wallet.
  static String generate() {
    return bip39.generateMnemonic();
  }

  /// Validate mnemonic
  static bool validate(String mnemonic) {
    return bip39.validateMnemonic(mnemonic);
  }
}
