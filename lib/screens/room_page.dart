import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:room_manager/constants/colors.dart';
import 'package:room_manager/database/database_setting.dart';
import 'package:room_manager/model/house.dart';
import 'package:room_manager/model/room.dart';
import 'package:room_manager/widgets/appbar/custom_appbar.dart';
import 'package:room_manager/widgets/appbar/room_appbar.dart';
import 'package:room_manager/widgets/dialog/room_dialog.dart';
import 'package:room_manager/widgets/room/room_items.dart';

class RoomPage extends StatefulWidget {
  const RoomPage({super.key});

  @override
  State<RoomPage> createState() => _RoomPageState();
}

Widget searchBox() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: const TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tbBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tbGrey),
        ),
      ),
    );
  }
  


class _RoomPageState extends State<RoomPage> {
    

    //save new home 
  void saveNewHome() {
    //   if(_addressController.text.isNotEmpty && 
    //   _nameOwnerController.text.isNotEmpty && 
    //   _availableRoomsController.text.isNotEmpty &&
    //   _electricityPriceController.text.isNotEmpty &&
    //   _waterPriceController.text.isNotEmpty){
    //   houseBox.add(
    //     House(_addressController.text,
    //           _nameOwnerController.text,
    //           int.parse(_availableRoomsController.text),
    //           int.parse(_electricityPriceController.text),
    //           int.parse(_waterPriceController.text),[])
    //   );
    //   _addressController.clear();
    //   _nameOwnerController.clear();
    //   _availableRoomsController.clear();
    //   _electricityPriceController.clear();
    //   _waterPriceController.clear();
    //   }
    // setState(() {
    //   houses = List<House>.from(houseBox.values);
    // });
    Navigator.of(context).pop();
  }


  // Create new home 
  void createNewRoom(){
    showDialog(
     context: context ,
     builder: (context) {
      return RoomDialog(
        create: saveNewHome,
        cancel: () => Navigator.of(context).pop(),);
    },);
  }


  @override
  Widget build(BuildContext context) {
    
    int? houseId = ModalRoute.of(context)!.settings.arguments as int?;
    List<Room> rooms = roomBox.values.where((element) => element.houseId == houseId).toList();

    return Scaffold(
      backgroundColor: tbBGColor,
      appBar: RoomAppBar(),
      body: Stack(
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                children: [
                  searchBox(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: rooms.length,
                      itemBuilder: (BuildContext context, int index) {
                        if(rooms.isNotEmpty){
                          return Container(
                            margin: const EdgeInsets.only(
                              top: 25,
                            ),
                            // child: RoomItems(
                            //   // room: Room(roomNumber, houseId, roomRenterName, amountOfRoom, totalAmountOwed, currentElectricityNumber, currentWaterNumber, roomActivitieIds, invoiceIds, status),
                            //   removeHouseFuntion:() {
                            //     // removeHouse(index);
                            //   },
                            //   navigateToRoomPage: () {
                            //     // navigateToRoomPage(context);
                            //   },)
                        );
                        }
                      },
                    ),
                  )
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
                    onPressed: () => createNewRoom(),
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