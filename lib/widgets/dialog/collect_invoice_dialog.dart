import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:room_manager/constants/colors.dart';
import 'package:room_manager/constants/const.dart';
import 'package:room_manager/database/database_setting.dart';
import 'package:room_manager/model/invoice.dart';
import 'package:room_manager/model/room.dart';
import 'package:room_manager/util/invoice_aguments.dart';
import 'package:room_manager/util/invoice_helper.dart';
import 'package:room_manager/widgets/appbar/invoice_appbar.dart';

import '../../model/house.dart';

class CollectInvoiceDialog extends StatefulWidget {
  const CollectInvoiceDialog({super.key});

  @override
  State<CollectInvoiceDialog> createState() => _CollectInvoiceDialog();
}

class _CollectInvoiceDialog extends State<CollectInvoiceDialog> {
  House? house;
  Room? room;
  Invoice? invoice;
  final _formKey = GlobalKey<FormState>();
  //bool? edit;

  // Helper
  InvoiceHelper? helper;

  //Field data
  String currentPayment = '';
  String note = '';
  String crrElecNum = '';
  String crrWarNum = '';
  String newElecNum = '';
  String newWarNum = '';
  String roomAmount = '';
  String ownAmount = '';
  String anotherAmount = '';
  int electricityConsumed = 0;
  int warterConsumed = 0;
  int totalAmount = 0;
  List costList = [];

  //Controller
  final _dateController = TextEditingController();
  final _amoutController = TextEditingController();
  final _crrElecNumController = TextEditingController();
  final _crrWarNumController = TextEditingController();
  final _newElecNumController = TextEditingController();
  final _diffAmountController = TextEditingController();
  final _debtAmountController = TextEditingController();
  final _noteController = TextEditingController();
  final _newWarNumController = TextEditingController();
  final _newWifiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        var argument = ModalRoute.of(context)!.settings.arguments;

        invoice = argument as Invoice?;
        room = roomBox.values.where((room) => room.invoices.contains(invoice)).first;
        house = houseBox.values.where((house) => house.rooms.contains(room)).first;
        helper = InvoiceHelper.createWithArgument(InvoiceArguments(house!, room!, invoice!));
        setInvoiceValue(invoice!);

      });
    });
  }

  @override
  void dispose() {
    _dateController.dispose();
    _amoutController.dispose();
    _crrElecNumController.dispose();
    _crrWarNumController.dispose();
    _newElecNumController.dispose();
    _diffAmountController.dispose();
    _debtAmountController.dispose();
    _noteController.dispose();
    _newWarNumController.dispose();
    _newWifiController.dispose();
    super.dispose();
  }

  saveInvoice() {
    var debitAmount = _debtAmountController.text.isEmpty? "0"
        : _debtAmountController.text.replaceAll(",", "");
    invoice!.debitAmount = int.parse(debitAmount);

    save();
  }

  setInvoiceValue(Invoice invoice) {
    _dateController.text = invoice.invoiceCreateDate.toString().split(" ")[0];
    _amoutController.text =
        moneyFormat.format(invoice.totalAmount).toString();
    _debtAmountController.text = moneyFormat.format(invoice.debitAmount).toString();
    totalAmount = invoice.totalAmount!;
    if (invoice.debitAmount == null || invoice.debitAmount == 0) {
      currentPayment = "final-pay";
    } else {
      currentPayment = "partial-pay";
    }
  }

  save() {
    invoice!.save();
    room!.save();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const InvoiceAppBar(
        title: "Thu tiền",
      ),
      backgroundColor: tbBGColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    enabled: false,
                    controller: _dateController,
                    decoration: InputDecoration(
                        labelText: 'Ngày tạo hoá đơn',
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

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    enabled: false,
                    controller: _amoutController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Tiền phòng',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),

                  ),
                ),

                const SizedBox(
                  width: 10,
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Radio(
                        value: 'final-pay',
                        groupValue: currentPayment,
                        onChanged: (value) {
                          setState(() {
                            currentPayment = value!;
                            _debtAmountController.text = "0";
                          });
                        },
                      ),
                      const Text('Thanh toán đủ'),
                      Radio(
                        value: 'partial-pay',
                        groupValue: currentPayment,
                        onChanged: (value) {
                          setState(() {
                            currentPayment = value!;
                          });
                        },
                      ),
                      const Text('Thanh toán thiếu'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        validator: (value) {
                          if (invoice!.totalAmount! <
                                  int.parse(
                                      value!.replaceAll(",", ""))) {
                            return "Số tiền phải thanh toán lớn hơn số nợ";
                          }
                          return null;
                        },
                        enabled: currentPayment.isNotEmpty &&
                            currentPayment != 'final-pay',
                        onEditingComplete: onEdit,
                        controller: _debtAmountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Số tiền nợ',
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
                ),
                Visibility(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          saveInvoice();
                          // If the form is valid, display a snackbar. In the real world,
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   const SnackBar(content: Text('Processing Data')),
                          // );
                        }
                      },
                      style: ButtonStyle(
                        foregroundColor:
                        WidgetStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                        WidgetStateProperty.all<Color>(Colors.green),
                        minimumSize:
                        WidgetStateProperty.all(const Size(150, 60)),
                        elevation: WidgetStateProperty.all(0),
                        shape: WidgetStateProperty.all<
                            RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      child: const Text(
                        "Lưu",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ));

  }

  void onEdit() {
    if (_debtAmountController.text.isEmpty) {
      setState(() {
        currentPayment = "final-pay";
      });
    }
  }
}
