class Account {
  final int? id;
  final String? name;
  final String? mnemonic;
  final String? password;
  final double? lamports;
  final double? idrBalance;

  Account(
    this.id,
    this.name,
    this.mnemonic,
    this.password,
    this.lamports,
    this.idrBalance,
  );

  static Account fromJson(Map<String, dynamic> data) {
    return Account(
      data['id'] as int,
      data['name'] as String,
      data['mnemonic'] as String,
      data['password'] as String,
      data['lamports'] as double,
      data['idr_balance'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['mnemonic'] = mnemonic;
    data['password'] = password;
    data['lamports'] = lamports;
    data['idr_balance'] = idrBalance;

    return data;
  }
}
