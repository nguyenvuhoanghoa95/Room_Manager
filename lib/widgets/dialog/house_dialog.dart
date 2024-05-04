import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:room_manager/constants/colors.dart';
import 'package:room_manager/widgets/button/my_button.dart';

class HouseDialog extends StatelessWidget {
  final addressController;
  final nameOwnerController;
  final availableRoomsController;
  final electricityPriceController;
  final waterPriceController;

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
      this.waterPriceController});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: tbBGColor,
      content: SizedBox(
        height: 500,
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
                controller: addressController,
                decoration: InputDecoration(
                  labelText: 'Địa chỉ',
                  filled: true,
                  fillColor: Colors.grey[200],
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
                controller: nameOwnerController,
                decoration: InputDecoration(
                  labelText: 'Người thêu',
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: 'VD: Nguyễn Văn A,B',
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
                controller: availableRoomsController,
                decoration: InputDecoration(
                  labelText: 'Số lượng phòng',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: electricityPriceController,
                decoration: InputDecoration(
                  labelText: 'Giá điện',
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: 'Mặc định : 3500đ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: waterPriceController,
                decoration: InputDecoration(
                  labelText: 'Giá nước',
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: 'Mặc định: 17000',
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
                        text: "Lưu",
                        color: tbBlue,
                        onPressed: () => create != null ? create!() : edit!())),
                const SizedBox(
                  width: 40,
                ),
                // close button
                Expanded(
                    child:
                        MyButton(text: "Hủy", color: tdRed, onPressed: cancel)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
