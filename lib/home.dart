import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'addexpense.dart';
import 'expense_list.dart';
import 'fichart.dart';
import 'model/expense.dart';


class HomeScreen extends StatelessWidget {
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
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Image(image: AssetImage('assets/img/budget (1).png'),height: 50,width: 50,),
          )
          ],),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Total Expenses: \$${totalExpenses.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
      
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddExpenseScreen()));
                },
                child: Container(
                  height: 100,
                  width: 160,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                  color: Colors.teal[200]),
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add,color: Colors.white,),
                      Text('Add Expense',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),)
                    ],
                  ) ,
                ),
              ),
              SizedBox(height: 10,),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ExpenseListScreen()));
                },
                child: Container(
                  height: 100,
                  width: 160,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                      color: Colors.teal[200]),
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.monetization_on_rounded,color: Colors.white,),
                      Text('View Expense',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,))
                    ],
                  ) ,
                ),
              ),
              SizedBox(height: 10,),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SummaryScreen()));
                },
                child: Container(
                  height: 100,
                  width: 160,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                      color: Colors.teal[200]),
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.pie_chart,color: Colors.white,),
                      Text('View Summery',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,))
                    ],
                  ) ,
                ),
              ),
      

            ],
          ),
        ),
      ),
    );
  }
}
