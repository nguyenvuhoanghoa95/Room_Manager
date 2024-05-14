import 'package:flutter/material.dart';
import 'package:room_manager/constants/colors.dart';
import 'package:room_manager/model/room.dart';

class InvoiceAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Room? room;
  final String title;

  
  const InvoiceAppBar({
    super.key,
    this.room, 
    required this.title,
  });

  

  @override
  Widget build(BuildContext context) {

    //Navigate to invoicePage
    navigateToInvoiceCreatePage(Room? room){
        Navigator.pushNamed(
          context,
          '/invoice-page/create',
          arguments: room
        );
    }

    return AppBar(
      backgroundColor: tbBGColor,
      title:  Text(
        title,
        style:const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w500,
        ),
      ),
      titleSpacing: 00.0,
      centerTitle: true,
      toolbarHeight: 60.2,
      toolbarOpacity: 0.8,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
      ),
      elevation: 0.00,
      actions: [
      room != null ? PopupMenuButton(
                    position: PopupMenuPosition.under,
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        onTap: () => navigateToInvoiceCreatePage(room),
                        child: const Text('Tạo hóa đơn mới'),
                      ),
                    ],
                  ) : PopupMenuButton(
                    position: PopupMenuPosition.under,
                    itemBuilder: (context) => [
                      // PopupMenuItem(
                      //   onTap: () => navigateToInvoiceCreatePage(room),
                      //   child: const Text('Tạo hóa đơn mới'),
                      // ),
                    ],
                  ) 
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
