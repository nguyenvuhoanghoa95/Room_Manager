import 'package:hive_flutter/hive_flutter.dart';
import 'package:room_manager/database/database_setting.dart';
import 'package:room_manager/model/expense.dart';
import 'package:room_manager/model/room.dart';

part 'house.g.dart';

@HiveType(typeId: 1, adapterName: "HouseAdapter")
class House extends HiveObject{
  
  @HiveField(0)
   late String address; 

  @HiveField(1)
   late String nameOwner;

  @HiveField(2)
   late int availableRooms;

   @HiveField(3 ,defaultValue: 3500)
   late int electricityPrice;

   @HiveField(4 ,defaultValue: 100000)
   late int waterPrice;

  @HiveField(5)
  late HiveList<Room> rooms;

  @HiveField(6)
  late bool? isWaterPerPerson;

  @HiveField(7)
  late HiveList<Expense> expenses;

  @HiveField(8 ,defaultValue: 100000)
  late int serviceAmount;

  // Constructor
  House(this.address, this.nameOwner, this.availableRooms, this.electricityPrice, this.waterPrice, this.isWaterPerPerson){
    rooms = HiveList(roomBox);
    expenses = HiveList(expenseBox);
    serviceAmount = 100000;
  }
}
