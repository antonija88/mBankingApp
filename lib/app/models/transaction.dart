import 'dart:convert';

class Transaction {
  String? id;
  DateTime? date;
  String? description;
  String? amount;
  String? type;

  Transaction({this.id, this.date, this.description, this.amount, this.type});

  factory Transaction.fromJson(Map<String, dynamic> json) {
    String dateFromJson = json['date'];
    String years = dateFromJson.substring(6, 10);
    String month = dateFromJson.substring(3, 5);
    String days = dateFromJson.substring(0, 2);
    String date = years + '-' + month + '-' + days;
    DateTime dt = DateTime.parse(date);

    return Transaction(
      id: json['id'],
      date: dt,
      description: json['description'],
      amount: json['amount'],
      type: json['type'],
    );
  }
}
