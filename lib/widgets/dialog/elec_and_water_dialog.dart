import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:room_manager/constants/colors.dart';
import '../button/my_button.dart';

class ElecAndWaterDialog extends StatelessWidget {

  final VoidCallback? create;
  final VoidCallback? cancel;

  const ElecAndWaterDialog({super.key, required this.create, required this.cancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: tbBGColor,
      content: SizedBox(
        height: 400,
        width: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //title
            const Text(
              'Đơn giá Điện - Nước',
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            //text to input value
            TextField(
              // controller: addressController,
              decoration: InputDecoration(
                labelText: 'Đơn Giá Điện',
                filled: true,
                fillColor: Colors.grey[200],
                hintText: 'VD: 3500',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            TextField(
              // controller: availableRoomsController,
              decoration: InputDecoration(
                labelText: 'Đơn Giá Nước',
                filled: true,
                fillColor: Colors.grey[200],
                hintText: 'VD: 17000',
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
                Expanded(
                    child: MyButton(
                        text: "Create", color: Colors.purple,onPressed: (){})),
                const SizedBox(
                  width: 40,
                ),
                // close button
                Expanded(
                    child: MyButton(
                        text: "Cancel", color: Colors.purple,onPressed: () => cancel!())),
              ],
            )
          ],
        ),
      ),
    );
  }
}