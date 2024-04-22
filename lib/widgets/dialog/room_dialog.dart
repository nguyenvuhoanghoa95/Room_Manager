import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:room_manager/constants/colors.dart';
import 'package:room_manager/widgets/button/my_button.dart';

class RoomDialog extends StatelessWidget {
  // final addressController;
  // final nameOwnerController;
  // final availableRoomsController;
  // final electricityPriceController;
  // final waterPriceController;

  VoidCallback create;
  VoidCallback cancel;

  RoomDialog(
      {super.key,
      required this.create,
      required this.cancel,
      // this.addressController,
      // this.nameOwnerController,
      // this.availableRoomsController,
      // this.electricityPriceController,
      // this.waterPriceController
      });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: tbBGColor,
      content: Container(
        height: 600,
        width: 500,
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //title
            const Text(
              'Room information',
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            //text to input value
            Container(
              padding: const EdgeInsets.only(top: 20,bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2)
              ),
              child: TextField(
                // controller: addressController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: 'Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.only(top: 10,bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2)
              ),
              child: TextField(
                // controller: nameOwnerController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: 'Renter Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10,bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2)
              ),
              child: TextField(
                // controller: availableRoomsController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: 'Amount',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10,bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2)
              ),
              child: TextField(
                // controller: electricityPriceController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: 'Current Electricity Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10,bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2)
              ),
              child: TextField(
                // controller: waterPriceController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: 'Current Water Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
            //button --> save and close
            Row(
              children: [
                // save button
                Expanded(
                    child: MyButton(
                        text: "Create", color: tbBlue, onPressed: create)),
                const SizedBox(
                  width: 40,
                ),
                // close button
                Expanded(
                    child: MyButton(
                        text: "Cancel", color: tdRed, onPressed: cancel)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
