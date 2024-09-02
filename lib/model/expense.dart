import 'package:hive_flutter/hive_flutter.dart';

part 'expense.g.dart';

@HiveType(typeId: 6, adapterName: "ExpenseAdapter")
class Expense extends HiveObject{

  @HiveField(0)
  late String typeExpense;

  @HiveField(1)
  late String typeOtherExpense;

  @HiveField(2)
  late int expense;

  @HiveField(3)
  late DateTime expenseDate;

  // Constructor
  Expense(this.typeExpense, this.typeOtherExpense, this.expense, this.expenseDate) ;
}
