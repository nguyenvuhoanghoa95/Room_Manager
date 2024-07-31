import 'package:room_manager/constants/const.dart';
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

  InvoiceHelper();

  InvoiceHelper.createWithAgument(this.invoiceAguments) {
    room = invoiceAguments?.room;
    invoice = invoiceAguments?.invoice;
  }

  caculateTotalAmount([currrentPayment]) {
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
    totalAmount += (invoice?.wifiAmount ) as num;

    if(invoice!.debit!.isEmpty) return totalAmount;  
    if(invoice?.debit != null && currrentPayment.isEmpty){
      totalAmount -= invoice!.debit![0].amount as num;
    }else{
      totalAmount += invoice!.debit![0].amount as num;
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
      "30 ngày: ${numberFormat.format(invoice?.amountAlreadyPay)}",
      1,
      invoice?.amountAlreadyPay
    ]);
    costList.add([
      "Tiền Điện",
      "Số mới: ${invoice?.newElectricityNumber}, Số Cũ: ${invoice?.currentElectricityNumber}\n${arr[0]} x $electricityConsumed Kwh",
      electricityConsumed,
      arr[0]
    ]);
    costList.add([
      "Tiền Nước",
      "Số mới: ${invoice?.newWaterNumber}, Số Cũ: ${invoice?.currentWaterNumber}\n${arr[1]} x $warterConsumed Khối",
      warterConsumed,
      arr[1]
    ]);
    costList.add([
      "Tiền Dịch vụ",
      "Wifi, rác...",
      1,
      invoice?.wifiAmount
    ]);
    if (invoice?.surcharge != null) {
      costList.add([
        "Tiền khác",
        "Chi phí khác: ${numberFormat.format(invoice?.surcharge)}",
        1,
        invoice?.surcharge
      ]);
    }
    if (invoice!.debit!.isNotEmpty && invoice?.debit != null && invoice?.debit![0].amount != 0) {
      costList.add([
        "Tiền Nợ",
        "Tiền còn nợ lại: ${numberFormat.format(invoice?.debit?[0].amount)}",
        1,
        invoice?.debit?[0].amount
      ]);
    }

    return costList;
  }
}
