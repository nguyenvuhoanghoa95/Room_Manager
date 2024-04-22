import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:room_manager/constants/colors.dart';
import 'package:room_manager/widgets/button/my_button.dart';

class HouseDialog extends StatelessWidget {

  final addressController;
  final nameOwnerController;
  final availableRoomsController;
  final electricityPriceController;
  final waterPriceController;

  VoidCallback create; 
  VoidCallback cancel;


  HouseDialog({super.key , required this.create, required this.cancel, this.addressController, this.nameOwnerController, this.availableRoomsController, this.electricityPriceController, this.waterPriceController});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: tbBGColor,
      content: Container(
        height: 600,
        width: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //title
            const Text(
                'House information',
                style: TextStyle(fontSize: 18.0,color: Colors.black,fontWeight: FontWeight.bold),
              ),
            //text to input value
            TextField(
              controller: addressController,
              decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              hintText: 'Address',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
                ),
              ),
            ),
            TextField(
              controller: nameOwnerController,
              decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              hintText: 'Name owner',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
                ),
              ),
            ),
            TextField(
              controller: availableRoomsController,
              decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              hintText: 'Available rooms',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
             TextField(
              controller: electricityPriceController,
              decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              hintText: 'Electricity Price',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
             TextField(
              controller: waterPriceController,
              decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              hintText: 'Water Price',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
                ),
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