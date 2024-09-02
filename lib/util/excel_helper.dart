import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:room_manager/widgets/dialog/confirm_dialog.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import "package:permission_handler/permission_handler.dart";

class ExcelHelper {
  final  infoController;
  ExcelHelper(this.infoController);

  getPermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    if (await Permission.contacts.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
    } else {
// You can request multiple permissions at once.
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();
    }
  }

  openDialog(context) {
    showDialog(
      context: context,
      builder: (context) {
        return ConfirmDialog(
          cancel: () => Navigator.of(context).pop(),
          infoController: infoController,
        );
      },
    );
  }
  exportDataGridToExcel(GlobalKey<SfDataGridState> key,GlobalKey<SfDataGridState> key2, context) async {
    getPermission();

    // final Workbook workbook = key.currentState!.exportToExcelWorkbook();
    final Workbook workbook = Workbook(2);
    final Worksheet sheet = workbook.worksheets[0];
    final Worksheet sheet2 = workbook.worksheets[1];
    key.currentState!.exportToExcelWorksheet(sheet);
   // key2.currentState!.exportToExcelWorksheet(sheet2);


    final List<int> bytes = workbook.saveAsStream();
    final directory = await getExternalStorageDirectory();
    final imagePath = '${directory?.path}/DataGrid.xlsx';

    File(imagePath).writeAsBytes(bytes);
    workbook.dispose();
    infoController.text = directory?.path;

    // Create an XFile from the saved file
    final xFile = XFile(imagePath);

    // Share file
    final result = await Share.shareXFiles([xFile], text: '');
    if (result.status == ShareResultStatus.success) {
      //navigatorToInvoicePage();
    }
    //openDialog(context);
  }
}