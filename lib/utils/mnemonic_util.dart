import 'package:bip39/bip39.dart' as bip39;

class MnemonicUtil {
  /// Generate mnemonic for a new wallet.
  static List<String> generate() {
    var mnemonic = bip39.generateMnemonic();

    // Hasil bip39.generateMnemonic() akan di-split agar berbentuk List<String>.
    // Ini karena menyesuaikan kebutuhan yang ada di MnemonicWidget()
    return mnemonic.split(' ');
  }

  /// Validate mnemonic
  static bool validate(List<String> mnemonic) {
    return bip39.validateMnemonic(mnemonic.join(' '));
  }
}
