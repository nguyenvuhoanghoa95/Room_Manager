import 'package:hive_flutter/hive_flutter.dart';
import 'package:room_manager/model/debit.dart';
import 'package:room_manager/model/house.dart';
import 'package:room_manager/model/invoice.dart';
import 'package:room_manager/model/room.dart';

// Boxs
late Box<House> houseBox;
late Box<Room> roomBox;
late Box<Debit> debitBox;
late Box<Invoice> invoiceBox;

//Box name

const String houseTableName = "house1";
const String roomTableName = "room1";
const String roomRenterTableName = "roomRenter1";
const String debitTableName = "debit1";
const String invoiceTableName = "invoice1";