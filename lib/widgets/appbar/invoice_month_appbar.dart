import 'package:flutter/material.dart';
import 'package:room_manager/constants/colors.dart';

import '../../util/date_helper.dart';

class InvoiceMonthAppbar extends StatelessWidget implements PreferredSizeWidget {


  const InvoiceMonthAppbar({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    var dateStr = DateHelper.createWithArgument(DateTime.now()).getMonthYear();

    return AppBar(
      backgroundColor: tbBGColor,
      centerTitle: true,
      title:Text(
        "Hóa đơn $dateStr",
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
