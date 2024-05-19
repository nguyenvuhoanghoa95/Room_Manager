import 'package:room_manager/constants/const.dart';
import 'package:room_manager/database/database_setting.dart';
import 'package:room_manager/model/house.dart';
import 'package:room_manager/model/invoice.dart';
import 'package:room_manager/model/room.dart';
import 'package:room_manager/util/invoice_aguments.dart';

class InvoiceHelper {
  House? house;
  Invoice? invoice;
  Room? room;
  InvoiceAguments? invoiceAguments;
  List costList = [];

  // List costList = [
//     // ["Tiền Phòng", 1, 5500000],
//     // ["Tiền Điện", 50, 3500],
//     // ["Tiền Nước", 20, 17000],
//     // ["Tiền Khác", 20, 17000],
//     // ["Tiền Nợ", 20, 1000000]
//   ];

  InvoiceHelper();

  InvoiceHelper.createWithAgument(this.invoiceAguments) {
    room = invoiceAguments?.room;
    invoice = invoiceAguments?.invoice;
  }

  caculateTotalAmount() {
    var arr = room?.getElecAndWatPrice();
    num totalAmount = 0;
    var electricityConsumed =
        invoice!.newElectricityNumber! - invoice!.currentElectricityNumber!;
    var warterConsumed =
        invoice!.newWaterNumber! - invoice!.currentWaterNumber!;
    totalAmount += invoice?.amountAlreadyPay as num;
    totalAmount += electricityConsumed * arr[0];
    totalAmount += warterConsumed * arr[1];
    if (invoice?.surcharge != null) {
      totalAmount += invoice?.surcharge as num;
    }
    if (invoice?.amountOwed != null) {
      totalAmount += invoice?.amountOwed as num;
    }
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
      "30 ngày giá : ${numberFormat.format(invoice?.amountAlreadyPay)}",
      1,
      invoice?.amountAlreadyPay
    ]);
    costList.add([
      "Tiền Điện",
      "Số mới: ${invoice?.newElectricityNumber}, Số Cũ: ${invoice?.currentElectricityNumber}\n${arr[0]}KWh x $electricityConsumed",
      electricityConsumed,
      arr[0]
    ]);
    costList.add([
      "Tiền Nước",
      "Số mới: ${invoice?.newWaterNumber}, Số Cũ: ${invoice?.currentWaterNumber}\n${arr[1]}KWh x $warterConsumed",
      warterConsumed,
      arr[1]
    ]);
    if (invoice?.surcharge != null) {
      costList.add([
        "Tiền khác",
        "Chi phí khác: ${numberFormat.format(invoice?.surcharge)}",
        1,
        invoice?.surcharge
      ]);
    }
    if (invoice?.amountOwed != null) {
      costList.add([
        "Tiền Nợ",
        "Tiền còn nợ lại: ${numberFormat.format(invoice?.amountOwed)}",
        1,
        invoice?.amountOwed
      ]);
    }

    return costList;
  }
}
