import 'package:flutter/material.dart';
import 'package:room_manager/constants/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {

  late String namePage;
  
  CustomAppBar({
    super.key,
    required this.namePage,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: tbBGColor,
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.home_outlined, color: tbBlack, size: 30),
              Text(
                namePage,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
             const Icon(Icons.more_vert_outlined, color: tbBlack, size: 30),
            ]));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
