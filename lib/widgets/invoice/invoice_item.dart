import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:room_manager/constants/colors.dart';
import 'package:room_manager/constants/const.dart';
import 'package:room_manager/model/invoice.dart';

class InvoiceItem extends StatelessWidget {
  final Invoice invoice;
  final VoidCallback navigateToInvoicePage;
  final VoidCallback removeFuntion;
  final bool isShowMenu;

   const InvoiceItem(
      {
        super.key,
        required this.invoice,
        required this.navigateToInvoicePage,
        required this.removeFuntion,
        required this.isShowMenu
      });

  @override
  Widget build(BuildContext context) {
    var room = invoice.getRoom();
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: ListTile(
          onTap: navigateToInvoicePage,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          tileColor: Colors.white,
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Phòng",
                    style: TextStyle(
                      fontSize: 16,
                      color: tbBlack,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    room.roomNumber.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: tbBlack,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Ngày tạo hóa đơn",
                    style: TextStyle(
                      fontSize: 15,
                      color: tbBlack,
                    ),
                  ),
                  Text(
                    DateFormat("dd-MM-yyy").format(invoice.invoiceCreateDate!),
                    style: const TextStyle(
                      fontSize: 15,
                      color: tbBlack,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    invoice.debitAmount != 0 ?"Tiền nợ":"Đã thanh toán",
                    style: const TextStyle(
                      fontSize: 15,
                      color: tbBlack,
                    ),
                  ),
                  Text(
                    invoice.debitAmount != 0 ? numberFormat.format(invoice.debitAmount) : "",
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Tiền hóa đơn",
                    style: TextStyle(
                      fontSize: 15,
                      color: tbBlack,
                    ),
                  ),
                  Text(
                    numberFormat.format(invoice.totalAmount),
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Visibility(
              visible: isShowMenu,
              child:
              PopupMenuButton(
                position: PopupMenuPosition.under,
                itemBuilder: (context) => [
                   PopupMenuItem(
                    onTap: removeFuntion,
                    child: const Text('Xóa hóa đơn'),
                  )
                ],
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }
}
