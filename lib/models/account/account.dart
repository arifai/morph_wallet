class Account {
  final String name;
  final String publicKey;
  final Mnemonic mnemonic;
  final String password;
  // SOL balance
  final double lamports;
  final double idrBalance;

  Account(
    this.name,
    this.publicKey,
    this.mnemonic,
    this.password,
    this.lamports,
    this.idrBalance,
  );
}

class Mnemonic {
  final String mnemonic;

  Mnemonic(this.mnemonic);
}
