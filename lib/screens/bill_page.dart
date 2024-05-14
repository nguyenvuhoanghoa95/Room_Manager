import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:room_manager/constants/colors.dart';

class BillPage extends StatelessWidget {
  List costList = [
    ["Tiền Phòng", 1, 5500000],
    ["Tiền Điện", 50, 3500],
    ["Tiền Nước", 20, 17000],
    ["Tiền Khác", 20, 17000],
    ["Tiền Nợ", 20, 1000000]
  ];

  var numberFormat = NumberFormat.currency(locale: "vi");

  BillPage({super.key});

  getSubTitle(String title) {
    var subtitle = "";
    switch (title) {
      case "Tiền Phòng":
        subtitle = "30 ngày giá: invoice amount";
        break;
      case "Tiền Điện":
        subtitle = "Số mới: Number, Số Cũ: Number\nNumber KWh x Number";
        break;
      case "Tiền Nước":
        subtitle = "Số mới: Number, Số Cũ: Number\nNumber KWh x Number";
        break;
      case "Tiền khác":
        subtitle = "Chi phí khác: Number";
        break;
      default:
        subtitle = "Tiền còn nợ lại: Number";
    }
    return subtitle;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tbBGColor,
      appBar: AppBar(
        // backgroundColor: tbBGColor,
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hóa đơn thanh toán",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "Phòng : 301",
              style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
            ),
          ],
        ),
        titleSpacing: 00.0,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        elevation: 0.00,
      ),
      body:  SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const DottedLine(
                dashLength: 8,
                dashGapLength: 2,
                lineThickness: 1,
              ),
              const SizedBox(
                height: 5,
              ),
              const DottedLine(
                dashLength: 8,
                dashGapLength: 2,
                lineThickness: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Danh Mục",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Thành tiền",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  // ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const DottedLine(
                dashLength: 8,
                dashGapLength: 2,
                lineThickness: 1,
              ),
              const SizedBox(
                height: 5,
              ),
              const DottedLine(
                dashLength: 8,
                dashGapLength: 2,
                lineThickness: 1,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: costList.length,
                itemBuilder: (context, index) {
                  return amountRow(costList[index][0], costList[index][1],
                      costList[index][2], index + 1);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const DottedLine(
                dashLength: 8,
                dashGapLength: 2,
                lineThickness: 1,
              ),
              const SizedBox(
                height: 5,
              ),
              const DottedLine(
                dashLength: 8,
                dashGapLength: 2,
                lineThickness: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    "Tổng tiền",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    numberFormat.format(5000000),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const DottedLine(
                dashLength: 8,
                dashGapLength: 2,
                lineThickness: 1,
              ),
              const SizedBox(
                height: 5,
              ),
              const DottedLine(
                dashLength: 8,
                dashGapLength: 2,
                lineThickness: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 30,
                  bottom: 50,
                ),
                child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: const MaterialStatePropertyAll<Color>(Color.fromARGB(255, 93, 185, 96)),
                        minimumSize:
                            MaterialStateProperty.all(const Size(600, 60)),
                        elevation: MaterialStateProperty.all(0),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      child: const Text(
                        "Xác nhận thanh toán",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
              ),
            ],
          ),
        ),
    );
  }

  Widget amountRow(String title, int quantity, int amount, int index) {
    var subTitle = getSubTitle(title);
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Expanded(
            // flex: 3,
            // child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$index.$title",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "$subTitle",
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            Text(
              numberFormat.format(quantity * amount),
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
