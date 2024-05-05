import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:room_manager/constants/colors.dart';
import 'package:room_manager/widgets/button/my_button.dart';

class RoomDialog extends StatefulWidget {
  final VoidCallback? create;
  final VoidCallback cancel;
  final VoidCallback? edit;

  final roomNameController;
  final datePickerController;
  final renterController;

  const RoomDialog({
    super.key,
    this.create,
    this.edit,
    required this.cancel,
    required this.roomNameController,
    required this.datePickerController,
    required this.renterController,
  });

  @override
  State<StatefulWidget> createState() => _RoomDialog();
}

class _RoomDialog extends State<RoomDialog> {
  late VoidCallback? create;
  late VoidCallback cancel;
  late VoidCallback? edit;
  late final  _dateController = widget.datePickerController ;
  late final  _roomNameController = widget.roomNameController;
  late final  _renterController = widget.renterController;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    edit = widget.edit;
    create = widget.create;
    cancel = widget.cancel;
  }

  Future<void> selectDate() async {
      var pickerDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100));
      if (pickerDate != null) {
        setState(() {
          _dateController.text = pickerDate.toString().split(" ")[0];
        });
      }
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
              'Thêm Phòng',
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            //text to input value
            TextField(
              controller: _roomNameController,
              decoration: InputDecoration(
                labelText: 'Tên Phòng',
                filled: true,
                fillColor: Colors.grey[200],
                hintText: 'VD: 01,2A',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),

            TextField(
              controller: _dateController,
              decoration: InputDecoration(
                  labelText: 'Ngày thu tiền',
                  filled: true,
                  fillColor: Colors.grey[200],
                  prefixIcon: const Icon(Icons.calendar_today),
                  hintText: 'VD: 03/12/2023',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue))),
              readOnly: true,
              onTap: () {
                selectDate();
              },
            ),
            TextField(
              controller: _renterController,
              decoration: InputDecoration(
                labelText: 'Tên người thêu',
                filled: true,
                fillColor: Colors.grey[200],
                hintText: 'VD: Nguyễn Văn A',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            //button --> save and close
            Row(
              children: [
                // save button
                Expanded(
                    child: MyButton(
                        text: "Lưu", color: tbBlue, onPressed: () =>  create != null ? create!() : edit!())),
                const SizedBox(
                  width: 40,
                ),
                // close button
                Expanded(
                    child: MyButton(
                        text: "Hủy", color: tdRed, onPressed: ()=> cancel())),
              ],
            )
          ],
        ),
      ),
    );
  }
}
