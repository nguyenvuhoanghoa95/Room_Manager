import 'package:flutter/material.dart';
import 'package:room_manager/constants/colors.dart';
import 'package:room_manager/model/house.dart';
class HouseItem extends StatelessWidget {

  final House house;

  final VoidCallback removeHouseFuntion;
  final VoidCallback editHouseFuntion;
  final VoidCallback navigateToRoomPage;

  const HouseItem(
      {super.key,
      required this.house,
      required this.editHouseFuntion,
      required this.removeHouseFuntion,
      required this.navigateToRoomPage});

 

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: ListTile(
          onTap: navigateToRoomPage,
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
                "Nhà : ${house.address}",
                style: const TextStyle(
                  fontSize: 20,
                  color: tbGrey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Số phòng : ${house.rooms.length}",
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
                          onTap: editHouseFuntion,
                          value: 'edit',
                          child: const Text('Sửa thông tin'),
                        ),
                        PopupMenuItem(
                          onTap: removeHouseFuntion,
                          child: const Text('Xoá nhà'),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
