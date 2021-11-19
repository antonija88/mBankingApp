import 'package:mbanking_app/app/models/transaction.dart';

class Account {
  String? id;
  String? IBAN;
  String? amount;
  String? currency;
  List<Transaction>? transactions;
  bool isSelected;

  Account(
      {this.id,
      this.IBAN,
      this.amount,
      this.currency,
      this.transactions,
      this.isSelected = false});

  factory Account.fromJson(Map<String, dynamic> json) {
    var transactionList = json['transactions'] as List;
    List<Transaction> transactions =
        transactionList.map((e) => Transaction.fromJson(e)).toList();

    return Account(
        id: json['id'],
        IBAN: json['IBAN'],
        amount: json['amount'],
        currency: json['currency'],
        transactions: transactions);
  }
}
