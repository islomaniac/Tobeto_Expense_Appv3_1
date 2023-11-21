import 'package:expenseappv3_1/data/expense_data.dart';
import 'package:expenseappv3_1/data/refresh_data.dart';
import 'package:expenseappv3_1/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  const NewExpense(this.refreshPage, {super.key});
  final Function(int number) refreshPage;

  @override
  // ignore: library_private_types_in_public_api
  _NewExpenseState createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _expenseNameController = TextEditingController();
  final _expensePriceControler = TextEditingController();
  String dateText = "Tarih seçiniz";
  DateTime? _selectedDate;
  Category _selectedCategory = Category.work;
  Future<void> _showDatePicker(BuildContext context) async {
    DateTime today = DateTime.now();
    DateTime oneYearAgo = DateTime(today.year - 1, today.month, today.day);
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate == null ? today : _selectedDate!,
        firstDate: oneYearAgo,
        lastDate: today);
    setState(() {
      if (selectedDate == null) {
      } else {
        // String fixedDate = DateFormat.yMd().format(selected);
        _selectedDate = selectedDate;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int refreshNumber = 0;
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _expenseNameController,
              maxLength: 50,
              decoration: const InputDecoration(labelText: "Harcama adı"),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _expensePriceControler,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: "Harcama miktarı", prefixText: "₺"),
                  ),
                ),
                IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () async {
                      await _showDatePicker(context);
                    },
                    icon: const Icon(Icons.calendar_month)),
                Text(_selectedDate == null ? "Tarih Seçiniz" : DateFormat.yMd().format(_selectedDate!)),
              ],
            ),
            Row(
              children: [
                DropdownButton(
                    value: _selectedCategory,
                    items: Category.values.map((category) {
                      return DropdownMenuItem(value: category, child: Text(category.name));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        if (value != null) _selectedCategory = value;
                      });
                      // ignore: avoid_print
                      print(value);
                    })
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Kapat")),
                ElevatedButton(
                    onPressed: () {
                      if (((_expenseNameController.text != '') &&
                          (_expensePriceControler.text != '') &&
                          (_selectedDate != null))) {
                        var expensePrice = _expensePriceControler.text.replaceAll(r",", ".");
                        var expensePrice0 = double.tryParse(expensePrice);
                        if (expensePrice0 is double) {
                          addExpenseItem(
                            _expenseNameController.text,
                            expensePrice0,
                            _selectedDate!,
                            _selectedCategory,
                          );
                          Refresh.refresh();

                          refreshNumber++;
                          widget.refreshPage(refreshNumber);
                        }
                      } else {}
                      // print(
                      //     "Kaydedilen değer: ${_expenseNameController.text} ${_expensePriceControler.text}, $dateText");
                    },
                    child: const Text("Ekle")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
