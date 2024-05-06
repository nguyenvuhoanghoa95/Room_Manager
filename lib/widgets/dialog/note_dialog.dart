import 'package:flutter/material.dart';
import 'package:room_manager/constants/colors.dart';
import '../button/my_button.dart';

class NoteDialog extends StatefulWidget {

  String? note;
  NoteDialog({super.key,this.note});

  @override
  State<NoteDialog> createState() => _NoteDialogState();
}

class _NoteDialogState extends State<NoteDialog> {
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      _noteController.text = widget.note!;
    });
  }
  
  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

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
              controller: _noteController,
              decoration: InputDecoration(
                isCollapsed: true,
                filled: true,
                fillColor: Colors.grey[200],
                hintText: widget.note == "" ? 'Viết ghi chú ở đây....': '',
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
                        text: "Lưu",
                        color: Colors.purple,
                        onPressed: (){
                          Navigator.pop(context,_noteController.text);
                        })),
                const SizedBox(
                  width: 40,
                ),
                // close button
                Expanded(
                    child: MyButton(
                        text: "Hủy",
                        color: Colors.purple,
                        onPressed: () => Navigator.of(context).pop())),
              ],
            )
          ],
        ),
      ),
    );
  }
}
