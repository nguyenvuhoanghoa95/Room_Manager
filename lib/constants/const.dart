import 'package:intl/intl.dart';

var numberFormat = NumberFormat.currency(locale: "vi");
var moneyFormat = NumberFormat("#,##0");
var moneyVNFormat = NumberFormat.currency(locale: "vi", symbol: "");