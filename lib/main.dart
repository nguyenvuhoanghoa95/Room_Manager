import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:room_manager/database/database_setting.dart';
import 'package:room_manager/model/debit.dart';
import 'package:room_manager/model/house.dart';
import 'package:room_manager/model/invoice.dart';
import 'package:room_manager/model/room.dart';
import 'package:room_manager/screens/bill_page.dart';
import 'package:room_manager/screens/home_page.dart';
import 'package:room_manager/screens/invoice_create_page.dart';
import 'package:room_manager/screens/invoice_page.dart';
import 'package:room_manager/screens/room_page.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(HouseAdapter());
  Hive.registerAdapter(RoomAdapter());
  Hive.registerAdapter(InvoiceAdapter());
  Hive.registerAdapter(DebitAdapter());



  if (!Hive.isBoxOpen(houseTableName)) {
    debitBox = await Hive.openBox<Debit>(debitTableName);
    invoiceBox = await Hive.openBox<Invoice>(invoiceTableName);
    roomBox = await Hive.openBox<Room>(roomTableName);
    houseBox = await Hive.openBox<House>(houseTableName);
  }

  
  if (houseBox.isEmpty && roomBox.isEmpty) {
    // List<Invoice> invoice = [
    //   Invoice(300, 123, DateTime.parse("2024-05-01"), 5500000,5500000,5500000),
    // ];
    // invoiceBox.addAll(invoice);

    List<Room> newRooms = [
      Room(DateTime.now(), 301, "Nguyễn Vũ Hoàng Hóa"),
      Room(DateTime.now(), 302, "Nguyễn Lê Đăng Duazn"),
      Room(DateTime.now(), 303, "Lê Minh")
    ];
    roomBox.addAll(newRooms);

    var room = roomBox.values.first;
    // room.invoices.addAll(invoice);
    room.save();

    List<House> newHouses = [
      House('123 Main St', 'John Doe', 2, 3500, 1700),
      House('456 Main St', 'Bob Johnson', 3, 3500, 1700),
      House('234 Maple St', 'David Wilson', 5, 3500, 1700),
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
      title: 'Room Manager App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 67, 41, 114)),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        '/': (context) => const HomePage(),
        //Room routers
        '/room-page': (context) => const RoomPage(),
        //Invoice routers
        '/invoice-page': (context) => const InvoiceManagement(),
        '/invoice-page/create': (context) => const InvoiceCreatePage(),
        '/invoice-page/bill':(context) => const BillPage(),
      },
    );
  }
}
