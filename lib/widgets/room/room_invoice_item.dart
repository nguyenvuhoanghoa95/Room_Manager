import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:room_manager/constants/colors.dart';
import 'package:room_manager/model/room.dart';

class RoomInvoiceItem extends StatelessWidget {
  
  final Room room;
  final VoidCallback navigateToInvoicePage;

  const RoomInvoiceItem(
      {super.key,
      required this.room,
      required this.navigateToInvoicePage});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: ListTile(
          onTap: navigateToInvoicePage,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          tileColor: Colors.white,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Số phòng : ${room.roomNumber.toString()}",
                style: const TextStyle(
                  fontSize: 20,
                  color: tbBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Ngày tạo Hóa Đơn: ${room.invoices.isNotEmpty ? DateFormat("dd-MM-yyy").format(room.invoices.last.invoiceCreateDate!) : "Chưa có hóa đơn nào"}",
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
class RoomNoInvoiceItem extends StatelessWidget {

  final Room room;
  final VoidCallback navigateToInvoicePage;

  const RoomNoInvoiceItem(
      {super.key,
        required this.room,
        required this.navigateToInvoicePage});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: ListTile(
          onTap: navigateToInvoicePage,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          tileColor: Colors.white,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Số phòng : ${room.roomNumber.toString()}",
                style: const TextStyle(
                  fontSize: 20,
                  color: tbBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Chưa tạo hóa đơn!",
                style: TextStyle(
                  fontSize: 15,
                  color: tdRed
                ),
              ),
            ],
          ),

        ),
      ),
    );
  }
}
