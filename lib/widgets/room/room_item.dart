import 'package:flutter/material.dart';
import 'package:room_manager/constants/colors.dart';
import 'package:room_manager/model/room.dart';

class RoomItem extends StatelessWidget {
  
  final Room room;
  final VoidCallback removeRoomFuntion;


  const RoomItem(
      {super.key,
      required this.room,
      required this.removeRoomFuntion});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          tileColor: Colors.white,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                room.roomNumber.toString(),
                style: const TextStyle(
                  fontSize: 20,
                  color: tbBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Người Thêu : ${room.roomRenterName}",
                style: const TextStyle(
                  fontSize: 15,
                  color: tbBlack,
                ),
              ),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PopupMenuButton(
                      position: PopupMenuPosition.under,
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          onTap: removeRoomFuntion,
                          child: const Text('Delete'),
                        ),
                         const PopupMenuItem(
                          value: 'edit',
                          child: Text('Edit'),
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
