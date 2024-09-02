import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:room_manager/database/database_setting.dart';
import 'package:room_manager/model/house.dart';
import 'package:room_manager/model/invoice.dart';
import 'package:room_manager/model/room.dart';
import 'package:room_manager/model/expense.dart';
import 'package:room_manager/screens/bill_page.dart';
import 'package:room_manager/screens/collect_invoice_page.dart';
import 'package:room_manager/screens/home_page.dart';
import 'package:room_manager/screens/invoice_create_page.dart';
import 'package:room_manager/screens/invoice_month_page.dart';
import 'package:room_manager/screens/invoice_page.dart';
import 'package:room_manager/screens/room_page.dart';
import 'package:room_manager/screens/expense_page.dart';
import 'package:room_manager/screens/report_page.dart';
import 'package:room_manager/widgets/dialog/collect_invoice_dialog.dart';
import 'excel/export_report.dart';
Future<void> initFlutter([String? subDir]) async {
  WidgetsFlutterBinding.ensureInitialized();

  var appDir = await getExternalStorageDirectory();
  Hive.init(appDir?.path);
}
void main() async {
  await initFlutter();
  Hive.registerAdapter(HouseAdapter());
  Hive.registerAdapter(RoomAdapter());
  Hive.registerAdapter(ExpenseAdapter());
  Hive.registerAdapter(InvoiceAdapter());

  if (!Hive.isBoxOpen(houseTableName)) {
    invoiceBox = await Hive.openBox<Invoice>(invoiceTableName);
    expenseBox = await Hive.openBox<Expense>(expenseTableName);
    roomBox = await Hive.openBox<Room>(roomTableName);
    houseBox = await Hive.openBox<House>(houseTableName);
  }
  
  if (houseBox.isEmpty) {
    List<Room> newRooms = [
      Room(DateTime.now(), 101, "Nguyễn Van A",1,"",2,1),
    ];
    roomBox.addAll(newRooms);

    var room = roomBox.values.first;
    // room.invoices.addAll(invoice);
    room.save();

    List<House> newHouses = [
      House('Dia chi', 'Nha tro', 2, 3500, 1700, true),
    ];
    houseBox.addAll(newHouses);



    var house = houseBox.values.first;
    house.rooms.addAll(newRooms);
    house.save();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quản Trọ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 67, 41, 114)),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        '/': (context) => const HomePage(),
        //Room routers
        '/room-page': (context) => const RoomPage(),
        '/invoice-month-page': (context) => const InvoiceMonthPage(),
        '/collect-invoice-page': (context) => const CollectInvoicePage(),
        '/collect-invoice-dialog': (context) => const CollectInvoiceDialog(),
        '/expense-page': (context) => const ExpensePage(),
        //Invoice routers
        '/invoice-page': (context) => const InvoiceManagement(),
        '/invoice-page/create': (context) => const InvoiceCreatePage(),
        '/invoice-page/bill':(context) => const BillPage(),
        // report
        '/report-page':(context) => const ReportPage(),
        '/excel-page':(context) => const ExportReportPage(title: 'Báo Cáo',),
        //'/upload-page':(context) => const UploadLocalImageForm(title: 'aa',),
      },
    );
  }
}
