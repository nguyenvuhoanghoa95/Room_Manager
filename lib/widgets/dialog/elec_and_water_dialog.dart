import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:room_manager/constants/colors.dart';
import '../button/my_button.dart';

class ElecAndWaterDialog extends StatelessWidget {

  final electricPriceController;
  final waterPriceController;
  final VoidCallback? edit;
  final VoidCallback? cancel;

  const ElecAndWaterDialog({super.key, required this.edit, required this.cancel, this.electricPriceController, this.waterPriceController});

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
              controller: electricPriceController,
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
            TextField(
              controller: waterPriceController,
              decoration: InputDecoration(
                labelText: 'Đơn Giá Nước',
                filled: true,
                fillColor: Colors.white,
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
                        text: "Lưu", color: Colors.green,onPressed: () => edit!())),
                const SizedBox(
                  width: 40,
                ),
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