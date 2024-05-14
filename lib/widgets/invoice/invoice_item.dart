import 'package:flutter/material.dart';
import 'package:room_manager/constants/colors.dart';
import 'package:room_manager/model/invoice.dart';

class InvoiceItem extends StatelessWidget {
  
  final Invoice invoice;
  final VoidCallback navigateToInvoicePage;

  const InvoiceItem(
      {super.key,
      required this.invoice,
      required this.navigateToInvoicePage});

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
          title: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                invoice.invoiceCreateDate.toString().split(" ")[0],
                style: const TextStyle(
                  fontSize: 20,
                  color: tbBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${invoice.amountAlreadyPay}",
                style: const TextStyle(
                  fontSize: 15,
                  color: tbBlack,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
