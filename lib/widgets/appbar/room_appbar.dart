import 'package:flutter/material.dart';
import 'package:room_manager/constants/colors.dart';

class RoomAppBar extends StatelessWidget implements PreferredSizeWidget {

  RoomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: tbBGColor,
        title: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Rooms Page',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
             Icon(Icons.more_vert_outlined, color: tbBlack, size: 30),
            ]));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
