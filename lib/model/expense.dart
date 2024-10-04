import 'package:hive/hive.dart';

part 'expense.g.dart';

@HiveType(typeId: 0)
class Expense extends HiveObject {
  @HiveField(0)
  double amount;

  @HiveField(1)
  DateTime date;

  @HiveField(2)
  String category;

  @HiveField(3)
  String? description;

  Expense(this.amount, this.date, this.category, {this.description});
}
