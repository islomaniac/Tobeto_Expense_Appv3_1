import 'package:expenseappv3_1/data/expense_data.dart';
import 'package:expenseappv3_1/models/expense.dart';
import 'package:expenseappv3_1/widgets/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage(this.refresh, {Key? key}) : super(key: key);

  final int refresh;

  @override
  // ignore: library_private_types_in_public_api
  _ExpensesPageState createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  List<Expense> listExpense = listExpenseItem();

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_print
    print("testExpensesPage");

    if (widget.refresh >= 0) {
      // ignore: avoid_print
      print("test");
      listExpense = listExpenseItem();
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Grafik bölümü"),
          SizedBox(
            height: 400,
            child: ListView.builder(
              itemCount: listExpense.length,
              itemBuilder: (context, index) {
                return ExpenseItem(listExpense[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
