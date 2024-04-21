import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:room_manager/constants/colors.dart';
import 'package:room_manager/widgets/my_button.dart';

class DialogBox extends StatelessWidget {

  final addressController;
  final nameOwnerController;
  final availableRoomsController;

  VoidCallback create; 
  VoidCallback cancel;


  DialogBox({super.key , required this.create, required this.cancel, this.addressController, this.nameOwnerController, this.availableRoomsController});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: tbBGColor,
      content: Container(
        height: 400,
        width: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //title
            const Text(
                'Enter information',
                style: TextStyle(fontSize: 18.0),
              ),
            //text to input value
            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Address"
              ),
            ),
            TextField(
              controller: nameOwnerController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Name Owner"
              ),
            ),
            TextField(
              controller: availableRoomsController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Available Rooms"
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            //button --> save and close
            Row(
              children: [
                // save button 
                Expanded(child: MyButton(text: "Create", color: tbBlue, onPressed: create)),
                const SizedBox(width: 40,),
                // close button
                Expanded(child: MyButton(text: "Cancel",color: tdRed, onPressed: cancel)),
              ],
            )

          ],
        ),
      ),
    );
  }
}