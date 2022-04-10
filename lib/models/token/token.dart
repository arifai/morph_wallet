class Token {
  final String imageUrl;
  final String ticker;
  final String priceChanges;
  final double price;
  final double balance;
  final double toIDRBalance;

  Token(
    this.imageUrl,
    this.priceChanges,
    this.ticker,
    this.price,
    this.balance,
    this.toIDRBalance,
  );
}
