import 'package:flutter/material.dart';
import 'package:room_manager/database/database_setting.dart';
import 'package:room_manager/model/invoice.dart';
import 'package:room_manager/model/room.dart';
import 'package:room_manager/widgets/appbar/invoice_appbar.dart';
import 'package:room_manager/widgets/invoice/invoice_item.dart';
import '../constants/colors.dart';

class InvoiceManagement extends StatefulWidget {
  const InvoiceManagement({super.key});

  @override
  State<InvoiceManagement> createState() => _InvoiceManagementState();
}

class _InvoiceManagementState extends State<InvoiceManagement> {
  Room? room;
  List<Invoice>? invoices;
  List<Invoice>? filteredItems = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      room = ModalRoute.of(context)!.settings.arguments as Room?;
      setState(() {
        invoices = room!.invoices.toList();
      });
      filteredItems = invoices;
    });
  }

  //Navigate to invoicePage
  navigateToInvoiceCreatePage(Invoice invoice) {
    Navigator.pushNamed(context, '/invoice-page/create', arguments: invoice);
  }

  // Remove invoice
  removeInvoice(int index) {
    var inv = room!.invoices[index];
    invoiceBox.delete(inv.key);
    setState(() {
      invoices = List<Invoice>.from(room!.invoices);
      filteredItems = List<Invoice>.from(room!.invoices);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tbBGColor,
      appBar: InvoiceAppBar(
        room: room,
        title: "Danh sách hóa đơn",
      ),
      body: Stack(
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredItems?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            margin: const EdgeInsets.only(
                              top: 25,
                            ),
                            child: InvoiceItem(
                              invoice: filteredItems![index],
                              navigateToInvoicePage: () {
                                navigateToInvoiceCreatePage(
                                    filteredItems![index]);
                              },
                              removeFuntion: () {
                                removeInvoice(index);
                              },
                            ));
                      },
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
