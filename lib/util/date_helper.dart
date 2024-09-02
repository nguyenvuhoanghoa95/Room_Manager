

import '../model/monthyear.dart';

class DateHelper {
  DateTime? dateTime;
  DateHelper();

  DateHelper.createWithArgument(date) {
    dateTime = date;
  }
  getMonthYear() {
    var mo = dateTime?.month.toString();
    var yr = dateTime?.year.toString();
    mo = (mo?.length == 1)? "0$mo":mo;
    return MonthYear(mo!, yr!);
  }

  getMonthStr(int month) {
    var strMonth = month.toString();
    return (strMonth.length == 1)? "0$strMonth":strMonth;
  }

  getListMonthYear(){
    List<MonthYear> list = [];
    var currMonth = dateTime?.month;
    var currYear = dateTime?.year;

    for (int index = 0; index < 12; ++index) {
      var monthAdded = currMonth! - index;
      if (monthAdded < 1) {
        monthAdded = monthAdded + 12;
        currYear = currYear! - 1;
      }
      list.add(MonthYear(getMonthStr(monthAdded), currYear.toString()));
    }
    return list;
  }
}
