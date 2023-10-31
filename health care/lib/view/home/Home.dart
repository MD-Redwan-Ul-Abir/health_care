import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:patient_health_care/controller/doctor_controller.dart';
import 'package:patient_health_care/view/home/componects/drawer.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Get.find<DoctorController>().fetchDoctorList();
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
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Diabetics Data",
                    style: TextStyle(fontSize: 30),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        color: Colors.blue,
                        height: 12,
                        width: 30,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        "Diabetics Before Meal",
                        style: TextStyle(fontSize: 17),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        color: Colors.green,
                        height: 12,
                        width: 30,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        "Diabetics After Meal",
                        style: TextStyle(fontSize: 17),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 400,
                      width: 400,
                      child: _LineChart(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Presure Data",
                    style: TextStyle(fontSize: 30),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        color: Colors.blue,
                        height: 12,
                        width: 30,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        "Pressure Sys",
                        style: TextStyle(fontSize: 17),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        color: Colors.redAccent,
                        height: 12,
                        width: 30,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        "Pressure Dias",
                        style: TextStyle(fontSize: 17),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 400,
                      width: 400,
                      child: _LineChart(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LineChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LineChart(
        // swapAnimationDuration: const Duration(milliseconds: 250),
        simpleData1);
  }
}

LineChartData get simpleData1 => LineChartData(
      gridData: gridData,
      titlesData: titlesData,
      borderData: borderData,
      lineBarsData: lineBarsData,
      minX: 0,
      maxX: 15,
      minY: 0,
      maxY: 5,
    );

List<LineChartBarData> get lineBarsData =>
    [lineChartBarData1, lineChartBarData2];

FlTitlesData get titlesData => FlTitlesData(
      bottomTitles: AxisTitles(
        sideTitles: bottomTitles,
      ),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      leftTitles: AxisTitles(sideTitles: leftTitles()),
    );

Widget leftTitlesWidget(double value, TitleMeta meta) {
  const style = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.grey,
  );
  String text;
  switch (value.toInt()) {
    case 1:
      text = '20';
      break;
    case 2:
      text = '40';
      break;
    case 3:
      text = '60';
      break;
    case 4:
      text = '80';
      break;
    case 5:
      text = '100';
      break;
    default:
      return Container();
  }
  return Text(
    text,
    style: style,
    textAlign: TextAlign.center,
  );
}

SideTitles leftTitles() => const SideTitles(
      getTitlesWidget: leftTitlesWidget,
      showTitles: true,
      interval: 1,
      reservedSize: 40,
    );

Widget bottomTitlesWidget(double value, TitleMeta meta) {
  const style = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.grey,
  );

  Widget text;
  switch (value.toInt()) {
    case 2:
      text = const Text(
        '29-Jul',
        style: style,
      );
      break;
    case 7:
      text = const Text(
        '29-Sep',
        style: style,
      );
      break;
    case 12:
      text = const Text(
        '29-May',
        style: style,
      );
      break;
    case 17:
      text = const Text(
        '01-Oct',
        style: style,
      );
      break;
    default:
      text = const Text('');
      break;
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 10,
    child: text,
  );
}

SideTitles get bottomTitles => const SideTitles(
      getTitlesWidget: bottomTitlesWidget,
      showTitles: true,
      interval: 1,
      reservedSize: 32,
    );

FlGridData get gridData => const FlGridData(show: true);

FlBorderData get borderData => FlBorderData(
      show: true,
      border: const Border(
        bottom: BorderSide(color: Colors.grey, width: 4),
        left: BorderSide(
          color: Colors.grey,
        ),
        right: BorderSide(
          color: Colors.transparent,
        ),
        top: BorderSide(
          color: Colors.transparent,
        ),
      ),
    );

LineChartBarData get lineChartBarData1 => LineChartBarData(
      isCurved: true,
      color: Colors.blue,
      barWidth: 6,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: const [
        FlSpot(0, 1),
        FlSpot(3, 1.5),
        FlSpot(5, 1),
        FlSpot(7, 1.6),
        FlSpot(10, 2),
        FlSpot(12, 3),
        FlSpot(15, 4),
      ],
    );

LineChartBarData get lineChartBarData2 => LineChartBarData(
      isCurved: true,
      color: Colors.green,
      barWidth: 6,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: const [
        FlSpot(0, 2),
        FlSpot(3, 2.5),
        FlSpot(5, 3),
        FlSpot(7, 1.6),
        FlSpot(8, 2),
        FlSpot(10, 3),
        FlSpot(15, 1),
      ],
    );
