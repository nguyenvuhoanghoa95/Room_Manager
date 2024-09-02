import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:room_manager/constants/colors.dart';
import 'package:room_manager/model/expense.dart';

import '../../constants/const.dart';
class ExpenseItem extends StatelessWidget {

  final Expense expense;

  final VoidCallback removeExpenseFuntion;
  final VoidCallback editExpenseFuntion;
  final VoidCallback navigateToExpensePage;

  const ExpenseItem(
      {super.key,
        required this.expense,
        required this.editExpenseFuntion,
        required this.removeExpenseFuntion,
        required this.navigateToExpensePage});



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: ListTile(
          onTap: editExpenseFuntion,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          tileColor: Colors.white,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${(expense.typeOtherExpense == "")? expense.typeExpense:expense.typeOtherExpense}: ${numberFormat.format(expense.expense)}",
                style: const TextStyle(
                  fontSize: 18,
                  color: tdRed,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Ngày chi : ${DateFormat("dd-MM-yyy").format(expense.expenseDate)}",
                style: const TextStyle(
                  fontSize: 15,
                  color: tbBlack,
                ),
              ),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PopupMenuButton(
                position: PopupMenuPosition.under,
                itemBuilder: (context) => [
                  PopupMenuItem(
                    onTap: removeExpenseFuntion,
                    child: const Text('Xoá chi phi'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
