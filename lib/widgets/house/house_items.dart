import 'package:flutter/material.dart';
import 'package:room_manager/constants/colors.dart';
import 'package:room_manager/model/house.dart';

class HouseItems extends StatelessWidget {

  House house;

  VoidCallback removeHouseFuntion;
  VoidCallback navigateToRoomPage;

  HouseItems(
      {super.key,
      required this.house,
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
                house.nameOwner,
                style: const TextStyle(
                  fontSize: 20,
                  color: tbBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Room Available : ${house.availableRooms}",
                style: const TextStyle(
                  fontSize: 15,
                  color: tbBlack,
                ),
              ),
              Text(
                house.address,
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
                          onTap: removeHouseFuntion,
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
