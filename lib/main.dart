import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:room_manager/database/database_setting.dart';
import 'package:room_manager/model/activity.dart';
import 'package:room_manager/model/house.dart';
import 'package:room_manager/model/invoice.dart';
import 'package:room_manager/model/room.dart';
import 'package:room_manager/screens/home_page.dart';
import 'package:room_manager/screens/room_page.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(HouseAdapter());
  Hive.registerAdapter(RoomAdapter());
  Hive.registerAdapter(ActivityAdapter());
  Hive.registerAdapter(InvoiceAdapter());

  houseBox = await Hive.openBox<House>(houseTableName);
  roomBox = await Hive.openBox<Room>(roomTableName);
  roomActivitysBox = await Hive.openBox<Activity>(roomActivitysTableName);
  invoiceBox = await Hive.openBox<Invoice>(invoiceTableName);

  // houseBox.clear();
  // roomBox.clear();

  if (houseBox.isEmpty && roomBox.isEmpty) {
    List<House> newHouses = [
      House('123 Main St', 'John Doe', 2, 3500, 1700, []),
      House('456 Main St', 'Bob Johnson', 3, 3500, 1700, []),
      House('234 Maple St', 'David Wilson', 5, 3500, 1700, []),
    ];

    houseBox.addAll(newHouses);

    int? houseID = houseBox.getAt(0)?.id;
    if (houseID != null) {
      List<Room> newRooms = [
        Room(DateTime.now(), 301, houseID, "Nguyễn Vũ Hoàng Hóa", 0.0, 0.0, 0,
            0, [], [], false),
        Room(DateTime.now(), 302, houseID, "Nguyễn Lê Đăng Duazn", 0.0, 0.0, 0,
            0, [], [], false),
        Room(DateTime.now(), 303, houseID, "Lê Minh", 0.0, 0.0, 0, 0, [], [],
            false)
      ];
      roomBox.addAll(newRooms);
      print(roomBox.values.toList());
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
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
