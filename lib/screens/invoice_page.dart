import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      room = ModalRoute.of(context)!.settings.arguments as Room?;
      setState(() {
        invoices = room!.invoices.toList();
      });
    });
  }

  //Navigate to invoicePage
    navigateToInvoiceCreatePage(Invoice invoice){
        Navigator.pushNamed(
          context,
          '/invoice-page/Create',
          arguments: invoice
        );
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
                  // searchBox(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: invoices?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            margin: const EdgeInsets.only(
                              top: 25,
                            ),
                            child: InvoiceItem(
                                invoice: invoices![index],
                                navigateToInvoicePage: () => navigateToInvoiceCreatePage(invoices![index])));
                      },
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
