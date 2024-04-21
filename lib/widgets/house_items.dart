import 'package:flutter/material.dart';
import 'package:room_manager/constants/colors.dart';

class HouseItems extends StatelessWidget {
  final String address;
  final String nameOwner;
  final int availableRooms;

  VoidCallback removeHouseFuntion;
  VoidCallback navigateToRoomPage;

  HouseItems(
      {super.key,
      required this.address,
      required this.nameOwner,
      required this.availableRooms,
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
                nameOwner,
                style: const TextStyle(
                  fontSize: 20,
                  color: tbBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Room Available : $availableRooms",
                style: const TextStyle(
                  fontSize: 15,
                  color: tbBlack,
                ),
              ),
              Text(
                address,
                style: const TextStyle(
                  fontSize: 15,
                  color: tbBlack,
                ),
              ),
            ],
          ),
          trailing: Container(
            padding: const EdgeInsets.all(0),
            margin: const EdgeInsets.symmetric(vertical: 6),
            height: 35,
            width: 35,
            decoration: BoxDecoration(
                color: tdRed, borderRadius: BorderRadius.circular(5)),
            child: IconButton(
              color: Colors.white,
              iconSize: 18,
              icon: const Icon(Icons.delete),
              onPressed: removeHouseFuntion,
            ),
          ),
        ),
      ),
    );
  }
}
