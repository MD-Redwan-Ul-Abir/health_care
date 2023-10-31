import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_health_care/controller/doctor_controller.dart';
import 'package:patient_health_care/view/home/componects/drawer.dart';

class PaindingAppointment extends StatefulWidget {
  const PaindingAppointment({super.key});

  @override
  State<PaindingAppointment> createState() => _PaindingAppointmentState();
}

class _PaindingAppointmentState extends State<PaindingAppointment> {
  @override
  void initState() {
    loadData();
    super.initState();
  }

  Future<void> loadData() async {
    Get.put(DoctorController());
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Get.find<DoctorController>().fetchPendingAppointment();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('পেন্ডিং এপোয়েনমেন্ট'),
      ),
      drawer: const AllDrawer(),
      body: GetBuilder<DoctorController>(
        builder: (controller) => controller.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: controller.pendingAppointment.length,
                itemBuilder: (BuildContext context, int index) {
                  String doctorName = controller.doctorList
                          .firstWhereOrNull((element) =>
                              element.id.toString() ==
                              controller.pendingAppointment[index].docId)
                          ?.docName ??
                      "error";
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ListTile(
                        title: Text(
                          doctorName,
                          style: const TextStyle(
                            color: Colors.orange,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(controller.pendingAppointment[index].reason!),
                            Row(
                              children: [
                                Icon(Icons.email),
                                SizedBox(width: 8),
                                Text(
                                  controller.pendingAppointment[index].email!,
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.access_time),
                                SizedBox(width: 8),
                                Text(
                                    '${controller.pendingAppointment[index].appointmentDate.toString().split(" ")[0]}    ${controller.pendingAppointment[index].appointmentTime}'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
