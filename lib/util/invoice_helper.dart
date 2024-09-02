import 'package:room_manager/constants/const.dart';
import 'package:room_manager/model/house.dart';
import 'package:room_manager/model/invoice.dart';
import 'package:room_manager/model/room.dart';
import 'package:room_manager/util/invoice_aguments.dart';

import 'date_helper.dart';

class InvoiceHelper {
  House? house;
  Invoice? invoice;
  Room? room;
  InvoiceArguments? invoiceArguments;
  List costList = [];
  List debList = [];

  InvoiceHelper();

  InvoiceHelper.createWithArgument(this.invoiceArguments) {
    house = invoiceArguments?.house;
    room = invoiceArguments?.room;
    invoice = invoiceArguments?.invoice;
  }

  getPreviousInvoice() {
    if (room!.invoices.isEmpty || room!.invoices.first == invoice) {
      return null;
    }
    var previous = room!.invoices. first;
    for (var inv in room!.invoices) {
      if (inv != invoice) {
        previous = inv;
      } else {
        return previous;
      }
    }
    return previous;
  }
  calculateTotalAmount([currentPayment]) {
    var arr = room?.getElecAndWatPrice();
    int totalAmount = 0;
    var electricityConsumed =
        invoice!.newElectricityNumber! - invoice!.currentElectricityNumber!;
    var waterConsumed =
        invoice!.newWaterNumber! - invoice!.currentWaterNumber!;
    invoice!.electAmount = (electricityConsumed * arr[0]) as int?;
    invoice!.waterAmount = (waterConsumed * arr[1]) as int?;

    totalAmount += invoice!.amountAlreadyPay!;
    totalAmount += invoice!.electAmount!;
    totalAmount += invoice!.waterAmount!;
    if (invoice?.surcharge != null) {
      totalAmount += invoice!.surcharge!;
    }
    totalAmount += (invoice?.wifiAmount )!;

    return totalAmount;
  }

  getAmountInformation() {
    //Get electric and water price
    var arr = room?.getElecAndWatPrice();
    var electricityConsumed =
        invoice!.newElectricityNumber! - invoice!.currentElectricityNumber!;
    var warterConsumed =
        invoice!.newWaterNumber! - invoice!.currentWaterNumber!;

    costList.add([
      "Tiền Phòng",
      "1 tháng",
      1,
      invoice?.amountAlreadyPay
    ]);
    costList.add([
      "Tiền Điện",
      "Số cũ: ${invoice?.currentElectricityNumber}. Số mới: ${invoice?.newElectricityNumber}\n${moneyVNFormat.format(arr[0])}x $electricityConsumed Kwh",
      electricityConsumed,
      arr[0]
    ]);

    if (house?.isWaterPerPerson == true) {
      costList.add([
        "Tiền Nước",
        "${moneyVNFormat.format(arr[1])} x ${room?.numPerson} Người",
        warterConsumed,
        arr[1]
      ]);
    } else {
      costList.add([
        "Tiền Nước",
        "Số cũ: ${invoice?.currentWaterNumber}. Số mới: ${invoice?.newWaterNumber}\n${moneyVNFormat.format(arr[1])}x $warterConsumed Khối",
        warterConsumed,
        arr[1]
      ]);
    }
    if (invoice?.wifiAmount != 0 && invoice?.wifiAmount != null) {
      costList.add([
        "Tiền Dịch vụ",
        "Wifi, rác...",
        1,
        invoice?.wifiAmount
      ]);
    }

    if (invoice?.surcharge != 0 && invoice?.surcharge != null) {
      costList.add([
        "Tiền khác",
        "Chi phí khác: ${moneyVNFormat.format(invoice?.surcharge)}",
        1,
        invoice?.surcharge
      ]);
    }

    return costList;
  }

  getDebitAmount() {
    var totalDeb = 0;
    var lstDebit = room?.invoices.where((inv) => inv.debitAmount != 0 && inv != invoice);
    if (lstDebit!.isNotEmpty) {
      for(var deb in lstDebit) {
        totalDeb += deb.debitAmount!;
      }
    }
    return totalDeb;
  }

  getDebitInformation() {
    var lstDebit = room?.invoices.where((inv) => inv.debitAmount != 0 && inv != invoice);
    if (lstDebit!.isNotEmpty) {
      var detail = "";
      var totalDeb = 0;

      for(var deb in lstDebit) {
        final dateHelper = DateHelper.createWithArgument(deb.invoiceCreateDate);
        var monthDeb = dateHelper.getMonthYear();
        detail = (deb==lstDebit.last)? "$detail$monthDeb: ${moneyVNFormat.format(deb.debitAmount)}"
            : "$detail$monthDeb: ${moneyVNFormat.format(deb.debitAmount)}\n";
        totalDeb += deb.debitAmount!;
      }
      debList.add([
        "Tiền Nợ",
        detail,
        1,
        totalDeb
      ]);
    }
    return debList;
  }
}
