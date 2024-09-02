import 'package:hive_flutter/hive_flutter.dart';
import 'package:room_manager/model/house.dart';
import 'package:room_manager/model/invoice.dart';
import 'package:room_manager/model/room.dart';
import 'package:room_manager/model/expense.dart';

// Boxs
late Box<House> houseBox;
late Box<Room> roomBox;
late Box<Invoice> invoiceBox;
late Box<Expense> expenseBox;

//Box name

const String houseTableName = "house25";
const String roomTableName = "room25";
const String roomRenterTableName = "roomRenter25";
const String invoiceTableName = "invoice25";
const String expenseTableName = "expense25";