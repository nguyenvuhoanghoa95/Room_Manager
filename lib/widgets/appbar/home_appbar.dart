import 'package:flutter/material.dart';
import 'package:room_manager/constants/colors.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {

  
 const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: tbBGColor,
        centerTitle: true,
        title:const Text(
                'Nhà Trọ',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
