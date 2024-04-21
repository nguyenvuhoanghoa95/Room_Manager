import 'package:flutter/material.dart';
import 'package:room_manager/constants/colors.dart';
import 'package:room_manager/widgets/appbar.dart';

class RoomPage extends StatefulWidget {
  const RoomPage({super.key});

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tbBGColor,
      appBar: const CustomAppBar(),
      body: Stack(
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                children: [
                  // searchBox(),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 50,
                      bottom: 5,
                    ),
                    child: const Text(
                      "Rooms",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  // Expanded(
                  //   child: ListView.builder(
                  //     itemCount: homeList.length,
                  //     itemBuilder: (BuildContext context, int index) {
                  //       if(homeList.isNotEmpty){
                  //         return Container(
                  //           margin: const EdgeInsets.only(
                  //             top: 25,
                  //           ),
                  //           child: HouseItems(
                  //             address: homeList[index]?[0],
                  //             nameOwner: homeList[index]?[1],
                  //             availableRooms:homeList[index]?[2],
                  //             removeHouseFuntion:() {
                  //               removeHouse(index);
                  //             },
                  //             navigateToRoomPage: () {
                  //               navigateToRoomPage(context);
                  //             },)
                  //       );
                  //       }
                  //     },
                  //   ),
                  // )
                ],
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      alignment: Alignment.bottomLeft,
                      minimumSize: const Size(60, 60),
                      elevation: 10,
                    ),
                    child: const Text(
                      '+',
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}