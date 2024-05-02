import 'package:flutter/material.dart';
import 'package:room_manager/database/database_setting.dart';
import 'package:room_manager/model/house.dart';
import 'package:room_manager/widgets/appbar/home_appbar.dart';
import 'package:room_manager/widgets/dialog/house_dialog.dart';
import '../constants/colors.dart';
import '../widgets/house/house_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _addressController = TextEditingController();
  final _nameOwnerController = TextEditingController();
  final _availableRoomsController = TextEditingController();
  final _electricityPriceController = TextEditingController();
  final _waterPriceController = TextEditingController();

  List<House>? houses = houseBox.values.toList();

  //save home
  saveHome({int? index = 0}) {
    if (_addressController.text.isNotEmpty &&
        _nameOwnerController.text.isNotEmpty &&
        _availableRoomsController.text.isNotEmpty &&
        _electricityPriceController.text.isNotEmpty &&
        _waterPriceController.text.isNotEmpty) {
      if (index == 0) {
        houseBox.add(House(
            _addressController.text,
            _nameOwnerController.text,
            int.parse(_availableRoomsController.text),
            int.parse(_electricityPriceController.text),
            int.parse(_waterPriceController.text)));
      } else {
        houseBox.putAt(
            index!,
            House(
                _addressController.text,
                _nameOwnerController.text,
                int.parse(_availableRoomsController.text),
                int.parse(_electricityPriceController.text),
                int.parse(_waterPriceController.text)));
      }
      _addressController.clear();
      _nameOwnerController.clear();
      _availableRoomsController.clear();
      _electricityPriceController.clear();
      _waterPriceController.clear();
    }
    setState(() {
      houses = List<House>.from(houseBox.values);
    });
    Navigator.of(context).pop();
  }

  // Create new home
  createNewHome() {
    showDialog(
      context: context,
      builder: (context) {
        return HouseDialog(
          addressController: _addressController,
          availableRoomsController: _availableRoomsController,
          nameOwnerController: _nameOwnerController,
          electricityPriceController: _electricityPriceController,
          waterPriceController: _waterPriceController,
          create:() => saveHome(),
          cancel: () => cancel(),
        );
      },
    );
  }

  cancel(){
     _addressController.clear();
      _nameOwnerController.clear();
      _availableRoomsController.clear();
      _electricityPriceController.clear();
      _waterPriceController.clear();
    Navigator.of(context).pop();
  }

  //Edit house
  editHome(House house, int index) {
    showDialog(
      context: context,
      builder: (context) {
        //Set up data
        _addressController.text = house.address;
        _availableRoomsController.text = "${house.availableRooms}";
        _nameOwnerController.text = house.nameOwner;
        _electricityPriceController.text = "${house.electricityPrice}";
        _waterPriceController.text = "${house.waterPrice}";

        //Open dialog
        return HouseDialog(
          addressController: _addressController,
          availableRoomsController: _availableRoomsController,
          nameOwnerController: _nameOwnerController,
          electricityPriceController: _electricityPriceController,
          waterPriceController: _waterPriceController,
          edit: () => saveHome(index: index),
          cancel: () => cancel(),
        );
      },
    );
  }

  // Remove home
  removeHouse(int index) {
    houseBox.deleteAt(index);
    setState(() {
      houses = List<House>.from(houseBox.values);
    });
  }

  //Navigate to roompage
  navigateToRoomPage(context, int houseId) {
    Navigator.pushNamed(context, '/room-page', arguments: houseId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tbBGColor,
      appBar: const HomeAppBar(),
      body: Stack(
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                children: [
                  searchBox(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: houses?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            margin: const EdgeInsets.only(
                              top: 25,
                            ),
                            child: HouseItem(
                              house: houses![index],
                              removeHouseFuntion: () {
                                removeHouse(index);
                              },
                              editHouseFuntion: () {
                                editHome(houses![index], index);
                              },
                              navigateToRoomPage: () {
                                navigateToRoomPage(context, index);
                              },
                            ));
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
                    onPressed: () => createNewHome(),
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
