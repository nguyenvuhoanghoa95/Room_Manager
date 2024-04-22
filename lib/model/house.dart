import 'package:hive_flutter/hive_flutter.dart';

part 'house.g.dart';

@HiveType(typeId: 1, adapterName: "HouseAdapter")
class House extends HiveObject{
  static int _lastId = 0; // Static variable to keep track of last used ID

  @HiveField(0)
   late int id; // No longer marked as 'late'
  
  @HiveField(1)
   late String address; 

  @HiveField(2)
   late String nameOwner;

  @HiveField(3)
   late int availableRooms;

   @HiveField(4)
   late int electricityPrice;

   @HiveField(5)
   late int waterPrice;

  @HiveField(6)
   late List<int> roomIds;
   

  // Constructor
  House(this.address, this.nameOwner, this.availableRooms, this.electricityPrice, this.waterPrice , this.roomIds) {
    id = ++_lastId; // Increment the last used ID and assign it to the current instance
  }
}
