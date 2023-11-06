// class _SalesData {
//   _SalesData(this.year, this.sales, this.profit);

//   final String year;
//   final double sales;
//   final double profit;
// }
//create a model class for the data you want to show in the chart
class SalesData {
  SalesData(this.year, this.sales, this.profit);

  final String year;
  final double sales;
  final double profit;

  factory SalesData.fromJson(Map<String, dynamic> json) {
    return SalesData(
      json['year'],
      json['sales'],
      json['profit'],
    );
  }
}
