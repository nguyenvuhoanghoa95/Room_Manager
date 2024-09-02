
import 'dart:io';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:room_manager/constants/colors.dart';
import 'package:room_manager/constants/const.dart';
import 'package:room_manager/util/report_helper.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../model/house.dart';
import '../model/monthyear.dart';
import '../util/date_helper.dart';

// ignore: must_be_immutable
class ReportPage extends StatefulWidget {
  const ReportPage({super.key});


  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  BuildContext? contextPage;

  House? _house;
  MonthYear? _searchMonthYear;

  final _searchController = TextEditingController();

  List<MonthYear> _list =[];

  List _costList=[];
  List _expList=[];
  int _costTotal = 0;
  int _expenseTotal = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _house = ModalRoute.of(context)!.settings.arguments as House?;
      setState(() {
        final dateHelper = DateHelper.createWithArgument(DateTime.now());
        _searchMonthYear = dateHelper.getMonthYear();
        var helper = ReportHelper.createWithAgument(_house, _searchMonthYear);
        _costList = helper.getAmountInformation();
        _expList = helper.getAmountExpense();
        _costTotal = helper.costTotal;
        _expenseTotal = helper.expenseTotal;
      });
    });
    _searchController.addListener(filterItems);

  }
  void filterItems() {
    var helper = ReportHelper.createWithAgument(_house, _searchMonthYear);
    setState(() {
      _costList = helper.getAmountInformation();
      _expList = helper.getAmountExpense();
      _costTotal = helper.costTotal;
      _expenseTotal = helper.expenseTotal;
    });
  }

  void printExcel() {
    Navigator.pushNamed(
        context,
        '/excel-page',
        arguments: _house
    );
  }
  @override
  Widget build(BuildContext context) {
    ScreenshotController screenshotController = ScreenshotController();
    navigatorToHousePage() {
      Navigator.popUntil(context, (route) {
        if (route.settings.name == '/room-page') {
          Navigator.popAndPushNamed(context, '/room-page',
              arguments: _house);
          return true;
        }
        return false;
      });
    }
    return Scaffold(
      backgroundColor: tbBGColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: navigatorToHousePage,
            icon: const Icon(Icons.arrow_back)),
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tổng hợp thu chi",
              style: TextStyle(
                fontSize: 18,
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
        body: Screenshot(
          controller: screenshotController,
          child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
                children: [
                  searchExpense(),
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

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Mục Thu",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
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
                   ListView.builder(
                    shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),
                    itemCount: _costList.length,
                    itemBuilder: (context, index) {
                      return amountRow(index, _costList, false);
                    },
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                  const DottedLine(
                    dashLength: 8,
                    dashGapLength: 2,
                    lineThickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "Tổng Thu",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        moneyVNFormat.format(_costTotal),
                        style: const TextStyle(color: Colors.blue,
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
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

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Mục Chi",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
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
                  ListView.builder(
                    shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),
                    itemCount: _expList.length,
                    itemBuilder: (context, index) {
                      return amountRow(index, _expList, true);
                    },
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "Tổng Chi",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        moneyVNFormat.format(_expenseTotal),
                        style: const TextStyle(color: Colors.red,
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
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
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "Còn lại",
                        style: TextStyle(color: Colors.indigo, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        moneyVNFormat.format(_costTotal - _expenseTotal),
                        style: const TextStyle(color: Colors.indigo,
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const DottedLine(
                    dashLength: 8,
                    dashGapLength: 2,
                    lineThickness: 1,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () => printExcel(),
                    style: ButtonStyle(
                      backgroundColor: const WidgetStatePropertyAll<Color>(
                          Color.fromARGB(255, 93, 185, 96)),
                      minimumSize: WidgetStateProperty.all(const Size(600, 60)),
                      elevation: WidgetStateProperty.all(0),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    child: const Text(
                      "In Excel",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
              ),
            ]),
    ),
        )
    );
  }

  Widget amountRow(int index, costList, bool isExpense) {
    if (isExpense) {
      return Column(
        children: [
          const SizedBox(
            height: 10,
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
                        fontSize: 16),
                  ),

                ],
              ),
              Text(
                moneyVNFormat.format(costList[index][2] * costList[index][3]),
                style: const TextStyle( color: Colors.red,
                    fontSize: 16, //fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return Column(
        children: [
          const SizedBox(
            height: 10,
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
                        fontSize: 16),
                  ),
                ],
              ),
              Text(
                moneyVNFormat.format(costList[index][2] * costList[index][3]),
                style: const TextStyle( color: Colors.blue,
                    fontSize: 16, //fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        ],
      );
    }

  }

  Widget searchExpense() {
    final dateHelper = DateHelper.createWithArgument(DateTime.now());
    _list = dateHelper.getListMonthYear();

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
