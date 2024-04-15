import 'package:flutter/material.dart';
import 'package:room_manager/constants/colors.dart';

class ToDoItem extends StatelessWidget {
  const ToDoItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // This function will be called when the container is tapped.
        print('Container tapped!');
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: ListTile(
          onTap: () {},
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          tileColor: Colors.white,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Location Name',
                style: TextStyle(
                  fontSize: 20,
                  color: tbBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Address of location Address of location Address of location Address of location',
                style: TextStyle(
                  fontSize: 15,
                  color: tbBlack,
                ),
              ),
            ],
          ),
          trailing: Container(
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.symmetric(vertical: 6),
            height: 35,
            width: 35,
            decoration: BoxDecoration(
                color: tdRed, borderRadius: BorderRadius.circular(5)),
            child: IconButton(
              color: Colors.white,
              iconSize: 18,
              icon: Icon(Icons.delete),
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }
}
