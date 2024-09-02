import 'package:hive_flutter/hive_flutter.dart';
import 'package:room_manager/model/room.dart';

import '../database/database_setting.dart';

part 'invoice.g.dart';

@HiveType(typeId: 5, adapterName: "InvoiceAdapter")
class Invoice extends HiveObject {
  @HiveField(0)
  int? newElectricityNumber;

  @HiveField(1)
  int? newWaterNumber;

  @HiveField(2)
  int? currentElectricityNumber;

  @HiveField(3)
  int? currentWaterNumber;

  @HiveField(4)
  DateTime? invoiceCreateDate;

  @HiveField(5)
  int? amountAlreadyPay;

  @HiveField(6)
  String? note;
  
  @HiveField(7)
  int? surcharge;

  @HiveField(8)
  int? totalAmount;

  @HiveField(9)
  int? wifiAmount;

  @HiveField(10)
  int? electAmount;

  @HiveField(11)
  int? waterAmount;

  @HiveField(12)
  int? debitAmount;

  Invoice(this.newElectricityNumber, this.newWaterNumber, this.invoiceCreateDate, this.amountAlreadyPay , this.surcharge);

  // Constructor
  Invoice.createInvoice(Room room) {
    invoiceCreateDate = DateTime.now();
    wifiAmount = 0;
    if (room.invoices.isNotEmpty) {
      amountAlreadyPay = room.invoices.last.amountAlreadyPay;
      currentElectricityNumber = room.invoices.last.newElectricityNumber;
      currentWaterNumber = room.invoices.last.newWaterNumber;
      wifiAmount = room.invoices.last.wifiAmount;
    } else {
      currentElectricityNumber = room.currentElectricityNumber;
      currentWaterNumber = room.currentWaterNumber;
    }
  }

  getRoom() {
    return roomBox.values.where((room) => room.invoices.contains(this)).first;
  }
}
