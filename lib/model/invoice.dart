import 'package:hive/hive.dart';

part 'invoice.g.dart';

@HiveType(typeId: 5 , adapterName: "InvoiceAdapter" ) 
class Invoice extends HiveObject {
  static int _lastId = 0; // Static variable to keep track of last used ID

  @HiveField(0)
  late int id;

  @HiveField(1)
  late int newElectricityNumber;

  @HiveField(2)
  late int waterNumber;

  @HiveField(3)
  late int roomId;

  @HiveField(4)
  late DateTime fromDate;

  @HiveField(5)
  late DateTime toDate;

  @HiveField(6)
  late double amountAlreadyPay;

  @HiveField(7)
  late double amountOwed;

  @HiveField(8)
  late String roomActivityString;

  // Constructor
  Invoice(this.newElectricityNumber, this.waterNumber, this.roomId, this.fromDate, this.toDate, this.amountAlreadyPay, this.amountOwed, this.roomActivityString){
    id = ++_lastId; // Increment the last used ID and assign it to the current instance
  }
}