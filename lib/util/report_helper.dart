import 'package:room_manager/constants/const.dart';
import 'package:room_manager/model/house.dart';
import 'package:room_manager/model/invoice.dart';
import 'package:room_manager/model/monthyear.dart';
import 'package:room_manager/model/room.dart';
import 'package:room_manager/util/invoice_aguments.dart';

import '../excel/export_report.dart';
import '../model/expense.dart';

class ReportHelper {
  House? house;
  MonthYear? monthYear;

  //InvoiceAguments? invoiceAguments;
  List costList = [];
  int costTotal = 0;
  int expenseTotal = 0;

  ReportHelper();

  ReportHelper.createWithAgument(house1, my) {
    house = house1;
    monthYear = my;
  }

  getAmountExpense() {
    List expenseList = [];
    var lstExpenses = house!.expenses.where((exp) =>
          exp.expenseDate.month == int.parse(monthYear!.month)
          && exp.expenseDate.year == int.parse(monthYear!.year));
    for (Expense expense in lstExpenses) {
      expenseTotal = expenseTotal + expense.expense;
      expenseList.add([
        (expense.typeOtherExpense!="")?expense.typeOtherExpense:expense.typeExpense,
        "",
        1,
        expense.expense
      ]);
    }
    return expenseList;
  }

  getAmountInformation() {
    List costList = [];

    int? totalRoomAmount = 0;
    int? totalElectAmount = 0;
    int? totalWaterAmount = 0;
    int? totalServiceAmount = 0;
    int? totalOtherAmount = 0;
    int? totalElectKwh = 0;
    int? totalWaterKh = 0;


    for (Room room in house!.rooms) {
      var lstInvoice = room.invoices.where((invoice) =>
          invoice.invoiceCreateDate!.month == int.parse(monthYear!.month)
          && invoice.invoiceCreateDate!.year == int.parse(monthYear!.year));
      for(Invoice inv in lstInvoice) {
        totalRoomAmount = totalRoomAmount! +
            ((inv.amountAlreadyPay != null)? inv.amountAlreadyPay!.toInt(): 0);
        totalElectAmount = totalElectAmount! +
            ((inv.electAmount != null)? inv.electAmount!.toInt(): 0);
        totalElectKwh = totalElectKwh! + (inv.newElectricityNumber!-inv.currentElectricityNumber!.toInt());
        totalWaterAmount = totalWaterAmount! +
            ((inv.waterAmount != null)? inv.waterAmount!.toInt(): 0);
        totalWaterKh = totalWaterKh! + (inv.newWaterNumber!-inv.currentWaterNumber!.toInt());

        totalServiceAmount = totalServiceAmount! +
            ((inv.wifiAmount != null)? inv.wifiAmount!.toInt(): 0);
        totalOtherAmount = totalOtherAmount! +
            ((inv.surcharge != null)? inv.surcharge!.toInt(): 0);
      }
    }
    costTotal = totalRoomAmount! + totalElectAmount! +totalWaterAmount!+totalServiceAmount!+totalOtherAmount!;
    costList.add([
      "Tiền Phòng",
      "",
      1,
      totalRoomAmount
    ]);

    costList.add([
      "Tiền Điện ($totalElectKwh Kwh)",
      "",
      1,
      totalElectAmount
    ]);
    if (house!.isWaterPerPerson == true) {
      costList.add([
        "Tiền Nước",
        "",
        1,
        totalWaterAmount
      ]);
    } else {
      costList.add([
        "Tiền Nước ($totalWaterKh Khối)",
        "",
        1,
        totalWaterAmount
      ]);
    }

    costList.add([
      "Tiền Dịch vụ",
      "",
      1,
      totalServiceAmount
    ]);
    costList.add([
      "Tiền Khác",
      "",
      1,
      totalOtherAmount
    ]);
    return costList;
  }

  getInvoiceData() {
    int? totalRoomAmount = 0;
    int? totalElectAmount = 0;
    int? totalWaterAmount = 0;
    int? totalServiceAmount = 0;
    int? totalOtherAmount = 0;
    int? totalElectKwh = 0;
    int? totalWaterKh = 0;
    int? totalAmount = 0;

    List<InvoiceInfo> invoiceData =[];
    for (Room rm in house!.rooms) {
      var lstInv = rm.invoices.where((inv) =>
      inv.invoiceCreateDate!.month == int.parse(monthYear!.month)
          && inv.invoiceCreateDate!.year == int.parse(monthYear!.year));
      if (lstInv.isNotEmpty) {
        var inv = lstInv.last;
        var invData = InvoiceInfo(rm.roomNumber.toString(), inv.amountAlreadyPay,rm.numPerson, house?.isWaterPerPerson,
            inv.currentElectricityNumber , inv.newElectricityNumber , inv.electAmount
            , inv.currentWaterNumber, inv.newWaterNumber , inv.waterAmount
            , inv.wifiAmount , inv.surcharge , inv.totalAmount
        );
        invoiceData.add(invData);

        totalRoomAmount = totalRoomAmount! +
            ((inv.amountAlreadyPay != null)? inv.amountAlreadyPay!.toInt(): 0);
        totalElectAmount = totalElectAmount! +
            ((inv.electAmount != null)? inv.electAmount!.toInt(): 0);
        totalElectKwh = totalElectKwh! + (inv.newElectricityNumber!-inv.currentElectricityNumber!.toInt());
        totalWaterAmount = totalWaterAmount! +
            ((inv.waterAmount != null)? inv.waterAmount!.toInt(): 0);
        totalWaterKh = totalWaterKh! + (inv.newWaterNumber!-inv.currentWaterNumber!.toInt());

        totalServiceAmount = totalServiceAmount! +
            ((inv.wifiAmount != null)? inv.wifiAmount!.toInt(): 0);
        totalOtherAmount = totalOtherAmount! +
            ((inv.surcharge != null)? inv.surcharge!.toInt(): 0);
        totalAmount = totalAmount! +
            ((inv.totalAmount != null)? inv.totalAmount!.toInt(): 0);
      }
    }
    var invData = InvoiceInfo("Tổng", totalRoomAmount,0, house?.isWaterPerPerson,
        0 , 0 , totalElectAmount, 0, 0 , totalWaterAmount
        , totalServiceAmount , totalOtherAmount , totalAmount);
    invoiceData.add(invData);
    return invoiceData;
  }
}
