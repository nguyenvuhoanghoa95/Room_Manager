import 'package:flutter/material.dart';
import 'package:room_manager/constants/colors.dart';
import 'package:room_manager/database/database_setting.dart';
import 'package:room_manager/model/house.dart';
import 'package:room_manager/model/room.dart';
import 'package:room_manager/widgets/appbar/room_appbar.dart';
import 'package:room_manager/widgets/dialog/room_dialog.dart';
import 'package:room_manager/widgets/room/room_item.dart';

class RoomPage extends StatefulWidget {
  const RoomPage({super.key});

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  House? house;
  List<Room>? rooms;
  final _electricityPriceController = TextEditingController();
  final _waterPriceController = TextEditingController();
  final _roomNameController = TextEditingController();
  final _datePickerController = TextEditingController();
  final _renterController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      house = ModalRoute.of(context)!.settings.arguments as House?;
      _electricityPriceController.text = "${house?.electricityPrice}";
      _waterPriceController.text = "${house?.waterPrice}";
      setState(() {
        rooms = house!.rooms.toList();
      });
    });
  }

  //save
  saveRoom({int? index}) {
    if (_roomNameController.text.isNotEmpty &&
        _datePickerController.text.isNotEmpty &&
        _renterController.text.isNotEmpty) {
      if (index == null) {
        //Add action
        addRoom();
      } else {
        //Edit action
        // var house = editHouse(houses![index!]);
        // houseBox.putAt(index, house);
      }
    }
    setState(() {
      rooms = List<Room>.from(house!.rooms);
    });
    cancel();
  }

  addRoom() {
    var newRoom = Room(
        DateTime.parse(_datePickerController.text),
        int.parse(_roomNameController.text),
        _renterController.text);
    roomBox.add(newRoom);
    house?.rooms.add(newRoom);
    house?.save();
  }

  //Clearn data in controller
  cancel() {
    _roomNameController.clear();
    _datePickerController.clear();
    _renterController.clear();
    Navigator.of(context).pop();
  }

  // Create new home
  void createNewRoom() {
    showDialog(
      context: context,
      builder: (context) {
        return RoomDialog(
          renterController:_renterController,
          roomNameController: _roomNameController,
          datePickerController: _datePickerController,
          create: () => saveRoom(),
          cancel: () => cancel(),
        );
      },
    );
  }

  // Remove room
  removeRoom(int index) {
    roomBox.deleteAt(index);
    if (rooms != null) {
      setState(() {
        rooms = List<Room>.from(roomBox.values);
      });
    }
  }

  //Navigate to invoicePage
  navigateToInvoicePage(int? roomId) {
    Navigator.pushNamed(context, '/invoice-page', arguments: roomId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tbBGColor,
      appBar: RoomAppBar(
        house: house,
        electricPriceController: _electricityPriceController,
        waterPriceController: _waterPriceController,
      ),
      body: Stack(
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                children: [
                  searchBox(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: rooms?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            margin: const EdgeInsets.only(
                              top: 25,
                            ),
                            child: RoomItem(
                                room: rooms![index],
                                navigateToInvoicePage: () =>
                                    navigateToInvoicePage(index),
                                removeRoomFuntion: () => removeRoom(index)));
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
}
