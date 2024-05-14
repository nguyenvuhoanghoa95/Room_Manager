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

  @HiveField(3)
  int totalAmountOwed = 0;

  @HiveField(4)
  late HiveList<Invoice> invoices;

  @HiveField(5 , defaultValue: false)
  bool? status;

  @HiveField(6)
  int currentElectricityNumber = 0 ;

  @HiveField(7)
  int currentWaterNumber = 0;

  // Constructor
  Room(this.rentDueDate, this.roomNumber, this.roomRenterName){
    invoices = HiveList(invoiceBox);
  }
}