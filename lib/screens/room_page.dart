import 'package:flutter/material.dart';
import 'package:room_manager/constants/colors.dart';
import 'package:room_manager/database/database_setting.dart';
import 'package:room_manager/model/house.dart';
import 'package:room_manager/model/room.dart';
import 'package:room_manager/widgets/appbar/room_appbar.dart';
import 'package:room_manager/widgets/dialog/room_dialog.dart';
import 'package:room_manager/widgets/room/room_item.dart';

import '../constants/const.dart';

class RoomPage extends StatefulWidget {
  const RoomPage({super.key});

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  House? house;
  List<Room>? rooms;
  List<Room>? filteredItems = [];
 // final _formKey = GlobalKey<FormState>();
  final _searchController = TextEditingController();
  final _electricityPriceController = TextEditingController();
  final _waterPriceController = TextEditingController();
  final _roomNameController = TextEditingController();
  final _datePickerController = TextEditingController();
  final _renterController = TextEditingController();
  final _electricNumber = TextEditingController();
  final _waterNumber = TextEditingController();
  final _datePayController = TextEditingController();
  final _telephoneController = TextEditingController();
  final _numPersonController = TextEditingController();
  final _depositAmountController = TextEditingController();


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
      filteredItems = rooms;
    });
    _searchController.addListener(_filterItems);
  }

  void _filterItems() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredItems = rooms
          ?.where((room) => room.roomRenterName.toLowerCase().contains(query))
          .toList();
    });
  }

  //save
  saveRoom({int? index}) {
    if (_roomNameController.text.isNotEmpty) {
      if (index == null) {
        //Add action
        addRoom();
      } else {
        //Edit action
        editRoom(filteredItems![index]);
      }
    }
    setState(() {
      filteredItems = List<Room>.from(house!.rooms);
    });
    cancel();
  }

  // Create new home
  createNewRoom() {
    showDialog(
      context: context,
      builder: (context) {
        return RoomDialog(
          renterController: _renterController,
          roomNameController: _roomNameController,
          datePickerController: _datePickerController,
          datePayController: _datePayController,
          telephoneController: _telephoneController,
          numPersonController: _numPersonController,
          depositAmountController: _depositAmountController,
          create: () => saveRoom(),
          cancel: () => cancel(),
        );
      },
    );
  }

  addRoom() {
    var datePay = (_datePayController.text.isEmpty)? 1 : int.parse(_datePayController.text);
    var numPer = (_numPersonController.text.isEmpty)? 1 : int.parse(_numPersonController.text);
    var date = (_datePickerController.text.isEmpty)? DateTime.now() :  DateTime.parse(_datePickerController.text);
    var deposit = (_depositAmountController.text.isEmpty)? 0 : int.parse(_depositAmountController.text.replaceAll(",", ""));

    var newRoom = Room(date,
        int.parse(_roomNameController.text), _renterController.text,
        datePay, _telephoneController.text, numPer,deposit);
    roomBox.add(newRoom);
    house?.rooms.add(newRoom);
    house?.save();
  }

  editRoom(Room editRoom) {
    editRoom.rentDueDate = DateTime.parse(_datePickerController.text);
    editRoom.roomRenterName = _renterController.text;
    editRoom.roomNumber = int.parse(_roomNameController.text);
    if(int.parse(_electricNumber.text) != 0) editRoom.currentElectricityNumber = int.parse(_electricNumber.text);
    if(int.parse(_waterNumber.text) != 0)  editRoom.currentWaterNumber = int.parse(_waterNumber.text);
    editRoom.datePay = int.parse(_datePayController.text);
    editRoom.depositAmount = int.parse(_depositAmountController.text.replaceAll(",", ""));
    editRoom.numPerson = (_numPersonController.text.isEmpty)? 1 : int.parse(_numPersonController.text);
    return editRoom.save();
  }

  //Call edit house dialog
  editDialog(Room room, int index) {
    showDialog(
      context: context,
      builder: (context) {
        //Set up data
        _renterController.text = room.roomRenterName;
        _datePickerController.text = room.rentDueDate.toString().split(" ")[0];
        _roomNameController.text = "${room.roomNumber}";
        _electricNumber.text = "${room.currentElectricityNumber}";
        _waterNumber.text = "${room.currentWaterNumber}";
        _datePayController.text = "${room.datePay}";
        _depositAmountController.text = moneyFormat.format(room.depositAmount).toString();//"${room.depositAmount}";
        _numPersonController.text = "${room.numPerson}";

        //Open dialog
        return RoomDialog(
          renterController: _renterController,
          roomNameController: _roomNameController,
          datePickerController: _datePickerController,
          electricNumber: _electricNumber,
          waterNumber: _waterNumber,
          datePayController: _datePayController,
          numPersonController : _numPersonController,
          depositAmountController : _depositAmountController,
          edit: () => saveRoom(index: index),
          cancel: () => cancel(),
        );
      },
    );
  }

  //Clearn data in controller
  cancel() {
    _roomNameController.clear();
    _datePickerController.clear();
    _renterController.clear();
    _datePayController.clear();
    _telephoneController.clear();
    _numPersonController.clear();
    _depositAmountController.clear();
    Navigator.of(context).pop();
  }

  // Remove room
  removeRoom(int index) {
    var room = house!.rooms[index];
    roomBox.delete(room.key);
    setState(() {
      filteredItems = List<Room>.from(house!.rooms);
    });
  }

  //Navigate to invoicePage
  navigateToInvoicePage(Room room) {
    Navigator.pushNamed(context, '/invoice-page', arguments: room);
  }
  navigateToInvoiceMonthPage() {
    Navigator.pushNamed(
        context,
        '/invoice-month-page',
        arguments: house
    );
  }
  navigateToCollectInvoicePage() {
    Navigator.pushNamed(
        context,
        '/collect-invoice-page',
        arguments: house
    );
  }
  navigateToExpensePage() {
    Navigator.pushNamed(
        context,
        '/expense-page',
        arguments: house
    );
  }
  navigateToReportPage() {
    Navigator.pushNamed(
        context,
        '/report-page',
        arguments: house
    );
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
                  Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => navigateToInvoiceMonthPage(),
                        style: TextButton.styleFrom(backgroundColor: Colors.blue),
                        child: const Text(
                          "Hóa Đơn",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ))),
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () => navigateToCollectInvoicePage() ,
                            style: TextButton.styleFrom(backgroundColor: Colors.deepPurpleAccent),
                            child: const Text(
                              "Thu Tiền",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ))),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => navigateToExpensePage(),
                        style: TextButton.styleFrom(backgroundColor: Colors.indigo),
                        child: const Text("Chi Phí",
                          textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,)),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => navigateToReportPage(),
                        style: TextButton.styleFrom(backgroundColor: Colors.blueGrey),
                        child: const Text("Báo Cáo",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),),
                      ),
                    ),
                    ],
                  ),

                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredItems?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            margin: const EdgeInsets.only(
                              top: 25,
                            ),
                            child: RoomItem(
                                room: filteredItems![index],
                                navigateToInvoicePage: () =>
                                    navigateToInvoicePage(
                                        filteredItems![index]),
                                editFuntion: () =>
                                    editDialog(filteredItems![index], index),
                                removeFuntion: () => removeRoom(index)));
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
                    right: 300,
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
      child: TextField(
        controller: _searchController,
        decoration: const InputDecoration(
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
