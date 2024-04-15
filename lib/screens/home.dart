import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../widgets/todo_item.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> items = [
      'Item 1',
      'Item 2',
      'Item 3',
      'Item 4',
      'Item 5'
    ];
// children: [
    //                       Container(
    //                         margin: EdgeInsets.only(
    //                           top: 50,
    //                           bottom: 20,
    //                         ),
    //                         child: Text(
    //                           "All ToDos",
    //                           style: TextStyle(
    //                             fontSize: 30,
    //                             fontWeight: FontWeight.w500,
    //                           ),
    //                         ),
    //                       ),
    //                       ToDoItem(),
    //                       ToDoItem(),
    //                       ToDoItem(),
    //                       ToDoItem(),
    //                       ToDoItem(),
    //                       ToDoItem(),
    //                       ToDoItem(),
    //                     ],
    return Scaffold(
      backgroundColor: tbBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                children: [
                  searchBox(),
                  Container(
                    margin: EdgeInsets.only(
                      top: 50,
                      bottom: 5,),
                    child: Text(
                      "List House Location",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            margin: EdgeInsets.only(
                              top: 25,
                            ),
                            child: ToDoItem());
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
                // Expanded(
                //   child: Container(
                //   margin: EdgeInsets.only(
                //     bottom: 20,
                //     right: 20,
                //     left: 20,
                //   ),
                //   padding: EdgeInsets.symmetric(
                //     horizontal: 20,
                //     vertical: 5,
                //   ),
                //   decoration: BoxDecoration(
                //     color: Colors.grey,
                //     boxShadow: const [BoxShadow(
                //       color: Colors.grey,
                //       offset: Offset(0.0, 0.0),
                //       blurRadius: 10.0,
                //       spreadRadius: 0.0,
                //     ),],
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                //   child: TextField(
                //     decoration: InputDecoration(
                //       hintText: 'Add new item',
                //       border: InputBorder.none,
                //     ),
                //   ),
                // ),),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      '+',
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      alignment: Alignment.bottomLeft,
                      minimumSize: Size(60, 60),
                      elevation: 10,
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

  AppBar _buildAppBar() {
    return AppBar(
        backgroundColor: tbBGColor,
        title:
            const Row(children: [Icon(Icons.menu, color: tbBlack, size: 30)]));
  }
}
