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
  int depositAmount = 0;

  @HiveField(4)
  late HiveList<Invoice> invoices;

  @HiveField(5 , defaultValue: false)
  bool? status;

  @HiveField(6)
  int currentElectricityNumber = 0 ;

  @HiveField(7)
  int currentWaterNumber = 0;

  @HiveField(8)
  int datePay = 1;

  @HiveField(9)
  late String telephone;

  @HiveField(10)
  late int numPerson;

  // Constructor
  Room(this.rentDueDate, this.roomNumber, this.roomRenterName, this.datePay, this.telephone, this.numPerson, this.depositAmount){
    invoices = HiveList(invoiceBox);
  }

  getHouse() {
    return houseBox.values.where((house) => house.rooms.contains(this)).first;
  }

  getElecAndWatPrice(){
   var house = getHouse();
   return [house.electricityPrice,house.waterPrice];
  }
  
}