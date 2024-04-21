import 'package:flutter/material.dart';
import 'package:room_manager/constants/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: tbBGColor,
        title:
            const Row(
              children: [
                Icon(
                  Icons.menu,
                  color: tbBlack,
                  size: 30)
                  ]
                  )
                  );
  }
  
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}