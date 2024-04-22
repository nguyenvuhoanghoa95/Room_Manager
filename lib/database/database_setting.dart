import 'package:hive_flutter/hive_flutter.dart';
import 'package:room_manager/model/activity.dart';
import 'package:room_manager/model/house.dart';
import 'package:room_manager/model/invoice.dart';
import 'package:room_manager/model/room.dart';

// Boxs
late Box<House> houseBox;
late Box<Room> roomBox;
late Box<Activity> roomActivitysBox;
late Box<Invoice> invoiceBox;

//Box name

const String houseTableName = "houses";
const String roomTableName = "rooms";
const String roomRenterTableName = "roomRenter";
const String roomActivitysTableName = "roomActivity";
const String invoiceTableName = "invoices";