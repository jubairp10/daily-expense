import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'model/expense.dart';

class ExpenseProvider with ChangeNotifier {
  Box<Expense> _expenseBox = Hive.box<Expense>('expenses');

  List<Expense> get expenses => _expenseBox.values.toList();

  double getTotalExpenses() {
    return _expenseBox.values.fold(0, (sum, item) => sum + item.amount);
  }

  Map<String, double> getCategoryExpenses() {
    Map<String, double> categoryTotals = {};
    for (var expense in _expenseBox.values) {
      categoryTotals.update(
        expense.category,
            (value) => value + expense.amount,
        ifAbsent: () => expense.amount,
      );
    }
    return categoryTotals;
  }

  void addExpense(Expense expense) {
    _expenseBox.add(expense);
    notifyListeners();
  }

  void deleteExpense(int index) {
    _expenseBox.deleteAt(index);
    notifyListeners();
  }

  void updateExpense(int index, Expense updatedExpense) {
    _expenseBox.putAt(index, updatedExpense);
    notifyListeners();
  }
}
