import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:room_manager/constants/colors.dart';
import 'package:room_manager/model/room.dart';
import 'package:share_plus/share_plus.dart';
import 'package:image_picker/image_picker.dart';

class RoomItem extends StatelessWidget {
  
  final Room room;
  final VoidCallback removeFuntion;
  final VoidCallback editFuntion;
  final VoidCallback navigateToInvoicePage;

  getImage() async {
    final XFile? pickedFile = await ImagePicker().pickImage(source:
    ImageSource.gallery); //This opens the gallery and lets the user pick the image
    if (pickedFile == null) return; //Checks if the user did actually pick something

    final File image = (File(pickedFile.path)); //This is the image the user picked
  }

  const RoomItem(
      {super.key,
      required this.room,
      required this.removeFuntion,
      required this.navigateToInvoicePage,
      required this.editFuntion});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(bottom: 0),
        child: ListTile(
          onTap: navigateToInvoicePage,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          tileColor: Colors.white,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Phòng : ${room.roomNumber.toString()}",
                style: const TextStyle(
                  fontSize: 20,
                  color: tbBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Người Thuê : ${room.roomRenterName}",
                style: const TextStyle(
                  fontSize: 15,
                  color: tbBlack,
                ),
              ),

              Text(
                "Ngày thanh toán : ${room.datePay}",
                style: const TextStyle(
                  fontSize: 15,
                  color: tbBlack,
                ),
              ),
              //  Text(
              //   "Tình trạng : ${room.invoices.isNotEmpty && room.invoices.where((invoice) => invoice.debit != null).isNotEmpty ? "Có nợ" : "Không nợ"}",
              //   style: const TextStyle(
              //     fontSize: 15,
              //     color: tbBlack,
              //   ),
              // ),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PopupMenuButton(
                      position: PopupMenuPosition.under,
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          onTap: ()=> editFuntion(), //getImage(),
                          child: const Text('Sửa thông tin'),
                        ),
                        PopupMenuItem(
                          onTap: removeFuntion,
                          child: const Text('Xóa phòng'),
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
