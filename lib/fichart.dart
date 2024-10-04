import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hive/hive.dart';
import 'dart:math'; // Import for random color generation
import 'model/expense.dart';

class SummaryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var expenseBox = Hive.box<Expense>('expenses');
    List<PieChartSectionData> pieChartSections = [];

    // Check if there are expenses in the box
    if (expenseBox.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text("Expense Summary")),
        body: Center(
          child: Text(
            "No expenses to display",
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    // Adding each expense as a separate section in the pie chart
    for (var expense in expenseBox.values) {
      print('Category: ${expense.category}, Amount: ${expense.amount}');
      pieChartSections.add(
        PieChartSectionData(
          value: expense.amount, // Display each expense amount as a separate section
          title: '${expense.category}: \$${expense.amount.toStringAsFixed(2)}', // Show category and amount
          radius: 150,
          color: _getRandomColor(), // Random color for each expense
          titleStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Expense Summary")),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: PieChart(
            PieChartData(
              sections: pieChartSections,
              centerSpaceRadius: 40,
              sectionsSpace: 4, // Space between sections
              borderData: FlBorderData(show: false),
            ),
          ),
        ),
      ),
    );
  }

  // Function to generate random colors for each section of the pie chart
  Color _getRandomColor() {
    Random random = Random(); // Create random number generator
    return Color((random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0); // Generate random color
  }
}
