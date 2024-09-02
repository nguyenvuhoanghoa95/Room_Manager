import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:room_manager/constants/colors.dart';
import 'package:room_manager/database/database_setting.dart';
import 'package:room_manager/model/house.dart';
import 'package:room_manager/model/expense.dart';
import 'package:room_manager/widgets/appbar/expense_appbar.dart';
import 'package:room_manager/widgets/dialog/expense_dialog.dart';
import 'package:room_manager/widgets/expense/expense_item.dart';
import 'package:room_manager/model/monthyear.dart';

import '../constants/const.dart';
import '../util/date_helper.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({super.key});

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  House? house;
  //List<Expense>? expenses;
  List<Expense>? filteredItems = [];
  MonthYear? _searchMonthYear;
  final _searchController = TextEditingController();
  final _typeExpenseController = SingleSelectController("");
  final _typeOtherExpenseController = TextEditingController();
  final _expenseAmount = TextEditingController();
  final _expenseDate = TextEditingController();

  List<MonthYear> _list =[];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      house = ModalRoute.of(context)!.settings.arguments as House?;
      setState(() {
        final dateHelper = DateHelper.createWithArgument(DateTime.now());
        _list = dateHelper.getListMonthYear();
        filteredItems =  house!.expenses.toList();
        filteredItems!.sort((b,a) => a.expenseDate.compareTo(b.expenseDate));
      });
    });
    _searchController.addListener(_filterItems);
  }

  void _filterItems() {
    setState(() {
      filteredItems = List<Expense>.from(house!.expenses)
          .where((expense) => expense.expenseDate.month == int.parse(_searchMonthYear!.month))
          .toList();
      filteredItems!.sort((b,a) => a.expenseDate.compareTo(b.expenseDate));
    });
  }

  saveAnExpense({Expense? expense}) {
    if (_expenseAmount.text.isNotEmpty &&
        _typeExpenseController.value!.isNotEmpty) {
      if (expense == null) {
        //Add action
        addExpense();
      } else {
        //Edit action
        editExpense(expense);
      }
    }
    setState(() {
      if (_searchMonthYear != null) {
        filteredItems = List<Expense>.from(house!.expenses).where((expense) => expense.expenseDate.month == int.parse(_searchMonthYear!.month))
            .toList();
      } else {
        filteredItems = List<Expense>.from(house!.expenses);
      }
      filteredItems!.sort((b,a) => a.expenseDate.compareTo(b.expenseDate));
    });
    cancel();
  }

  // Create new expense
  createNewExpense() {
    _expenseDate.text = DateTime.now().toString().split(" ")[0];
    showDialog(
      context: context,
      builder: (context) {
        return ExpenseDialog(
          typeExpenseController: _typeExpenseController,
          typeOtherExpenseController: _typeOtherExpenseController,
          expenseAmount: _expenseAmount,
          datePickerController: _expenseDate,
          create: () => saveAnExpense(),
          cancel: () => cancel(),
        );
      },
    );
  }

  addExpense() {
    var newExpense = Expense(_typeExpenseController.value!, _typeOtherExpenseController.text, int.parse(_expenseAmount.text.replaceAll(",", "")),
        DateTime.parse(_expenseDate.text));
    expenseBox.add(newExpense);
    house?.expenses.add(newExpense);
    house?.save();
  }

  editExpense(Expense editExpense) {
    editExpense.expenseDate = DateTime.parse(_expenseDate.text);
    editExpense.typeExpense = _typeExpenseController.value!;
    editExpense.typeOtherExpense = _typeOtherExpenseController.text;
    editExpense.expense = int.parse(_expenseAmount.text.replaceAll(",", ""));
    return editExpense.save();
  }

  //Call edit house dialog
  editDialog(Expense expense) {
    showDialog(
      context: context,
      builder: (context) {
        //Set up data
        _expenseDate.text = expense.expenseDate.toString().split(" ")[0];
        _typeExpenseController.value = expense.typeExpense;
        _typeOtherExpenseController.text = expense.typeOtherExpense;
        _expenseAmount.text = moneyFormat.format(expense.expense).toString();
        //Open dialog
        return ExpenseDialog(
          typeExpenseController: _typeExpenseController,
          typeOtherExpenseController: _typeOtherExpenseController,
          expenseAmount: _expenseAmount,
          datePickerController: _expenseDate,
          edit: () => saveAnExpense(expense: expense),
          cancel: () => cancel(),
        );
      },
    );
  }

  //Clearn data in controller
  cancel() {
    _expenseDate.clear();
    _typeExpenseController.clear();
    _typeOtherExpenseController.clear();
    _expenseAmount.clear();
    Navigator.of(context).pop();
  }

  // Remove room
  removeExpense(int index) {
    var expense = house!.expenses[index];
    expenseBox.delete(expense.key);
    setState(() {
      if (_searchMonthYear != null) {
        filteredItems = List<Expense>.from(house!.expenses).where((expense) => expense.expenseDate.month == int.parse(_searchMonthYear!.month))
          .toList();
      } else {
        filteredItems = List<Expense>.from(house!.expenses);
      }
    });
  }
  // Remove room
  removeAnExpense(Expense expense) {
    expenseBox.delete(expense.key);
    setState(() {
      if (_searchMonthYear != null) {
        filteredItems = List<Expense>.from(house!.expenses).where((expense) => expense.expenseDate.month == int.parse(_searchMonthYear!.month))
            .toList();
      } else {
        filteredItems = List<Expense>.from(house!.expenses);
      }
    });
  }

  //Navigate to invoicePage
  navigateToInvoicePage(Expense expense) {
    Navigator.pushNamed(context, '/expense-page', arguments: expense);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tbBGColor,
      appBar: const ExpenseAppBar(),
      body: Stack(
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Column(
                children: [
                  searchExpense(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredItems?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            margin: const EdgeInsets.only(
                              top: 15,
                            ),
                            child: ExpenseItem(
                                expense: filteredItems![index],
                                navigateToExpensePage: () =>
                                    navigateToInvoicePage(
                                        filteredItems![index]),
                                editExpenseFuntion: () =>
                                    editDialog(filteredItems![index]),
                                removeExpenseFuntion: () => removeAnExpense(filteredItems![index])));
                      },
                    ),
                  )
                ],
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    right: 300,
                  ),
                  child: ElevatedButton(
                    onPressed: () => createNewExpense(),
                    style: ElevatedButton.styleFrom(
                      alignment: Alignment.bottomLeft,
                      minimumSize: const Size(60, 60),
                      elevation: 10,
                    ),
                    child: const Text(
                      '+',
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget searchExpense() {
    return CustomDropdown<MonthYear>(
      hintText: 'Chọn tháng năm',
      items: _list,
      onChanged: (value) {
        _searchMonthYear = value;
        _searchController.text = value.toString();
      },
    );
  }

}
