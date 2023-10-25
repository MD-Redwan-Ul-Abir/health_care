import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:patient_health_care/home/componects/drawer.dart';




class home extends StatefulWidget {
  home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final Box _boxLogin = Hive.box("login");

  List<_SalesData> data = [
    _SalesData('Jan', 35, 20),
    _SalesData('Feb', 68, 20),
    _SalesData('Mar', 34, 30),
    _SalesData('Apr', 32, 30),
    _SalesData('May', 40, 38),
    _SalesData('Jun', 45, 40),
    _SalesData('Jul', 38, 35),
    _SalesData('Aug', 43, 42),
    _SalesData('Sep', 39, 38),
    _SalesData('Oct', 41, 39),
    _SalesData('Nov', 37, 34),
    _SalesData('Dec', 44, 43),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ড্যাশবোর্ড"),

      ),
      drawer:  all_drower(),


      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),

            Text("Diabetics Data",style: TextStyle(color: Colors.black,fontSize: 19),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.stacked_line_chart,color: Colors.blueAccent,),
                Text("Before meal"),
                SizedBox(width: 20,),
                Icon(Icons.stacked_line_chart,color: Colors.redAccent,),
                Text("After meal"),
              ],
            ),
            SizedBox(height: 10,),
            SfCartesianChart(
                enableMultiSelection: true,
                plotAreaBackgroundColor: Colors.white60,
                primaryXAxis: CategoryAxis(),
                // Chart title
                //title: ChartTitle(text: 'Half yearly sales analysis'),

                // Enable legend
                legend: Legend(isVisible: false),
                // Enable tooltip
                tooltipBehavior: TooltipBehavior(enable: true),
                //zoomPanBehavior: ZoomPanBehavior(),
                series: <ChartSeries<_SalesData, String>>[
                  LineSeries<_SalesData, String>(

                      dataSource: data,
                      xValueMapper: (_SalesData sales, _) => sales.year,

                      yValueMapper: (_SalesData sales, _) => sales.sales,

                      name: 'Sales',
                      // Enable data label
                      dataLabelSettings: DataLabelSettings(isVisible: true)),
                  LineSeries<_SalesData, String>(
                      dataSource: data,
                      xValueMapper: (_SalesData sales, _) => sales.year,
                      yValueMapper: (_SalesData sales, _) => sales.profit,

                      name: 'Profit',
                      // Enable data label
                      dataLabelSettings: DataLabelSettings(isVisible: true)),

                ]),
            Text("Presure Data",style: TextStyle(color: Colors.black,fontSize: 19),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.stacked_line_chart,color: Colors.blueAccent,),
                Text("Pressure Systolic"),
                SizedBox(width: 20,),
                Icon(Icons.stacked_line_chart,color: Colors.redAccent,),
                Text("Pressure Diastolic"),
              ],
            ),
            SizedBox(height: 10,),
            SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                // Chart title
                //title: ChartTitle(text: 'Half yearly sales analysis'),
                // Enable legend
                legend: Legend(isVisible: false),
                // Enable tooltip
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries<_SalesData, String>>[
                  LineSeries<_SalesData, String>(
                      dataSource: data,
                      xValueMapper: (_SalesData sales, _) => sales.year,
                      yValueMapper: (_SalesData sales, _) => sales.sales,

                      name: 'Sales',
                      // Enable data label
                      dataLabelSettings: DataLabelSettings(isVisible: true)),
                  LineSeries<_SalesData, String>(
                      dataSource: data,
                      xValueMapper: (_SalesData sales, _) => sales.year,
                      yValueMapper: (_SalesData sales, _) => sales.profit,

                      name: 'Profit',
                      // Enable data label
                      dataLabelSettings: DataLabelSettings(isVisible: true)),

                ]),
          ],
        ),
      ),
    );
  }
}
class _SalesData {
  _SalesData(this.year, this.sales, this.profit);

  final String year;
  final double sales;
  final double profit;


}