import 'package:room_manager/model/invoice.dart';
import 'package:room_manager/model/room.dart';

import '../model/house.dart';

class InvoiceArguments {
  final House house;
  final Room room;
  final Invoice invoice;

  InvoiceArguments(this.house, this.room, this.invoice);
}