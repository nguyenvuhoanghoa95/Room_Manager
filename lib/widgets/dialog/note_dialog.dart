import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:room_manager/constants/colors.dart';
import '../button/my_button.dart';

class NoteDialog extends StatelessWidget {

  final VoidCallback? create;
  final VoidCallback? cancel;

  const NoteDialog({super.key, required this.create, required this.cancel});

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
              'Ghi chú :',
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            TextField(
              minLines: 8,
              maxLines: null,
              decoration: InputDecoration(
                isCollapsed: true,
                filled: true,
                fillColor: Colors.grey[200],
                hintText: 'Viết ghi chú ở đây....',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.multiline,
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