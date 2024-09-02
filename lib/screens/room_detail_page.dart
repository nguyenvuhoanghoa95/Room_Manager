import 'package:flutter/material.dart';
import 'package:room_manager/database/database_setting.dart';
import 'package:room_manager/model/invoice.dart';
import 'package:room_manager/model/room.dart';
import 'package:room_manager/widgets/appbar/invoice_appbar.dart';
import 'package:room_manager/widgets/invoice/invoice_item.dart';
import '../constants/colors.dart';

class RoomDetailPage extends StatefulWidget {
  const RoomDetailPage({super.key});

  @override
  State<RoomDetailPage> createState() => _RoomDetailPageState();
}

class _RoomDetailPageState extends State<RoomDetailPage> {
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
      filteredItems?.sort((b,a) => a.key!.compareTo(b.key));
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
      filteredItems?.sort((b,a) => a.key!.compareTo(b.key));
    });
  }
  navigateToInvoiceCreate(Room? room){
    Navigator.pushNamed(
        context,
        '/invoice-page/create',
        arguments: room
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
                              isShowMenu: true,
                            ));
                      },
                    ),
                  ),
                ],
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    right: 300,
                  ),
                  child: ElevatedButton(
                    onPressed: () => navigateToInvoiceCreate(room),
                    style: ElevatedButton.styleFrom(
                      alignment: Alignment.bottomLeft,
                      minimumSize: const Size(60, 60),
                      elevation: 10,
                    ),
                    child: const Text(
                      '+',
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],

      ),

    );
  }
}
