class StatesModel {
  late int total;
  late int accepted;
  late int noAccepted;
  late int completed;
  late int cancelled;
  late int disputed;
  late double balance;
  late double depositAmount;
  late double withdrawAmount;
  late double depositAmountPending;
  late double withdrawAmountPending;
  late double milestoneAmount;
  late List<dynamic> latestTransactions;

  StatesModel(
      {required this.total,
      required this.accepted,
      required this.cancelled,
      required this.completed,
      required this.depositAmount,
      required this.depositAmountPending,
      required this.balance,
      required this.disputed,
      required this.latestTransactions,
      required this.milestoneAmount,
      required this.noAccepted,
      required this.withdrawAmount,
      required this.withdrawAmountPending});

  static formJson(dynamic data) {
    return StatesModel(
        balance: double.parse(data['balance']),
        total: int.tryParse(data['total'].toString()) ?? 0,
        accepted: int.tryParse(data['accepted'].toString()) ?? 0,
        cancelled: int.tryParse(data['cancelled'].toString()) ?? 0,
        completed: int.tryParse(data['completed'].toString()) ?? 0,
        milestoneAmount:
            double.tryParse(data['milestoneAmount'].toString()) ?? 0,
        depositAmount: double.tryParse(data['depositAmount'].toString()) ?? 0,
        depositAmountPending:
            double.tryParse(data['depositAmountPending'].toString()) ?? 0,
        disputed: int.tryParse(data['disputed'].toString()) ?? 0,
        latestTransactions: data['latestTransactions'],
        noAccepted: int.tryParse(data['noAccepted'].toString()) ?? 0,
        withdrawAmount: double.tryParse(data['withdrawAmount'].toString()) ?? 0,
        withdrawAmountPending:
            double.tryParse(data['withdrawAmountPending'].toString()) ?? 0);
  }

  updateData(dynamic data) {
    balance = double.parse(data['balanceAmount'].toString());
    depositAmount = double.parse(data['depositAmount'].toString());
    withdrawAmount = double.parse(data['withdrawAmount'].toString());
    depositAmountPending =
        double.parse(data['depositAmountPending'].toString());
    withdrawAmountPending =
        double.parse(data['withdrawAmountPending'].toString());
    milestoneAmount = double.parse(data['milestoneAmount'].toString());
  }
}
