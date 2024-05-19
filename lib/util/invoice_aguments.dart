import 'package:room_manager/model/invoice.dart';
import 'package:room_manager/model/room.dart';

class InvoiceAguments {
  final Room room;
  final Invoice invoice;

  InvoiceAguments(this.room, this.invoice);
}