import 'package:flutter/material.dart';
import 'package:room_manager/constants/colors.dart';
import 'package:room_manager/database/database_setting.dart';
import 'package:room_manager/model/house.dart';
import 'package:room_manager/widgets/dialog/elec_and_water_dialog.dart';

class RoomAppBar extends StatelessWidget implements PreferredSizeWidget {

  final  House? house;
  final  electricPriceController;
  final  waterPriceController;


  const RoomAppBar({
    super.key, this.house, this.electricPriceController, this.waterPriceController,
  });
  
  edit(context){
    if(house == null) return;
    house?.electricityPrice =  int.parse(electricPriceController.text);
    house?.waterPrice =  int.parse(waterPriceController.text);
    house?.save();
    Navigator.of(context).pop();
  }
  
   //Navigate to roompage 
  openDialog(context) {
    showDialog(
      context: context,
      builder: (context) {
        return ElecAndWaterDialog(
          edit: () => edit(context),
          cancel: () => Navigator.of(context).pop(),
          electricPriceController: electricPriceController,
          waterPriceController: waterPriceController,
        );
      },
    );
  }
  
  

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: tbBGColor,
      title: const Text(
        "Danh Sách Phòng",
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w500,
        ),
      ),
      titleSpacing: 00.0,
      centerTitle: true,
      toolbarHeight: 60.2,
      toolbarOpacity: 0.8,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
      ),
      elevation: 0.00,
      actions: [
        PopupMenuButton(
                      position: PopupMenuPosition.under,
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          onTap: () => openDialog(context),
                          child: const Text('Sửa giá điện nước'),
                        ),
                      
                      ],
                    ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
