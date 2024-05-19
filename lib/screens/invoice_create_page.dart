import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:room_manager/constants/colors.dart';
import 'package:room_manager/database/database_setting.dart';
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

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        var agument = ModalRoute.of(context)!.settings.arguments;
        if (agument is Room) {
          room = agument;
          invoice = Invoice.createInvoice(room!);
          _amoutController.text = '${invoice!.amountAlreadyPay ?? ""}';
          helper = InvoiceHelper.createWithAgument(InvoiceAguments(
            room!,invoice!
          ));
        } else {
          invoice = agument as Invoice?;
        }
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
    _ownAmountController.dispose();
    _noteController.dispose();
    _newWarNumController.dispose();
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
    room!.currentElectricityNumber = int.parse(_newElecNumController.text);
    invoice!.newWaterNumber = int.parse(_newWarNumController.text);
    room!.currentWaterNumber = int.parse(_newWarNumController.text);
    invoice!.amountOwed = _ownAmountController.text.isNotEmpty
        ? int.parse(_ownAmountController.text)
        : 0;
    invoice!.amountAlreadyPay = int.parse(_amoutController.text);
    invoice!.surcharge = _diffAmountController.text.isNotEmpty
        ? int.parse(_diffAmountController.text)
        : 0;
    invoice!.invoiceCreateDate = DateTime.parse(_dateController.text);
    invoice!.totalAmount = helper?.caculateTotalAmount();
    //Create
    create();
  }

  create() {
    invoiceBox.add(invoice!);
    room!.invoices.add(invoice!);
    room!.save();
    navigateToBillPage();
  }

  //navigate to bill page
  navigateToBillPage() async {
    Navigator.pushReplacementNamed(context, '/invoice-page/bill', arguments:InvoiceAguments(room!,invoice!));
  }

  // onEdit() {
  //   _calculationController = TextEditingController();
  //   _calculationController?.text = "";
  //   if (crrElecNum != "" &&
  //       crrWarNum != "" &&
  //       newElecNum != "" &&
  //       newWarNum != "") {
  //     setState(() {
  //       totalAmount = helper.caculateCostOfElecAndWater(
  //           crrElecNum,
  //           crrWarNum,
  //           newElecNum,
  //           newWarNum,
  //           electricityConsumed,
  //           warterConsumed,
  //           room!,
  //           costList);
  //     });
  //   } else {
  //     setState(() {
  //       costList = [];
  //       totalAmount = 0;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const InvoiceAppBar(
        title: "Thêm hóa đơn",
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
                        return 'Vui lòng nhập thông tin';
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
                    // onChanged: (value) {
                    //   if (value.isNotEmpty) {
                    //     // _controller.value = _controller.value.copyWith(
                    //     //   text: _currencyFormatter.format(double.parse(value.replaceAll(',', ''))),
                    //     //   selection: TextSelection.collapsed(offset: _controller.value.text.length),
                    //     // );
                    //   }
                    // },
                    controller: _amoutController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Tiền phòng',
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'VD: 01,2A',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
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
                              // onEditingComplete: () {
                              //   onEdit();
                              // },
                              // onChanged: (value) {
                              //   _crrElecNumController!.text = value;
                              // },
                              controller: _crrElecNumController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Số điện hiện tại',
                                filled: true,
                                fillColor: Colors.white,
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Vui lòng nhập thông tin';
                                }
                                return null;
                              },
                              // onEditingComplete: () {
                              //   onEdit();
                              // },
                              // onChanged: (value) {
                              //   crrWarNum = value;

                              controller: _crrWarNumController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Số nước hiện tại',
                                filled: true,
                                fillColor: Colors.white,
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
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Vui lòng nhập thông tin';
                              } else if (room!.currentElectricityNumber != 0 &&
                                  room!.currentElectricityNumber -
                                          int.parse(value) >
                                      0) {
                                return "Số điện cũ : ${room!.currentElectricityNumber == 0 ? "" : room!.currentElectricityNumber}\nvui lòng nhập lại";
                              } else if (_crrElecNumController
                                      .text.isNotEmpty &&
                                  int.parse(_crrElecNumController.text) -
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
                              hintText: 'Cũ : ${room?.currentElectricityNumber}',
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Vui lòng nhập thông tin';
                              } else if (room!.currentWaterNumber != 0 &&
                                  room!.currentWaterNumber - int.parse(value) >
                                      0) {
                                return "Số nước cũ : ${room!.currentWaterNumber == 0 ? "" : room!.currentWaterNumber}\nvui lòng nhập lại";
                              } else if (_crrWarNumController.text.isNotEmpty &&
                                  int.parse(_crrWarNumController.text) -
                                          int.parse(value) >
                                      0) {
                                return "Số nước thấp hơn số cũ \nvui lòng nhập lại";
                              }
                              return null;
                            },
                            controller: _newWarNumController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Số nước mới',
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Cũ : ${room?.currentWaterNumber}',
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập thông tin';
                        }
                        return null;
                      },
                      controller: _diffAmountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Thu khác',
                        filled: true,
                        fillColor: Colors.white,
                        // hintText: 'x 3500/kWh',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      validator: (value) {
                        if (value!.isNotEmpty &&
                            _amoutController.text.isNotEmpty &&
                            int.parse(_amoutController.text) <
                                int.parse(value)) {
                          return 'Tiện nợ không thể lớn hơn tiền phòng';
                        }
                        return null;
                      },
                      controller: _ownAmountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Tiền nợ',
                        filled: true,
                        fillColor: Colors.white,
                        // hintText: 'x 3500/kWh',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ]),
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
                  visible: room != null,
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
                        minimumSize:
                            MaterialStateProperty.all(const Size(150, 60)),
                        elevation: MaterialStateProperty.all(0),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      child: const Text(
                        "Tính Tiền",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: room == null,
                  child: Row(
                    children: [
                      Radio(
                        value: 'final-pay1',
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
                          setState(() {
                            currentPayment = value!;
                          });
                        },
                      ),
                      const Text('Thanh toán thiếu'),
                    ],
                  ),
                ),
                Visibility(
                  visible: room == null,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Visibility(
                      visible: currentPayment.isNotEmpty &&
                          currentPayment == 'partial-pay',
                      child: TextFormField(
                          enabled: false,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Số tiền còn nợ',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ]),
                    ),
                  ),
                ),
                Visibility(
                  visible: room == null,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(const Size(150, 60)),
                            elevation: MaterialStateProperty.all(0),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                          child: const Text(
                            "Hủy",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(const Size(150, 60)),
                            elevation: MaterialStateProperty.all(0),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                          child: const Text(
                            "Lưu",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
