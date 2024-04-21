import 'package:hive/hive.dart';

part 'activity.g.dart';

@HiveType(typeId: 4 , adapterName: "ActivityAdapter") // Marking this class as a Hive type with typeId 4
class Activity extends HiveObject {

   static int _lastId = 0; // Static variable to keep track of last used ID

  @HiveField(0)
  late int id;

  @HiveField(1)
  late int roomId; // Assuming Room class is defined

  @HiveField(2)
  late String name;

  @HiveField(3 , defaultValue: 0.0)
  late double amount;

  @HiveField(4)
  late bool retired;

  // Constructor
  Activity(this.roomId, this.name, this.amount, this.retired){
    id = ++_lastId; // Increment the last used ID and assign it to the current instance
  }
}