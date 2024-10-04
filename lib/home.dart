import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'addexpense.dart';
import 'expense_list.dart';
import 'fichart.dart';
import 'login.dart';
import 'model/expense.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _username = '';
  double totalExpenses = 0.0; // To hold the total expenses

  @override
  void initState() {
    super.initState();
    _getUsername(); // Get the username when the screen initializes
    _calculateTotalExpenses(); // Calculate total expenses on screen load
  }

  // Function to retrieve the username from SharedPreferences
  Future<void> _getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? 'User'; // Default to 'User' if not found
    });
  }

  // Function to calculate the total expenses
  void _calculateTotalExpenses() {
    var expenseBox = Hive.box<Expense>('expenses');
    setState(() {
      totalExpenses = expenseBox.values.fold(0, (sum, expense) => sum + expense.amount);
    });
  }

  // Call this function to refresh the total expenses when returning from another screen
  Future<void> _refreshTotalExpenses() async {
    _calculateTotalExpenses(); // Recalculate total expenses
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[100],
          centerTitle: true,
          title: Text("Expense Tracker"),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                // Clear user data from SharedPreferences on logout
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.remove('username');
                await prefs.remove('password');

                // Navigate back to LoginScreen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Image(
                image: AssetImage('assets/img/budget (1).png'),
                height: 50,
                width: 50,
              ),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome, $_username!", // Display the username
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                "Total Expenses: \$${totalExpenses.toStringAsFixed(2)}", // Show updated total expenses
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              _buildActionButton(context, 'Add Expense', Icons.add, AddExpenseScreen(), _refreshTotalExpenses),
              SizedBox(height: 10),
              _buildActionButton(context, 'View Expenses', Icons.monetization_on_rounded, ExpenseListScreen(), _refreshTotalExpenses),
              SizedBox(height: 10),
              _buildActionButton(context, 'View Summary', Icons.pie_chart, SummaryScreen(), _refreshTotalExpenses),
            ],
          ),
        ),
      ),
    );
  }

  // Function to build the action buttons (Add Expense, View Expenses, etc.)
  Widget _buildActionButton(BuildContext context, String label, IconData icon, Widget route, Function onReturn) {
    return InkWell(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => route),
        );
        onReturn(); // Refresh total expenses when returning to the home screen
      },
      child: Container(
        height: 100,
        width: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.teal[200],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            Text(
              label,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
