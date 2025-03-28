class UserBalance {
  Map<String, dynamic> rawUserBalance;

  late double balance;
  late bool init;
  late double income;
  late double expenses;

  UserBalance({required this.rawUserBalance}) {
    balance = rawUserBalance["balance"];
    init = rawUserBalance["init"] == 0 ? false : true;
    income = rawUserBalance["income"];
    expenses = rawUserBalance["expenses"];
  }
}
