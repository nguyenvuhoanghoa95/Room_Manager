import 'package:hive_flutter/hive_flutter.dart';
import 'package:room_manager/model/activity.dart';

import '../database/database_setting.dart';

part 'invoice.g.dart';

@HiveType(typeId: 5, adapterName: "InvoiceAdapter")
class Invoice extends HiveObject {
  @HiveField(0)
  late int newElectricityNumber;

  @HiveField(1)
  late int newWaterNumber;

  @HiveField(2)
  int? currentElectricityNumber;

  @HiveField(3)
  int? currentWaterNumber;

  @HiveField(4)
  late DateTime fromDate;

  @HiveField(5)
  late DateTime toDate;

  @HiveField(6)
  double amountAlreadyPay;

  @HiveField(7)
  double? amountOwed;

  @HiveField(8)
  HiveList<Activity>? activities;

  // Constructor
  Invoice(this.newElectricityNumber, this.newWaterNumber, this.fromDate, this.toDate, this.amountAlreadyPay) {
    if (invoiceBox.isNotEmpty) {
      var lastInvoice = invoiceBox.values.last;
      if (lastInvoice.currentElectricityNumber != null && lastInvoice.currentWaterNumber != null) {
        currentElectricityNumber = lastInvoice.currentElectricityNumber;
        currentWaterNumber = lastInvoice.currentWaterNumber;
      }
      amountAlreadyPay = lastInvoice.amountAlreadyPay;
    }
    activities = HiveList(invoiceBox);
  }
}
