import 'package:hive_flutter/hive_flutter.dart';
import 'package:room_manager/database/database_setting.dart';
import 'package:room_manager/model/invoice.dart';
part 'room.g.dart';

@HiveType(typeId: 2, adapterName: "RoomAdapter")
class Room extends HiveObject {

  @HiveField(0)
  late DateTime rentDueDate;

  @HiveField(1)
  late int roomNumber;

  @HiveField(2)
  late String roomRenterName;

  @HiveField(3 , defaultValue: 0.0)
  double? amountOfRoom;

  @HiveField(4, defaultValue: 0.0)
  double? totalAmountOwed;

  @HiveField(5)
  int? currentElectricityNumber;

  @HiveField(6)
  int? currentWaterNumber;

  @HiveField(7)
  late HiveList<Invoice> invoices;

  @HiveField(8 , defaultValue: false)
  bool? status;

  // Constructor
  Room(this.rentDueDate, this.roomNumber, this.roomRenterName){
    invoices = HiveList(invoiceBox);
  }
}