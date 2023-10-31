import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:patient_health_care/controller/doctor_controller.dart";
import "package:skeletons/skeletons.dart";

class NotAnswerd extends StatefulWidget {
  const NotAnswerd({super.key});

  @override
  State<NotAnswerd> createState() => _NotAnswerdState();
}

class _NotAnswerdState extends State<NotAnswerd> {
  @override
  void initState() {
    loadData();
    super.initState();
  }

  Future<void> loadData() async {
    Get.put(DoctorController());
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Get.find<DoctorController>().getAllQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "উত্তর পাওয়া যাইনি",
        ),
      ),
      body: GetBuilder<DoctorController>(
        builder: (controller) => controller.isLoading
            ? SkeletonListView(
                itemCount: 5,
                itemBuilder: (p0, p1) {
                  return SkeletonListTile(
                    hasLeading: false,
                    hasSubtitle: true,
                  );
                },
              )
            : ListView.builder(
                itemCount: controller.allQuestion.length,
                itemBuilder: (BuildContext context, int index) {
                  String doctorName = controller.doctorList
                          .firstWhereOrNull((element) =>
                              element.id.toString() ==
                              controller.allQuestion[index].doctorId)
                          ?.docName ??
                      "error";
                  return Card(
                    child: GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ListTile(
                          title: Text(doctorName),
                          subtitle: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                      controller.allQuestion[index].question ??
                                          "")),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(controller
                                    .allQuestion[index].createdAt
                                    .toString()
                                    .split(" ")[0]),
                              ),
                            ],
                          ),
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
