import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:room_manager/constants/colors.dart';
import 'package:room_manager/database/database_setting.dart';
import 'package:room_manager/model/house.dart';
import 'package:room_manager/model/expense.dart';
import 'package:room_manager/widgets/appbar/expense_appbar.dart';
import 'package:room_manager/widgets/dialog/expense_dialog.dart';
import 'package:room_manager/widgets/expense/expense_item.dart';
import 'package:room_manager/model/monthyear.dart';

import '../model/invoice.dart';
import '../model/room.dart';
import '../util/date_helper.dart';
import '../util/invoice_aguments.dart';
import '../widgets/appbar/invoice_month_appbar.dart';
import '../widgets/room/room_invoice_item.dart';

class InvoiceMonthPage extends StatefulWidget {
  const InvoiceMonthPage({super.key});

  @override
  State<InvoiceMonthPage> createState() => _InvoiceMonthPageState();
}

class _InvoiceMonthPageState extends State<InvoiceMonthPage> {
  House? house;
  List<Room>? lstInvoiceRooms = [];
  List<Room>? lstNoInvoiceRooms = [];
  MonthYear? _searchMonthYear;
  final _searchController = TextEditingController();
  final _dateHelper = DateHelper.createWithArgument(DateTime.now());

  List<MonthYear> _list =[];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      house = ModalRoute.of(context)!.settings.arguments as House?;
      setState(() {
        _list = _dateHelper.getListMonthYear();
        _searchMonthYear ??= _dateHelper.getMonthYear();
        lstInvoiceRooms =  List<Room>.from(house!.rooms)
            .where((room) => room.invoices.where((inv) => inv.invoiceCreateDate?.month == int.parse(_searchMonthYear!.month)).isNotEmpty)
            .toList();
        lstNoInvoiceRooms =  List<Room>.from(house!.rooms)
            .where((room) => room.invoices.where((inv) => inv.invoiceCreateDate?.month == int.parse(_searchMonthYear!.month)).isEmpty)
            .toList();
      });
    });
    _searchController.addListener(_filterItems);
  }

  void _filterItems() {
    setState(() {
      lstInvoiceRooms =  List<Room>.from(house!.rooms)
          .where((room) => room.invoices.where((inv) => inv.invoiceCreateDate?.month == int.parse(_searchMonthYear!.month)).isNotEmpty)
          .toList();
      lstNoInvoiceRooms =  List<Room>.from(house!.rooms)
          .where((room) => room.invoices.where((inv) => inv.invoiceCreateDate?.month == int.parse(_searchMonthYear!.month)).isEmpty)
          .toList();
    });
  }

  //Navigate to invoicePage
  navigateToInvoicePage(Invoice inv) {
    Room rm;
    Navigator.pushNamed(context, '/invoice-page/create', arguments: inv);
  }

  navigateToCreateInvoicePage(Room rm) {
    Navigator.pushNamed(context, '/invoice-page/create', arguments: rm);
  }
  List<int> top = <int>[];
  List<int> bottom = <int>[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tbBGColor,
      appBar: const InvoiceMonthAppbar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Column(
                children: [
                  //searchExpense(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: (lstInvoiceRooms?.length ?? 0)+(lstNoInvoiceRooms?.length ?? 0),
                      itemBuilder: (BuildContext context, int index) {

                      if (index <lstNoInvoiceRooms!.length) {
                        return Container(
                            margin: const EdgeInsets.only(
                            top: 15,),
                            child: RoomNoInvoiceItem(
                                room: lstNoInvoiceRooms![index],
                                navigateToInvoicePage: () =>
                                    navigateToCreateInvoicePage(
                                        lstNoInvoiceRooms![index])));
                        } else {
                          return Container(
                            margin: const EdgeInsets.only(top: 15,),
                              child:RoomInvoiceItem(
                                  room: lstInvoiceRooms![index-lstNoInvoiceRooms!.length],
                                  navigateToInvoicePage: () =>
                                      navigateToInvoicePage(
                                          lstInvoiceRooms![index-lstNoInvoiceRooms!.length].invoices.last)));
                        }

                      },
                    ),
                  ),
                ],
              )
          ),

        ],
      ),
    );
  }

  Widget searchExpense() {
    return CustomDropdown<MonthYear>(
      hintText: 'Chọn tháng năm',
      items: _list,
      onChanged: (value) {
        _searchMonthYear = value;
        _searchController.text = value.toString();
      },
    );
  }

}
