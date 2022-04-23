class TransactionDetail {
  final String origin;
  final String destination;
  final double amount;
  final bool receivedOrNot;
  final String programId;
  final int blockTime;

  TransactionDetail(
    this.origin,
    this.destination,
    this.amount,
    this.receivedOrNot,
    this.programId,
    this.blockTime,
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['origin'] = origin;
    data['destination'] = destination;
    data['amount'] = amount;
    data['received_or_not'] = receivedOrNot;
    data['program_id'] = programId;
    data['block_time'] = blockTime;

    return data;
  }
}
