import 'package:hive_flutter/hive_flutter.dart';

part 'renter.g.dart';

@HiveType(typeId: 3 , adapterName: "RenterAdapter")
class Renter extends HiveObject {

  static int _lastId = 0; // Static variable to keep track of last used ID

  @HiveField(0)
  late int id;

  @HiveField(1)
  late int roomId;

  @HiveField(2)
  late String name;

  @HiveField(3)
  late DateTime dateOfBirth;

  @HiveField(4)
  late String phoneNumber;

  @HiveField(5)
  late String citizenIdentificationCard;

  // Constructor
  Renter(this.roomId, this.name, this.dateOfBirth, this.phoneNumber, this.citizenIdentificationCard){
    id = ++_lastId; // Increment the last used ID and assign it to the current instance
  }
}