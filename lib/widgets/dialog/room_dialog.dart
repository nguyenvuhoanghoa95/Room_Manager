import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:room_manager/constants/colors.dart';
import 'package:room_manager/widgets/button/my_button.dart';

class RoomDialog extends StatefulWidget {
  final VoidCallback? create;
  final VoidCallback cancel;
  final VoidCallback? edit;

  final roomNameController;
  final datePickerController;
  final renterController;
  final electricNumber;
  final waterNumber;
  final datePayController;
  final telephoneController;
  final numPersonController;
  final depositAmountController;

  const RoomDialog({
    super.key,
    this.create,
    this.edit,
    required this.cancel,
    required this.roomNameController,
    required this.datePickerController,
    required this.renterController,
    this.electricNumber,
    this.waterNumber,
    this.datePayController,
    this.telephoneController,
    this.numPersonController,
    this.depositAmountController
  });

  @override
  State<StatefulWidget> createState() => _RoomDialog();
}

class _RoomDialog extends State<RoomDialog> {
  late VoidCallback? create;
  late VoidCallback cancel;
  late VoidCallback? edit;
  late final _dateController = widget.datePickerController;
  late final _roomNameController = widget.roomNameController;
  late final _renterController = widget.renterController;
  late final _electricNumberController = widget.electricNumber;
  late final _waterNumberController = widget.waterNumber;
  DateTime selectedDate = DateTime.now();
  late final _datePayController = widget.datePayController;
 // late final _telephoneController = widget.telephoneController;
  late final _numPersonController = widget.numPersonController;
  late final _depositController = widget.depositAmountController;
  final _formKey = GlobalKey<FormState>();

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
        height: _electricNumberController != null ? 700 : 540,
        width: _electricNumberController != null ? 620 : 500,
        child: Form(
            key: _formKey,
            child: ListView(
            children: [
              //title
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Thêm Phòng',
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              //text to input value
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập thông tin';
                    }
                    return null;
                  },
                  controller: _roomNameController,
                  decoration: InputDecoration(
                    labelText: 'Phòng Số',
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'VD: 01,2A',
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
                child: TextFormField(
                  controller: _dateController,
                  decoration: InputDecoration(
                      labelText: 'Ngày thuê',
                      filled: true,
                      fillColor: Colors.white,
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
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _renterController,
                  decoration: InputDecoration(
                    labelText: 'Tên người thuê',
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'VD: Nguyễn Văn A',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      controller: _depositController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Tiền đặt cọc',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      inputFormatters: [
                        ThousandsFormatter(),
                      ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _datePayController,
                  decoration: InputDecoration(
                    labelText: 'Ngày thanh toán',
                    filled: true,
                    fillColor: Colors.white,
                    hintText: '1',
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
                  controller: _numPersonController,
                  decoration: InputDecoration(
                    labelText: 'Số người ở',
                    filled: true,
                    fillColor: Colors.white,
                    hintText: '1',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),

              Visibility(
                visible: _electricNumberController != null,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _electricNumberController,
                    decoration: InputDecoration(
                      labelText: 'Số điện hiện tại',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                 visible: _waterNumberController != null,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _waterNumberController,
                    decoration: InputDecoration(
                      labelText: 'Số nước hiện tại',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
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
                            onPressed: () => {
                              if (_formKey.currentState!.validate()) {
                                create != null ? create!() : edit!()
                              }
                            }
                                //create != null ? create!() : edit!()
                        )
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    // close button
                    Expanded(
                        child: MyButton(
                            text: "Hủy",
                            color: Colors.green,
                            onPressed: () => cancel())),
                  ],
                ),
              )
            ],
        ),
      ),
    ),
    );
  }
}
