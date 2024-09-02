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
import '../widgets/appbar/invoice_month_appbar.dart';
import '../widgets/invoice/invoice_item.dart';

class CollectInvoicePage extends StatefulWidget {
  const CollectInvoicePage({super.key});

  @override
  State<CollectInvoicePage> createState() => _CollectInvoicePageState();
}

class _CollectInvoicePageState extends State<CollectInvoicePage> {
  House? house;
  List<Invoice>? lstInvoiceCollected = [];
  List<Invoice>? lstInvoiceNoCollected = [];
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
        _updateListInvoices();
      });
    });
    _searchController.addListener(_filterItems);
  }

  void _filterItems() {
    setState(() {
      _updateListInvoices();
    });
  }

  void _updateListInvoices() {
    _searchMonthYear ??= _dateHelper.getMonthYear();
    lstInvoiceCollected?.clear();
    lstInvoiceNoCollected?.clear();
    for(var room in house!.rooms) {
      var lstInvoice =  List<Invoice>.from(room.invoices)
          .where((inv) => inv.invoiceCreateDate?.month == int.parse(_searchMonthYear!.month)
          && inv.debitAmount == 0).toList();
      lstInvoiceCollected?.addAll(lstInvoice);
    }
    for(var room in house!.rooms) {
      var lstInvoice =  List<Invoice>.from(room.invoices)
          .where((inv) => inv.invoiceCreateDate?.month == int.parse(_searchMonthYear!.month)
          && inv.debitAmount != 0).toList();
      lstInvoiceNoCollected?.addAll(lstInvoice);
    }
  }

  //Navigate to invoicePage
  navigateToInvoicePage(Invoice inv) {
    Room rm;
    Navigator.pushNamed(context, '/collect-invoice-dialog', arguments: inv);
  }

  List<int> top = <int>[];
  List<int> bottom = <int>[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tbBGColor,
      appBar: AppBar(
        backgroundColor: tbBGColor,
        centerTitle: true,
        title:const Text(
          "Thu tiền",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Column(
                children: [
                  searchInvoice(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: (lstInvoiceCollected?.length ?? 0)+(lstInvoiceNoCollected?.length ?? 0),
                      itemBuilder: (BuildContext context, int index) {

                      if (index <lstInvoiceNoCollected!.length) {
                        return Container(
                            margin: const EdgeInsets.only(
                            top: 15,
                          ),
                          child: InvoiceItem(
                            invoice: lstInvoiceNoCollected![index],
                            navigateToInvoicePage: () =>
                                navigateToInvoicePage(lstInvoiceNoCollected![index]),
                            removeFuntion: () {},
                            isShowMenu: false,
                          )
                        );
                        } else {
                          return Container(
                            margin: const EdgeInsets.only(top: 15,),
                              child:InvoiceItem(
                                invoice: lstInvoiceCollected![index-lstInvoiceNoCollected!.length],
                                navigateToInvoicePage: () =>
                                    navigateToInvoicePage(
                                        lstInvoiceCollected![index-lstInvoiceNoCollected!.length]),
                                removeFuntion: () {},
                                isShowMenu: false,
                              )
                          );
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

  Widget searchInvoice() {
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
