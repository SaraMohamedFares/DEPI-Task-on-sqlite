import 'package:depi/ExpenseTracker/add_EditScreen.dart';
import 'package:depi/ExpenseTracker/expenseModel.dart';
import 'package:depi/ExpenseTracker/sqflite.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final List<Map<String, dynamic>> _expenses = [
  //   {"date": DateTime.now(), "amount": 50, "category": "Food", "note": "Lunch"},
  //   {
  //     "date": DateTime.now(),
  //     "amount": 100,
  //     "category": "Transport",
  //     "note": "Taxi",
  //   },
  // ];

  List<ExpenseModel> expenses = [];
  void initState() {
    super.initState();
    _loadExpenses();
  }

  Future<void> _loadExpenses() async {
    final data = await SqliteDatabase.getAllExpense();
    setState(() {
      expenses = data;
    });
  }

  void addOrEditExpense({ExpenseModel? expense, int? index}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AddEditScreen(expense: expense)),
    );

    if (result != null) {
      setState(() {
        if (index == null) {
          SqliteDatabase.insertNewExpense(result);
        } else {
          SqliteDatabase.updateExpense(result);
        }
        _loadExpenses();
      });
    }
  }

  void _deleteExpense(ExpenseModel expense) {
    setState(() {
      SqliteDatabase.deleteExpense(expense);
      _loadExpenses();
    });
  }

  void _clearAll() {
    setState(() {
      SqliteDatabase.clear();
      _loadExpenses();
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Tracker"),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: _clearAll,
            tooltip: "Clear All",
          ),
        ],
      ),
      body: expenses.isEmpty
          ? Center(child: Text("No expenses yet."))
          : ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          final expense = expenses[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text("\$${expense.amount}",overflow:TextOverflow.ellipsis ,),
                ),
              ),
              title: Text(expense.category),
              subtitle: Text(
                "${expense.note} - ${expense.date.toString().split(' ')[0]}",
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () =>
                        addOrEditExpense(expense: expense, index: index),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteExpense(expense),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => addOrEditExpense(),
      ),
    );
  }
}