
class MonthYear {
  final String month;
  final String year;

  const MonthYear(this.month, this.year);


  @override
  String toString() {
    return "Tháng $month-$year";
  }
}