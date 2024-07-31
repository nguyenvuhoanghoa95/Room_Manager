import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:room_manager/constants/colors.dart';
import 'package:room_manager/constants/const.dart';
import 'package:room_manager/database/database_setting.dart';
import 'package:room_manager/model/debit.dart';
import 'package:room_manager/model/invoice.dart';
import 'package:room_manager/model/room.dart';
import 'package:room_manager/util/invoice_aguments.dart';
import 'package:room_manager/util/invoice_helper.dart';
import 'package:room_manager/widgets/appbar/invoice_appbar.dart';

class InvoiceCreatePage extends StatefulWidget {
  const InvoiceCreatePage({super.key});

  @override
  State<InvoiceCreatePage> createState() => _InvoiceCreatePage();
}

class _InvoiceCreatePage extends State<InvoiceCreatePage> {
  Room? room;
  Invoice? invoice;
  final _formKey = GlobalKey<FormState>();
  bool? edit;

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
  final _ownAmountController = TextEditingController();
  final _noteController = TextEditingController();
  final _newWarNumController = TextEditingController();
  final _newWifiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        var argument = ModalRoute.of(context)!.settings.arguments;
        if (argument is Room) {
          edit = false;
          room = argument;
          invoice = Invoice.createInvoice(room!);
          _dateController.text = invoice!.invoiceCreateDate.toString().split(" ")[0];
          _newWifiController.text = invoice!.wifiAmount.toString();
          if (invoice!.amountAlreadyPay != null) {
            _amoutController.text =
                moneyFormat.format(invoice!.amountAlreadyPay);
          }
          helper =
              InvoiceHelper.createWithAgument(InvoiceAguments(room!, invoice!));
        } else {
          edit = true;
          invoice = argument as Invoice?;
          room = roomBox.values.where((room) => room.invoices.contains(invoice)).first;
          helper = InvoiceHelper.createWithAgument(InvoiceAguments(room!, invoice!));
          setInvoiceValue(invoice!);
        }
      });
    });

    // _amoutController.addListener(() {
    //   if (_amoutController.text.isNotEmpty) {
    //     var money = _amoutController.text.replaceAll(",", ".");
    //     var formattedValue = moneyFormat.format(double.parse(money));
    //     _amoutController.text = formattedValue;
    //   }
    // });
  }

  @override
  void dispose() {
    _dateController.dispose();
    _amoutController.dispose();
    _crrElecNumController.dispose();
    _crrWarNumController.dispose();
    _newElecNumController.dispose();
    _diffAmountController.dispose();
    _ownAmountController.dispose();
    _noteController.dispose();
    _newWarNumController.dispose();
    _newWifiController.dispose();
    super.dispose();
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

  saveInvoice() {
    if (invoice!.currentWaterNumber == null) {
      invoice!.currentWaterNumber = int.parse(_crrWarNumController.text);
    }
    if (invoice!.currentElectricityNumber == null) {
      invoice!.currentElectricityNumber = int.parse(_crrElecNumController.text);
    }
    invoice!.newElectricityNumber = int.parse(_newElecNumController.text);

    invoice!.newWaterNumber = int.parse(_newWarNumController.text);
    invoice!.wifiAmount = int.parse(_newWifiController.text.replaceAll(",", ""));
    if (!edit!) {
      room!.currentWaterNumber = int.parse(_newWarNumController.text);
      room!.currentElectricityNumber = int.parse(_newElecNumController.text);
      var debitAmount = _ownAmountController.text.isEmpty
          ? "0"
          : _ownAmountController.text.replaceAll(",", "");
      var newDebit = Debit(int.parse(debitAmount), true);
      debitBox.add(newDebit);
      invoice!.debit?.add(newDebit);
    } else {
      var debit = invoice!.debit;
      if (debit!.isNotEmpty) {
        if (debit[0].amount! >
            int.parse(_ownAmountController.text.replaceAll(",", ""))) {
          debit[0].amount = debit[0].amount! -
              int.parse(_ownAmountController.text.replaceAll(",", ""));
        } else {
          debit[0].amount = 0;
          debit[0].status = true;
        }
        debit[0].save();
      }
    }
    invoice!.amountAlreadyPay =
        int.parse(_amoutController.text.replaceAll(",", ""));
    invoice!.surcharge = _diffAmountController.text.isNotEmpty
        ? int.parse(_diffAmountController.text.replaceAll(",", ""))
        : 0;
    invoice!.invoiceCreateDate = DateTime.parse(_dateController.text);
    invoice!.note = _noteController.text;
    invoice!.totalAmount = helper?.caculateTotalAmount(currentPayment);
    save();
  }

  setInvoiceValue(Invoice invoice) {
    currentPayment = "final-pay";
    _dateController.text = invoice.invoiceCreateDate.toString().split(" ")[0];
    _amoutController.text =
        moneyFormat.format(invoice.amountAlreadyPay).toString();
    _crrElecNumController.text = invoice.currentElectricityNumber.toString();
    _crrWarNumController.text = invoice.currentWaterNumber.toString();
    _newElecNumController.text = invoice.newElectricityNumber.toString();
    _diffAmountController.text =
        moneyFormat.format(invoice.surcharge).toString();
    _ownAmountController.text = invoice.debit!.isNotEmpty
        ? moneyFormat.format(invoice.debit!.first.amount).toString()
        : "0";
    _noteController.text = invoice.note!;
    _newWarNumController.text = invoice.newWaterNumber.toString();
    _newWifiController.text = invoice.wifiAmount.toString();
    totalAmount = invoice.totalAmount!;
  }

  save() {
    if (!edit!) {
      invoiceBox.add(invoice!);
      room!.invoices.add(invoice!);
    } else {
      invoice!.save();
    }
    room!.save();
    navigateToBillPage();
  }

  //navigate to bill page
  navigateToBillPage() async {
    Navigator.pushReplacementNamed(context, '/invoice-page/bill',
        arguments: InvoiceAguments(room!, invoice!));
  }

  @override
  Widget build(BuildContext context) {
    return edit != null
        ? Scaffold(
      appBar: InvoiceAppBar(
        title: !edit! ? "Thêm hóa đơn" : "Sửa hóa đơn",
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        //return 'Vui lòng nhập thông tin';
                        // value = DateTime.now();
                      }
                      return null;
                    },
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
                    //_dateController = DateTime.now();
                    onTap: () {
                      selectDate();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập tiền phòng';
                      }
                      return null;
                    },
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
                    inputFormatters: [
                      ThousandsFormatter(),
                    ],
                  ),
                ),
                Visibility(
                  visible: invoice?.currentElectricityNumber == null &&
                      invoice?.currentWaterNumber == null,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Vui lòng nhập thông tin';
                                }
                                return null;
                              },
                              controller: _crrElecNumController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Số điện hiện tại',
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ]),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                              controller: _crrWarNumController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Số nước hiện tại',
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TextFormField(
                            validator: (value) {
                              if (edit!) {
                                return null;
                              } else if (value == null || value.isEmpty) {
                                return 'Vui lòng nhập thông tin';
                              } else if (room!.currentElectricityNumber !=
                                  0 &&
                                  room!.currentElectricityNumber -
                                      int.parse(value) >
                                      0) {
                                return "Số điện cũ : ${room!.currentElectricityNumber == 0 ? "" : room!.currentElectricityNumber}\nvui lòng nhập lại";
                              } else if (room!.currentElectricityNumber !=
                                  0 &&
                                  room!.currentElectricityNumber -
                                      int.parse(value) >
                                      0) {
                                return "Số điện thấp hơn số cũ \nvui lòng nhập lại";
                              }
                              return null;
                            },
                            controller: _newElecNumController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Số điện mới',
                              filled: true,
                              fillColor: Colors.white,
                              hintText: !edit!
                                  ? 'Cũ : ${room?.currentElectricityNumber}'
                                  : "",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ]),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextFormField(
                            controller: _newWarNumController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Số nước mới',
                              filled: true,
                              fillColor: Colors.white,
                              hintText: !edit!
                                  ? 'Cũ : ${room?.currentWaterNumber}'
                                  : "",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      controller: _newWifiController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Wifi',
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
                  child: TextFormField(
                      controller: _diffAmountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Thu khác',
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

                Visibility(
                  visible: !edit!,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        controller: _ownAmountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Tiền nợ',
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _noteController,
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: 'Ghi chú...',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                Visibility(
                  visible: edit!,
                  child: Row(
                    children: [
                      Radio(
                        value: 'final-pay',
                        groupValue: currentPayment,
                        onChanged: (value) {
                          setState(() {
                            currentPayment = value!;
                          });
                        },
                      ),
                      const Text('Thanh toán đủ'),
                      Radio(
                        value: 'partial-pay',
                        groupValue: currentPayment,
                        onChanged: (value) {
                          if (int.parse(_ownAmountController.text
                              .replaceAll(",", "")) !=
                              0) {
                            setState(() {
                              currentPayment = value!;
                            });
                          } else {
                            return;
                          }
                        },
                      ),
                      const Text('Thanh toán thiếu'),
                    ],
                  ),
                ),
                Visibility(
                  visible: edit!,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        validator: (value) {
                          if (edit! &&
                              (invoice!.debit![0].amount! <
                                  int.parse(
                                      value!.replaceAll(",", "")))) {
                            return "Số tiền phải thanh toán lớn hơn số nợ";
                          }
                          return null;
                        },
                        enabled: currentPayment.isNotEmpty &&
                            currentPayment != 'final-pay',
                        onEditingComplete: onEdit,
                        controller: _ownAmountController,
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
                        "Tính Tiền",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    )
        : const Scaffold();
  }

  void onEdit() {
    if (_ownAmountController.text.isEmpty) {
      setState(() {
        currentPayment = "final-pay";
      });
    }
  }
}
