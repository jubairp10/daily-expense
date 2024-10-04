
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
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _username = ''; // Variable to hold the username

  @override
  void initState() {
    super.initState();
    _getUsername(); // Get the username when the screen initializes
  }

  // Function to retrieve the username from SharedPreferences
  Future<void> _getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? 'User'; // Default to 'User' if not found
    });
  }
  @override
  Widget build(BuildContext context) {

    // Open the 'expenses' box
    var expenseBox = Hive.box<Expense>('expenses');

    // Calculate total expenses by summing all the expense amounts
    double totalExpenses = expenseBox.values.fold(0, (sum, expense) => sum + expense.amount);

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
              Text(
                "Total Expenses: \$${totalExpenses.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              _buildActionButton(
                context,
                'Add Expense',
                Icons.add,
                AddExpenseScreen(),
              ),
              SizedBox(height: 10),
              _buildActionButton(
                context,
                'View Expenses',
                Icons.monetization_on_rounded,
                ExpenseListScreen(),
              ),
              SizedBox(height: 10),
              _buildActionButton(
                context,
                'View Summary',
                Icons.pie_chart,
                SummaryScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, String label, IconData icon, Widget route) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => route));
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
