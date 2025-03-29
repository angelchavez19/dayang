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

class UserCategory {
  Map<String, dynamic> rawCategory;

  late int id;
  late String name;

  UserCategory({required this.rawCategory}) {
    id = rawCategory["id"];
    name = rawCategory["name"];
  }
}

class UserTransaction {
  Map<String, dynamic> rawTransaction;

  late int id;
  late String description;
  late double amount;
  late DateTime date;
  late double currentBalance;
  late String categoryName;

  UserTransaction({required this.rawTransaction}) {
    id = rawTransaction["id"];
    description = rawTransaction["description"];
    amount = rawTransaction["amount"];
    date = DateTime.parse(rawTransaction["date"]);
    currentBalance = rawTransaction["current_balance"];
    categoryName = rawTransaction["category_name"];
  }
}
