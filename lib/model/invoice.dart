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
  DateTime? fromDate;

  @HiveField(5)
  DateTime? toDate;

  @HiveField(6)
  double? amountAlreadyPay;

  @HiveField(7)
  double? amountOwed;

  @HiveField(8)
  HiveList<Activity>? activities;

  Invoice(this.newElectricityNumber, this.newWaterNumber, this.fromDate, this.toDate, this.amountAlreadyPay) {
    activities = HiveList(roomActivitysBox);
  }

  // Constructor
  Invoice.createInvoice(Room room) {
    if (invoiceBox.isNotEmpty) {
      var lastInvoice = roomBox.get(room)?.invoices.last;
      if (lastInvoice != null) {
        if (lastInvoice.currentElectricityNumber != null &&
            lastInvoice.currentWaterNumber != null) {
          currentElectricityNumber = lastInvoice.currentElectricityNumber;
          currentWaterNumber = lastInvoice.currentWaterNumber;
        }
        amountAlreadyPay = lastInvoice.amountAlreadyPay;
      }
    }
    activities = HiveList(roomActivitysBox);
  }
}
