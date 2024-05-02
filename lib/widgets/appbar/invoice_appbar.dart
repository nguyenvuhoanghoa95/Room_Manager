import 'package:flutter/material.dart';
import 'package:room_manager/constants/colors.dart';

class InvoiceAppBar extends StatelessWidget implements PreferredSizeWidget {
  const InvoiceAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: tbBGColor,
      title: const Text(
        "Danh Sách Hoá Đơn",
        style: TextStyle(
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
      PopupMenuButton(
                    position: PopupMenuPosition.under,
                    itemBuilder: (context) => [
                      // PopupMenuItem(
                        // onTap: () => openDialog(context),
                        // child: const Text('Thêm giá điện nước'),
                      // ),
                    ],
                  ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
