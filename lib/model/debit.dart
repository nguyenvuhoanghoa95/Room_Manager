import 'package:hive/hive.dart';

part 'debit.g.dart';

@HiveType(typeId: 4 , adapterName: "DebitAdapter") 
class Debit extends HiveObject {

  @HiveField(0)
  int? amount;

  @HiveField(1)
  bool? status;

  Debit(this.amount,this.status);
}