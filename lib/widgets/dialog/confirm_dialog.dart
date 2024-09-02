import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:room_manager/constants/colors.dart';
import '../button/my_button.dart';

class ConfirmDialog extends StatelessWidget {
  final infoController;
  final VoidCallback? cancel;

  const ConfirmDialog({super.key, this.cancel, this.infoController});


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: tbBGColor,
      content: SizedBox(
        height: 350,
        width: 400,
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
              controller: infoController,
              decoration: InputDecoration(
                labelText: 'Đơn Giá Điện',
                filled: true,
                fillColor: Colors.white,
                hintText: 'VD: 3500',
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

                // close button
                Expanded(
                    child: MyButton(
                        text: "Hủy", color: Colors.green,onPressed: () => cancel!())),
              ],
            )
          ],
        ),
      ),
    );
  }
}