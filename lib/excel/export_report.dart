import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../model/house.dart';
import '../model/monthyear.dart';
import '../util/date_helper.dart';
import '../util/excel_helper.dart';
import '../util/report_helper.dart';


class ExportReportPage extends StatefulWidget {
  const ExportReportPage({super.key, required this.title});
  final String title;

  @override
  _ExportReportPageState createState() => _ExportReportPageState();
}

class _ExportReportPageState extends State<ExportReportPage> {
  //Create an instance of ScreenshotController
  //ScreenshotController screenshotController = ScreenshotController();
  final GlobalKey<SfDataGridState> _key = GlobalKey<SfDataGridState>();
  final GlobalKey<SfDataGridState> _key2 = GlobalKey<SfDataGridState>();
  List<InvoiceInfo> invData = <InvoiceInfo>[];
  late InvoiceDataSource invoiceDataSource;
  late ExcelHelper helper;
  final infoController = TextEditingController();
  House? _house;
  MonthYear? _searchMonthYear;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _house = ModalRoute.of(context)!.settings.arguments as House?;
      setState(() {
        final dateHelper = DateHelper.createWithArgument(DateTime.now());
        _searchMonthYear = dateHelper.getMonthYear();
        var reportHelper = ReportHelper.createWithAgument(_house, _searchMonthYear);
        invData = reportHelper.getInvoiceData();
        helper = ExcelHelper(infoController);
        invoiceDataSource = InvoiceDataSource(invoiceData: invData);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var isVisible = _house!.isWaterPerPerson == false;
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(12.0),
            child: Row(
              children: <Widget>[
                SizedBox(
                  height: 40.0,
                  width: 150.0,
                  child: MaterialButton(
                      color: Colors.blue,
                      onPressed: () => helper.exportDataGridToExcel(_key, _key2, context),
                      child: const Center(
                          child: Text(
                            'Export to Excel',
                            style: TextStyle(color: Colors.white),
                          ))),
                ),
                const Padding(padding: EdgeInsets.all(20)),

              ],
            ),
          ),
          Expanded(
            child: SfDataGrid(
              key: _key,
              source: invoiceDataSource,
              columns: <GridColumn>[
                GridColumn(
                    columnName: 'Phong',
                    label: Container(
                        padding: const EdgeInsets.all(16.0),
                        alignment: Alignment.center,
                        child: const Text(
                          'Phòng', overflow: TextOverflow.ellipsis
                        ))),
                GridColumn(
                    columnName: 'Gia',
                    label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text('Giá phòng', overflow: TextOverflow.ellipsis))),
                GridColumn(
                    columnName: 'Dien cu',
                    label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text(
                          'Số điện cũ',
                          overflow: TextOverflow.ellipsis,
                        ))),
                GridColumn(
                    columnName: 'Dien moi',
                    label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text('Số điện mới'))),
                GridColumn(
                    columnName: 'Tien dien',
                    label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text('Tiền điện', overflow: TextOverflow.ellipsis))),
                GridColumn(
                    visible: isVisible,
                    columnName: 'Nuoc cu',
                    label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text(
                          'Số nước cũ',
                          overflow: TextOverflow.ellipsis,
                        ))),
                GridColumn(
                    visible: isVisible,
                    columnName: 'Nuoc moi',
                    label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text('Số nước mới', overflow: TextOverflow.ellipsis))),
                GridColumn(
                    columnName: 'Tien nuoc',
                    label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text('Tiền nước', overflow: TextOverflow.ellipsis))),
                GridColumn(
                    columnName: 'Tien dich vu',
                    label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text('Tiền dịch vụ', overflow: TextOverflow.ellipsis))),
                GridColumn(
                    columnName: 'Tien khac',
                    label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text('Tiền khác', overflow: TextOverflow.ellipsis))
                ),
                GridColumn(
                    columnName: 'Tong',
                    label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text('Tổng'))),

              ],
                gridLinesVisibility: GridLinesVisibility.both,
                headerGridLinesVisibility: GridLinesVisibility.both
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> ShowCapturedWidget(
      BuildContext context, Uint8List capturedImage) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text("Captured widget screenshot"),
        ),
        body: Center(child: Image.memory(capturedImage)),
      ),
    );
  }
}

/// An object to set the employee collection data source to the datagrid. This
/// is used to map the employee data to the datagrid widget.
class InvoiceDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  InvoiceDataSource({required List<InvoiceInfo> invoiceData}) {
    _invoiceData = invoiceData
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'Phong', value: e.roomNumber.toString()),
      DataGridCell<int>(columnName: 'Gia', value: e.roomAmount),
      DataGridCell<String>(columnName: 'Dien cu',
          value: (e.currentElectricityNumber==0)? "":e.currentElectricityNumber.toString()),
      DataGridCell<String>(columnName: 'Dien moi',
          value: (e.newElectricityNumber==0)? "":e.newElectricityNumber.toString()),
      DataGridCell<int>(columnName: 'Tien dien', value: e.electAmount),
      DataGridCell<String>(columnName: 'Nuoc cu',
          value: (e.currentWaterNumber==0)? "":e.currentWaterNumber.toString()),
      DataGridCell<String>(columnName: 'Nuoc moi',
          value: (e.newWaterNumber==0)? "":e.newWaterNumber.toString()),
      DataGridCell<int>(columnName: 'Tien nuoc', value: e.waterAmount),
      DataGridCell<int>(columnName: 'Tien dich vu', value: e.wifiAmount),
      DataGridCell<int>(columnName: 'Tien khac', value: e.otherPay),
      DataGridCell<int>(columnName: 'Tong', value: e.totalAmount),
    ]))
        .toList();
  }

  List<DataGridRow> _invoiceData = [];

  @override
  List<DataGridRow> get rows => _invoiceData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
          TextStyle? getTextStyle() {
            if (dataGridCell.columnName == 'Phong') {
              return const TextStyle(color: Colors.deepOrange);
            } else {
              return null;
            }
          }
          return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                dataGridCell.value.toString(),
                style: getTextStyle(),
                overflow: TextOverflow.ellipsis,
              ));
        }).toList());
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the employee which will be rendered in datagrid.
class InvoiceInfo {
  /// Creates the employee class with required details.
  InvoiceInfo(this.roomNumber, this.roomAmount, this.numPerson, this.isWaterPerPerson
  , this.currentElectricityNumber , this.newElectricityNumber , this.electAmount
  , this.currentWaterNumber, this.newWaterNumber , this.waterAmount
  , this.wifiAmount , this.otherPay , this.totalAmount);

  final String roomNumber;
  final int? roomAmount;
  final int numPerson;
  final bool? isWaterPerPerson;
  final int? currentElectricityNumber;
  final int? newElectricityNumber;
  final int? electAmount;
  final int? currentWaterNumber;
  final int? waterAmount;
  final int? newWaterNumber;
  final int? wifiAmount;
  final int? otherPay;
  final int? totalAmount;
}
