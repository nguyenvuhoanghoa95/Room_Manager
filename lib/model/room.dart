import 'package:hive_flutter/hive_flutter.dart';
import 'package:room_manager/model/house.dart';

part 'room.g.dart';

@HiveType(typeId: 2, adapterName: "RoomAdapter")
class Room extends HiveObject {

  static int _lastId = 0; // Static variable to keep track of last used ID

  @HiveField(0)
  late int id;

  @HiveField(1)
  late DateTime startDate;

  @HiveField(2)
  late int roomNumber;

  @HiveField(3)
  late House house;

  @HiveField(4)
  late int roomRenterId;

  @HiveField(5 , defaultValue: 0.0)
  late double amountOfRoom;

  @HiveField(6)
  late double totalAmountOwed;

  @HiveField(7)
  late int currentElectricityNumber;

  @HiveField(8)
  late int currentWaterNumber;

  @HiveField(9)
  late List<int> roomActivitieIds;

  @HiveField(10)
  late List<int> invoiceIds;

  @HiveField(11 , defaultValue: false)
  late bool status;

  // Constructor
  Room(this.startDate, this.roomNumber, this.house, this.roomRenterId, this.amountOfRoom, this.totalAmountOwed, this.currentElectricityNumber, this.currentWaterNumber, this.roomActivitieIds, this.invoiceIds, this.status){
     id = ++_lastId; // Increment the last used ID and assign it to the current instance
  }
}