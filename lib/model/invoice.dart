import 'package:hive_flutter/hive_flutter.dart';
import 'package:room_manager/model/activity.dart';
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
  

 @HiveField(7)
  int? surcharge;

  @HiveField(8)
  int? amountOwed;

  
  @HiveField(9)
  int? totalAmount;

  @HiveField(10)
  HiveList<Activity>? activities;

  Invoice(this.newElectricityNumber, this.newWaterNumber, this.invoiceCreateDate, this.amountOwed, this.amountAlreadyPay , this.surcharge) {
    activities = HiveList(roomActivitysBox);
  }

  // Constructor
  Invoice.createInvoice(Room room) {
    if (invoiceBox.isNotEmpty) {
      if (room.currentElectricityNumber != 0 && room.currentWaterNumber != 0) { 
          currentElectricityNumber = room.currentElectricityNumber;
          currentWaterNumber = room.currentWaterNumber;
          amountAlreadyPay = room.invoices.last.amountAlreadyPay;
      }
    }
    activities = HiveList(roomActivitysBox);
  }

}
