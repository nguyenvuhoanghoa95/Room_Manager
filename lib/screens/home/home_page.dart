import 'package:flutter/material.dart';
import 'package:room_manager/widgets/appbar.dart';
import 'package:room_manager/widgets/dialog_box.dart';
import '../../constants/colors.dart';
import '../../widgets/house_items.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();

  }

  class _HomePageState extends State<HomePage> {

  final _addressController = TextEditingController(); 
  final _nameOwnerController = TextEditingController();
  final _availableRoomsController = TextEditingController();

    List homeList = [
      ["401 Nguyen Van Troi, Phuong 9 , Quan Phu Nhuan",'Nguyen Duazn', 5], 
      ["195 Phan Van Tri, Phuong 12 , Quan Binh Thanh",'Nguyen Duazn', 5],
      ["201 Tran Hung Dao, Phuong 5 , Quan 1",'Hoa Nguyen', 5]
    ];

  //save new home 
  void saveNewHome() {
    setState(() {
      if(_addressController.text.isNotEmpty && _nameOwnerController.text.isNotEmpty && _availableRoomsController.text.isNotEmpty){
      homeList.add([_addressController.text,_nameOwnerController.text,int.parse(_availableRoomsController.text)]);
      _addressController.clear();
      _nameOwnerController.clear();
      _availableRoomsController.clear();
      }
    });
    Navigator.of(context).pop();
  }


  // Create new home 
  void createNewHome(){
    showDialog(
     context: context ,
     builder: (context) {
      return DialogBox(
        addressController: _addressController,
        availableRoomsController: _availableRoomsController,
        nameOwnerController: _nameOwnerController,
        create: saveNewHome, cancel: () => Navigator.of(context).pop(),);
    },);
  }

  // Remove home
   removeHouse(int index){
    setState(() {
      homeList.removeAt(index);
    });
  }


 //Navigate to roompage 
  navigateToRoomPage(context){
    print("TUTU");
     Navigator.pushNamed(
        context,
        '/room-page'
      );
  }

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
                  searchBox(),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 50,
                      bottom: 5,
                    ),
                    child: const Text(
                      "Houses",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: homeList.length,
                      itemBuilder: (BuildContext context, int index) {
                        if(homeList.isNotEmpty){
                          return Container(
                            margin: const EdgeInsets.only(
                              top: 25,
                            ),
                            child: HouseItems(
                              address: homeList[index]?[0],
                              nameOwner: homeList[index]?[1],
                              availableRooms:homeList[index]?[2],
                              removeHouseFuntion:() {
                                removeHouse(index);
                              },
                              navigateToRoomPage: () {
                                navigateToRoomPage(context);
                              },)
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
                    onPressed: () =>  createNewHome(),
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
