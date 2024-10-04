import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import 'model/expense.dart'; // For date formatting

class AddExpenseScreen extends StatefulWidget {
  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController(); // Controller for the date
  String _selectedCategory = "Food"; // Default category
  DateTime _selectedDate = DateTime.now(); // Default to today's date

  @override
  void initState() {
    super.initState();
    // Set the date field to today's date
    _dateController.text = DateFormat('yyyy-MM-dd').format(_selectedDate);
  }

  // Function to open the Date Picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(_selectedDate); // Update date field
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Expense")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black)),
                  labelText: "Amount"),
            ),
            SizedBox(height: 10,),
            Container(height: 50,

              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.blueAccent),
              child: DropdownButton<String>(borderRadius: BorderRadius.circular(10),

                dropdownColor: Colors.redAccent[200],
                focusColor: Colors.red,
                value: _selectedCategory,
                items: ["Food", "Transport", "Entertainment", "Others"].map((category) {
                  return DropdownMenuItem(child: Text(category), value: category);
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
              ),
            ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: () => _selectDate(context), // Opens the date picker
              child: AbsorbPointer(
                child: TextFormField(
                  controller: _dateController, // Use the date controller
                  decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black)),
                    labelText: "Date",
                    suffixIcon: Icon(Icons.calendar_today), // Calendar icon
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black)),
                  labelText: "Description"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                var newExpense = Expense(
                  double.parse(_amountController.text),
                  _selectedDate, // Store the selected date
                  _selectedCategory,
                  description: _descriptionController.text,
                );
                Hive.box<Expense>('expenses').add(newExpense); // Add the expense to Hive
                Navigator.pop(context);
              },
              child: Text("Add Expense"),
            ),
          ],
        ),
      ),
    );
  }
}
