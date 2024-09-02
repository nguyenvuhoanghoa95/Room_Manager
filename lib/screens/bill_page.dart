
import 'dart:io';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:room_manager/constants/colors.dart';
import 'package:room_manager/constants/const.dart';
import 'package:room_manager/util/invoice_aguments.dart';
import 'package:room_manager/util/invoice_helper.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../model/monthyear.dart';
import '../util/date_helper.dart';

// ignore: must_be_immutable
class BillPage extends StatelessWidget {
  const BillPage({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenshotController screenshotController = ScreenshotController();
    final InvoiceArguments args =
    ModalRoute.of(context)!.settings.arguments as InvoiceArguments;
    final helper = InvoiceHelper.createWithArgument(args);
    List costList = helper.getAmountInformation();
    List debList = helper.getDebitInformation();
    final dateHelper = DateHelper.createWithArgument(helper.invoice?.invoiceCreateDate);
    MonthYear currMonth = dateHelper.getMonthYear();

    navigatorToInvoicePage() {
      Navigator.popUntil(context, (route) {
        if (route.settings.name == '/invoice-page') {
          Navigator.popAndPushNamed(context, '/invoice-page',
              arguments: helper.room);
          return true;
        }
        if (route.settings.name == '/invoice-month-page' && helper.house != null) {
          Navigator.popAndPushNamed(context, '/invoice-month-page',
              arguments: helper.house);
          return true;
        }
        return false;
      });
    }
    
    Future<void> captureAndShare() async {
      DateTime now = DateTime.now();
      int timestamp = now.millisecondsSinceEpoch;
      // Capture the screen
      final image = await screenshotController.capture();

      if (image != null) {
        // Get the temporary directory
        final directory = await getTemporaryDirectory();
        // Create a path for the image file
        final imagePath = '${directory.path}/screenshot$timestamp.png';
        // Save the captured image as a file
        final imageFile = File(imagePath);
        await imageFile.writeAsBytes(image);

        // Create an XFile from the saved file
        final xFile = XFile(imagePath);

        // Share the image
        final result =
        await Share.shareXFiles([xFile], text: '');
        if (result.status == ShareResultStatus.success) {
          navigatorToInvoicePage();
        }
      }
    }

    return Scaffold(
      backgroundColor: tbBGColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: navigatorToInvoicePage,
            icon: const Icon(Icons.arrow_back)),
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              textAlign: TextAlign.center,
              "Hóa đơn thanh toán",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
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
      body:
      Screenshot(
        controller: screenshotController,
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const DottedLine(
                dashLength: 8,
                dashGapLength: 2,
                lineThickness: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: captureAndShare,
                style: ButtonStyle(
                  backgroundColor: const WidgetStatePropertyAll<Color>(
                      Color.fromARGB(255, 93, 185, 96)),
                  minimumSize: WidgetStateProperty.all(const Size(600, 45)),
                  elevation: WidgetStateProperty.all(0),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                child: const Text(
                  "Hóa Đơn",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
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
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                  currMonth.toString(),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Phòng: ${args.room.roomNumber}",
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  // ),
                ],
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
                  return amountRow(index, costList);
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
                    moneyVNFormat.format(args.invoice.totalAmount),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
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
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: debList.length,
                itemBuilder: (context, index) {
                  return debRow(index, debList);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget amountRow(int index, costList) {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${index + 1}.${costList[index][0]}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${costList[index][1]}",
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            Text(
              moneyVNFormat.format(costList[index][2] * costList[index][3]),
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget debRow(int index, costList) {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${costList[index][0]}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${costList[index][1]}",
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            Text(
              moneyVNFormat.format(costList[index][2] * costList[index][3]),
              style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: tdRed,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
