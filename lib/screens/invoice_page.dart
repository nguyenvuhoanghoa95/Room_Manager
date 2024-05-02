import 'package:flutter/material.dart';
import 'package:room_manager/widgets/appbar/invoice_appbar.dart';
import '../constants/colors.dart';

class InvoiceManagement extends StatefulWidget {
  const InvoiceManagement({super.key});

  @override
  State<InvoiceManagement> createState() => _InvoiceManagementState();
}

 
class _InvoiceManagementState extends State<InvoiceManagement> {

  //Navigate to invoicePage
  createInvoice(){
     Navigator.pushNamed(
        context,
        '/invoice-page/Create',
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tbBGColor,
      appBar:const InvoiceAppBar(),
      body: Stack(
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                children: [
                  // searchBox(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 0,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            margin: const EdgeInsets.only(
                              top: 25,
                            ),
                            // child: RoomItem(
                            //     room: rooms![index],
                            //     navigateToInvoicePage: () => navigateToInvoicePage(rooms![index].id),
                            //     removeRoomFuntion: () => removeRoom(index))
                        );
                      },
                    ),
                  )
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
                    right: 20,
                  ),
                  child: ElevatedButton(
                    onPressed: () => createInvoice() ,
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
          )
        ],
      ),
    );
  }
}