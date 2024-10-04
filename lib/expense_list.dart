import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';


import 'model/expense.dart'; // For date formatting

class ExpenseListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var expenseBox = Hive.box<Expense>('expenses');

    return Scaffold(
      appBar: AppBar(title: Text("Expense List")),
      body: ValueListenableBuilder(
        valueListenable: expenseBox.listenable(),
        builder: (context, Box<Expense> box, _) {
          if (box.isEmpty) {
            return Center(child: Text("No expenses added."));
          } else {
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                var expense = box.getAt(index);
                return Card(
                  color: Colors.blueGrey[100],
                  child: ListTile(
                    title: Text('${expense!.category} - \$${expense.amount.toStringAsFixed(2)}'),
                    subtitle: Text(
                        '${DateFormat('yyyy-MM-dd').format(expense.date)} \n${expense.description ?? ''}'
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // Handle edit logic here
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            box.deleteAt(index); // Delete the expense from Hive
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );

  }
  Color _getRandomColor() {
    Random random = Random(); // Create random number generator
    return Color((random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0); // Generate random color
  }
}
