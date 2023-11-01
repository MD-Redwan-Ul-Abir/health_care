import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_health_care/controller/doctor_controller.dart';
import 'package:patient_health_care/controller/profile_controller.dart';
import 'package:patient_health_care/view/home/componects/drawer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
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
  void initState() {
    loadData();
    super.initState();
  }

  Future<void> loadData() async {
    Get.put(DoctorController());
    Get.put(ProfileController());
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Get.find<DoctorController>().fetchDoctorList();
      await Get.find<ProfileController>().getProfileDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ড্যাশবোর্ড"),
      ),
      drawer: const AllDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Diabetics Data",
              style: TextStyle(color: Colors.black, fontSize: 19),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.stacked_line_chart,
                  color: Colors.blueAccent,
                ),
                Text("Before meal"),
                SizedBox(
                  width: 20,
                ),
                Icon(
                  Icons.stacked_line_chart,
                  color: Colors.redAccent,
                ),
                Text("After meal"),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SfCartesianChart(
                enableMultiSelection: true,
                plotAreaBackgroundColor: Colors.white60,
                primaryXAxis: CategoryAxis(),
                // Chart title
                //title: ChartTitle(text: 'Half yearly sales analysis'),

                // Enable legend
                legend: const Legend(isVisible: false),
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
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true)),
                  LineSeries<_SalesData, String>(
                      dataSource: data,
                      xValueMapper: (_SalesData sales, _) => sales.year,
                      yValueMapper: (_SalesData sales, _) => sales.profit,
                      name: 'Profit',
                      // Enable data label
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true)),
                ]),
            const Text(
              "Presure Data",
              style: TextStyle(color: Colors.black, fontSize: 19),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.stacked_line_chart,
                  color: Colors.blueAccent,
                ),
                Text("Pressure Systolic"),
                SizedBox(
                  width: 20,
                ),
                Icon(
                  Icons.stacked_line_chart,
                  color: Colors.redAccent,
                ),
                Text("Pressure Diastolic"),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                // Chart title
                //title: ChartTitle(text: 'Half yearly sales analysis'),
                // Enable legend
                legend: const Legend(isVisible: false),
                // Enable tooltip
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries<_SalesData, String>>[
                  LineSeries<_SalesData, String>(
                      dataSource: data,
                      xValueMapper: (_SalesData sales, _) => sales.year,
                      yValueMapper: (_SalesData sales, _) => sales.sales,
                      name: 'Sales',
                      // Enable data label
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true)),
                  LineSeries<_SalesData, String>(
                      dataSource: data,
                      xValueMapper: (_SalesData sales, _) => sales.year,
                      yValueMapper: (_SalesData sales, _) => sales.profit,
                      name: 'Profit',
                      // Enable data label
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true)),
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
