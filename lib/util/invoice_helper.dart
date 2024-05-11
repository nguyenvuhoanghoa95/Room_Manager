import 'package:room_manager/database/database_setting.dart';
import 'package:room_manager/model/house.dart';
import 'package:room_manager/model/room.dart';

class InvoiceHelper {
 House? house;
 
  caculateCostOfElecAndWater(String crrElecNum , String crrWarNum , String newElecNum, String newWarNum , int electricityConsumed , int warterConsumed, Room room , List costList){
      electricityConsumed = int.parse(newElecNum) - int.parse(crrElecNum);
      warterConsumed = int.parse(newWarNum) - int.parse(crrWarNum);

      //get electric and water cost
      house = houseBox.values.where((house) => house.rooms.indexOf(room) == 0).first;
      if(house != null){
        costList.add(["Tiền điện", electricityConsumed, house?.electricityPrice]);
        costList.add(["Tiền nước", warterConsumed, house?.waterPrice]); 
        return (electricityConsumed * house!.electricityPrice) + (warterConsumed * house!.waterPrice);
      }
      return 0;
  }

}