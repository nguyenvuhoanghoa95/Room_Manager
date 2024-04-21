import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:room_manager/constants/database_setting.dart';
import 'package:room_manager/model/activity.dart';
import 'package:room_manager/model/house.dart';
import 'package:room_manager/model/invoice.dart';
import 'package:room_manager/model/renter.dart';
import 'package:room_manager/model/room.dart';
import 'package:room_manager/screens/home/home_page.dart';
import 'package:room_manager/screens/room_page.dart';

void main() async {

  await Hive.initFlutter();
  Hive.registerAdapter(HouseAdapter());
  Hive.registerAdapter(RoomAdapter());
  Hive.registerAdapter(RenterAdapter());
  Hive.registerAdapter(ActivityAdapter());
  Hive.registerAdapter(InvoiceAdapter());
  
  // house = await Hive.openBox(houseTableName);
  // room = await Hive.openBox(roomTableName);
  // roomRenter = await Hive.openBox(roomRenterTableName);
  // roomActivitys = await Hive.openBox(roomActivitysTableName);
  // invoice = await Hive.openBox(invoiceTableName);
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        '/': (context) => const HomePage(),
        '/room-page': (context) => const RoomPage(),
      },
    );
  }
}

