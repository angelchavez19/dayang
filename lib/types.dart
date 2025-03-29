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

class UserTransaction {
  Map<String, dynamic> rawTransaction;

  late int id;
  late String description;
  late double amount;
  late DateTime date;
  late double currentBalance;

  UserTransaction({required this.rawTransaction}) {
    id = rawTransaction["id"];
    description = rawTransaction["description"];
    amount = rawTransaction["amount"];
    date = DateTime.parse(rawTransaction["date"]);
    currentBalance = rawTransaction["current_balance"];
  }
}
