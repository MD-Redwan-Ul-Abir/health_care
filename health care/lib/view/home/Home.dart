import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_health_care/controller/doctor_controller.dart';
import 'package:patient_health_care/controller/needed_information_controller.dart';
import 'package:patient_health_care/controller/profile_controller.dart';
import 'package:patient_health_care/model/model_one.dart';
import 'package:patient_health_care/view/home/componects/drawer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    loadData();
    super.initState();
  }

  Future<void> loadData() async {
    Get.put(DoctorController());
    Get.put(ProfileController());
    Get.put(DiabetesController());
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Get.find<DoctorController>().fetchDoctorList();
      await Get.find<ProfileController>().getProfileDetails();
      await Get.find<DiabetesController>().getDiabeticsData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ড্যাশবোর্ড"),
      ),
      drawer: const AllDrawer(),
      body: GetBuilder<DiabetesController>(
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SingleChildScrollView(
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
                      series: <ChartSeries<SalesData, String>>[
                        LineSeries<SalesData, String>(
                            dataSource: controller.dataSet1,
                            xValueMapper: (SalesData sales, _) => sales.year,
                            yValueMapper: (SalesData sales, _) => sales.sales,
                            name: 'Sales',
                            // Enable data label
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: true)),
                        LineSeries<SalesData, String>(
                            dataSource: controller.dataSet1,
                            xValueMapper: (SalesData sales, _) => sales.year,
                            yValueMapper: (SalesData sales, _) => sales.profit,
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
                      series: <ChartSeries<SalesData, String>>[
                        LineSeries<SalesData, String>(
                            dataSource: controller.dataSet2,
                            xValueMapper: (SalesData sales, _) => sales.year,
                            yValueMapper: (SalesData sales, _) => sales.sales,
                            name: 'Sales',
                            // Enable data label
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: true)),
                        LineSeries<SalesData, String>(
                            dataSource: controller.dataSet2,
                            xValueMapper: (SalesData sales, _) => sales.year,
                            yValueMapper: (SalesData sales, _) => sales.profit,
                            name: 'Profit',
                            // Enable data label
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: true)),
                      ]),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
