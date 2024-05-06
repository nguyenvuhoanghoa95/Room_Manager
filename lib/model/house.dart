import 'package:hive_flutter/hive_flutter.dart';
import 'package:room_manager/database/database_setting.dart';
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

   @HiveField(4 ,defaultValue: 17000)
   late int waterPrice;

  @HiveField(5)
  late HiveList<Room> rooms;
   
  // Constructor
  House(this.address, this.nameOwner, this.availableRooms, this.electricityPrice, this.waterPrice){
    rooms = HiveList(roomBox);
  }
}
