import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:room_manager/constants/colors.dart';
import 'package:room_manager/model/invoice.dart';
import 'package:room_manager/model/room.dart';
import 'package:room_manager/widgets/appbar/invoice_appbar.dart';
import 'package:room_manager/widgets/dialog/note_dialog.dart';

class InvoiceCreatePage extends StatefulWidget {
  const InvoiceCreatePage({super.key});

  @override
  State<InvoiceCreatePage> createState() => _InvoiceCreatePage();
}

class _InvoiceCreatePage extends State<InvoiceCreatePage> {
  Room? room;
  Invoice? invoice;
  final _formKey = GlobalKey<FormState>();
  String currentPayment = '';
  String note = '';
  String crrElecNum = '';
  String crrWarNum = '';
  String newElecNum = '';
  String newWarNum = '';
  TextEditingController? _dateController;
  TextEditingController? _amoutController;
  TextEditingController? _crrElecNumController;
  TextEditingController? _crrWarNumController;
  TextEditingController? _newElecNumController;
  TextEditingController? _newWarNumController;
  TextEditingController? _calculationController;
  TextEditingController? _resultController;
  TextEditingController? _netAmountController;
  TextEditingController? _diffAmountController;
  TextEditingController? _ownAmountController;
  TextEditingController? _noteController;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      setState(() {
        var agument = ModalRoute.of(context)!.settings.arguments;
        if (agument is Room) {
          room = agument;
          invoice = Invoice.createInvoice(room!);
        } else {
          invoice = agument as Invoice?;
        }
      });
    });
  }

  Future<void> selectDate() async {
    var pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (pickerDate != null) {
      setState(() {
        _dateController?.text = pickerDate.toString().split(" ")[0];
      });
    }
  }

  addNote(BuildContext context) async {
    _noteController = TextEditingController();

    final result = await showDialog(
        context: context, builder: (context) => NoteDialog(note: note));
    if (result != null && result is String) {
      setState(() {
        note = result;
        _noteController?.text = result;
      });
    }
  }

  onEdit() {
    _calculationController = TextEditingController();
    _resultController = TextEditingController();
    _calculationController?.text = "";

    if (crrElecNum != "" &&
        crrWarNum != "" &&
        newElecNum != "" &&
        newWarNum != "") {
      int electricityConsumed = int.parse(newElecNum) -
          int.parse(crrElecNum);
      int warterConsumed = int.parse(newWarNum) -
          int.parse(crrWarNum);
      setState(() {
        _calculationController?.text =
            "Số điện đã sử dụng : $electricityConsumed \n"
            "Số nước đã sử dụng : $warterConsumed \n";
        _resultController?.text =
            "Tiền điện là : ${electricityConsumed * 3500} \n"
            "Tiền nước là : ${warterConsumed * 17000}";
      });
    }
  }

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
                            onEditingComplete: () {
                              onEdit();
                            },
                              onChanged: (value) {
                                crrElecNum = value;
                              },
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
                            onEditingComplete: () {
                              onEdit();
                            },
                              onChanged: (value) {
                                crrWarNum = value;
                              },
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
                            onChanged: (value) {
                              newElecNum = value;
                            },
                            onEditingComplete: () {
                              onEdit();
                            },
                            controller: _newElecNumController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Số điện mới',
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'x 3500/kWh',
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
                            onChanged: (value) {
                              newWarNum = value;
                            },
                            onEditingComplete: () {
                              onEdit();
                            },
                            controller: _newWarNumController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Số nước mới',
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'x 17000đ/khối',
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
                Visibility(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 5,
                          child: TextFormField(
                              maxLines: null,
                              controller: _calculationController,
                              enabled: false,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ]),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "=",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                              maxLines: null,
                              controller: _resultController,
                              enabled: false,
                              keyboardType: TextInputType.number,
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
                            controller: _netAmountController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Tiền mạng',
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
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextFormField(
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
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
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
                    onTap: () => addNote(context),
                    readOnly: true,
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
                      onPressed: () {},
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
                        // const SizedBox(width: 10,),
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
