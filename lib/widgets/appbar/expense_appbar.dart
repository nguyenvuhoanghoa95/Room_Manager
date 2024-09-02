import 'package:flutter/material.dart';
import 'package:room_manager/constants/colors.dart';

class ExpenseAppBar extends StatelessWidget implements PreferredSizeWidget {


  const ExpenseAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: tbBGColor,
      centerTitle: true,
      title:const Text(
        'Chi Phi Nhà Trọ',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w500,
        ),
      ),);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
