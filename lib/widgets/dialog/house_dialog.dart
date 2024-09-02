import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:room_manager/constants/colors.dart';
import 'package:room_manager/widgets/button/my_button.dart';

class HouseDialog extends StatefulWidget {
  final addressController;
  final nameOwnerController;
  final availableRoomsController;
  final electricityPriceController;
  final waterPriceController;
  final waterByPersonController;

  final VoidCallback? create;
  final VoidCallback cancel;
  final VoidCallback? edit;

  const HouseDialog(
      {super.key,
      this.create,
      this.edit,
      required this.cancel,
      this.addressController,
      this.nameOwnerController,
      this.availableRoomsController,
      this.electricityPriceController,
      this.waterPriceController,
      this.waterByPersonController});

  @override
  State<HouseDialog> createState() => _HouseDialogState();
}

class _HouseDialogState extends State<HouseDialog> {

  bool? waterByPerson;
  @override
  void initState() {
    super.initState();
    waterByPerson = bool.parse(widget.waterByPersonController.text);
  }

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      backgroundColor: tbBGColor,
      content: SizedBox(
        height: 380,
        width: 500,
        child: ListView(
          children: [
            //title
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Thông tin nhà',
                style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            //text to input value
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: widget.addressController,
                decoration: InputDecoration(
                  labelText: 'Địa chỉ',
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'VD: 123 Nguyễn Tri Phương....',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: widget.electricityPriceController,
                decoration: InputDecoration(
                  labelText: 'Giá điện',
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Mặc định : 3.500đ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                inputFormatters: [
                  ThousandsFormatter(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: widget.waterPriceController,
                decoration: InputDecoration(
                  labelText: 'Giá nước (tính khối / đầu người)',
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Mặc định: 20.000',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                inputFormatters: [
                  ThousandsFormatter(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Row(
                children: [
                  Radio(
                    value: false,
                    groupValue: waterByPerson,
                    onChanged: (value) {
                      setState(() {
                        widget.waterByPersonController.text = "false";
                        waterByPerson = value;
                      });
                    },
                  ),
                  const Text('Tính khối'),
                  Radio(
                    value: true,
                    groupValue: waterByPerson,
                    onChanged: (value) {
                      setState(() {
                        widget.waterByPersonController.text = "true";
                        waterByPerson = value;
                      });
                    },
                  ),
                  const Text('Đầu người'),
                ],
              ),
            ),
            //button --> save and close
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  // save button
                  Expanded(
                      child: MyButton(
                          text: "Lưu",
                          color: Colors.green,
                          onPressed: () => widget.create != null ? widget.create!() : widget.edit!())),
                  const SizedBox(
                    width: 40,
                  ),
                  // close button
                  Expanded(
                      child:
                          MyButton(text: "Hủy", color: Colors.green, onPressed: widget.cancel)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
