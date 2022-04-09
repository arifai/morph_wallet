class Account {
  final String name;
  final String publicKey;
  final Mnemonic mnemonic;
  final String password;
  // SOL balance
  final double lamports;
  final double idrBalance;

  Account({
    required this.name,
    required this.publicKey,
    required this.mnemonic,
    required this.password,
    this.lamports = 0,
    this.idrBalance = 0,
  });
}

class Mnemonic {
  final String mnemonic;

  Mnemonic(this.mnemonic);
}
