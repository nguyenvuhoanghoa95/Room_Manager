import 'package:flutter/material.dart';
import 'package:room_manager/constants/colors.dart';
import 'package:room_manager/constants/const.dart';
import 'package:room_manager/model/invoice.dart';

class InvoiceItem extends StatelessWidget {
  final Invoice invoice;
  final VoidCallback navigateToInvoicePage;
  final VoidCallback removeFuntion;

   const InvoiceItem(
      {super.key,
      required this.invoice,
      required this.navigateToInvoicePage,
      required this.removeFuntion
      });

  @override
  Widget build(BuildContext context) {
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
                    "Ngày thanh toán",
                    style: TextStyle(
                      fontSize: 16,
                      color: tbBlack,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    invoice.invoiceCreateDate.toString().split(" ")[0],
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
                    "Tiền nợ",
                    style: TextStyle(
                      fontSize: 15,
                      color: tbBlack,
                    ),
                  ),
                  Text(
                   invoice.debit!.isNotEmpty ? numberFormat.format(invoice.debit?[0].amount) : "Không có nợ",
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
                    "Tổng tiền đã thu",
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
              PopupMenuButton(
                position: PopupMenuPosition.under,
                itemBuilder: (context) => [
                   PopupMenuItem(
                    onTap: removeFuntion,
                    child: const Text('Xóa hóa đơn'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
