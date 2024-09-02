import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:room_manager/constants/colors.dart';
import 'package:room_manager/widgets/button/my_button.dart';

class ExpenseDialog extends StatefulWidget {
  final VoidCallback? create;
  final VoidCallback cancel;
  final VoidCallback? edit;

  final typeExpenseController;
  final typeOtherExpenseController;
  final expenseAmount;
  final datePickerController;


  const ExpenseDialog({
    super.key,
    this.create,
    this.edit,
    required this.cancel,
    required this.typeExpenseController,
    required this.typeOtherExpenseController,
    required this.expenseAmount,
    required this.datePickerController,


  });

  @override
  State<StatefulWidget> createState() => _ExpenseDialog();
}

class _ExpenseDialog extends State<ExpenseDialog> {
  late VoidCallback? create;
  late VoidCallback cancel;
  late VoidCallback? edit;
  late final _datePickerController = widget.datePickerController;
  late final _typeExpenseController = widget.typeExpenseController;
  late final _typeOtherExpenseController = widget.typeOtherExpenseController;
  late final _expenseAmount = widget.expenseAmount;
  DateTime selectedDate = DateTime.now();
  final List<String> _listExpense =[];
  var isShowOtherType = false;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    edit = widget.edit;
    create = widget.create;
    cancel = widget.cancel;
    _listExpense.add("Cước wifi");
    _listExpense.add("Điện");
    _listExpense.add("Nước");
    _listExpense.add("Rác");
    _listExpense.add("Thuê nhà");
    _listExpense.add("Phí CA");
    _listExpense.add("Vệ sinh");
    _listExpense.add("Khác");
    if (_typeExpenseController.value == "") {
      _typeExpenseController.value = _listExpense.first;
    } else if (_typeExpenseController.value == "Khác"){
      isShowOtherType = true;
    }
  }

  Future<void> selectDate() async {
    var pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (pickerDate != null) {
      setState(() {
        _datePickerController.text = pickerDate.toString().split(" ")[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: tbBGColor,
      content: SizedBox(
        height: isShowOtherType? 400:350,
        width: 500,
        child: Form(
        key: _formKey,
          child:ListView(
          children: [
            //title
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Thêm Chi Phí',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            //text to input value
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomDropdown<String>(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập thông tin';
                  }
                  return null;
                },
                controller: _typeExpenseController,
                hintText: 'Chọn chi phi',
                items: _listExpense,
                onChanged: (value) {
                  _typeExpenseController.value = value;
                  setState(() {
                    if(value == "Khác") {
                      isShowOtherType = true;
                    } else {
                      isShowOtherType = false;
                      _typeOtherExpenseController.clear();
                    }
                  });
                },
              ),
            ),
            Visibility(
              visible: isShowOtherType == true,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _typeOtherExpenseController,
                  decoration: InputDecoration(
                    labelText: 'Chi phí khác',
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập thông tin';
                  }
                  return null;
                },
                controller: _expenseAmount,
                decoration: InputDecoration(
                  labelText: 'Số tiền',
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'VD: 1.000.000',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.number,
                  inputFormatters: [
                    ThousandsFormatter(),
                  ]
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập thông tin';
                  }
                  return null;
                },
                controller: _datePickerController,
                decoration: InputDecoration(
                    labelText: 'Ngày chi',
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
                      )),
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
