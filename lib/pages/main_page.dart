import 'package:expenseappv3_1/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expenseappv3_1/pages/expenses_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int refreshNumber = 0;

  ExpensesPage expensesPage = const ExpensesPage(0);

  void setStateAndRefresh(int number) {
    setState(() {
      refreshNumber = number;
      expensesPage = ExpensesPage(refreshNumber);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense App"),
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepPurpleAccent,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return NewExpense(setStateAndRefresh);
                },
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: expensesPage,
    );
  }
}
