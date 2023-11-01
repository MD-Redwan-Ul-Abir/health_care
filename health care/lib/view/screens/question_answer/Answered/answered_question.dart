// import 'package:flutter/material.dart';
// import 'package:patient_health_care/view/home/componects/drawer.dart';
// import 'package:patient_health_care/view/screens/question_answer/answer/response_list.dart';
// import 'package:get/get.dart';
//
// import '../../../../controller/doctor_controller.dart';
//
// class AnsWer extends StatefulWidget {
//   const AnsWer({super.key});
//
//   @override
//   State<AnsWer> createState() => _AnsWerState();
// }
//
// class _AnsWerState extends State<AnsWer> {
//
//   // final doctorAnswerController = Get.put(DoctorController());
//   int questionNotAnswered = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("উত্তর সমূহ"),
//       ),
//       drawer: const AllDrawer(),
//       body: GetBuilder<DoctorController>(
//         builder: (doctorAnswerController){
//
//           doctorAnswerController.allQuestion.forEach((element) {
//             if(element.status == null){
//               questionNotAnswered++;
//               print("Not Answered : ${questionNotAnswered}");
//             }
//           });
//
//           return ListView.builder(
//             itemCount: doctorAnswerController.allQuestion.length,
//             itemBuilder: (BuildContext context, int index) {
//               // return doctorAnswerController.allQuestion[index].status == null ? Card(
//               //   child: GestureDetector(
//               //     onTap: () {
//               //       // Navigate to another page when the card is tapped
//               //       Navigator.of(context).push(
//               //         MaterialPageRoute(
//               //           builder: (context) {
//               //             // here we will sent the question , response, doctor name date
//               //             return const ResponseLi();
//               //           },
//               //         ),
//               //       );
//               //     },
//               //     child: const Padding(
//               //       padding: EdgeInsets.all(12.0),
//               //       child: ListTile(
//               //         title: Text("Doctor Name"),
//               //         subtitle: Row(
//               //           children: [
//               //             Expanded(child: Text("The AnsWered quesion ?")),
//               //             Padding(
//               //               padding: EdgeInsets.all(8.0),
//               //               child: Text("20/10/2023"),
//               //             ),
//               //           ],
//               //         ),
//               //       ),
//               //     ),
//               //   ),
//               // ) : const Center(child: Text("No response to show!")
//
//                 return doctorAnswerController.allQuestion[index].status != null ? Card(
//                   child: GestureDetector(
//                     onTap: () {
//                       // Navigate to another page when the card is tapped
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (context) {
//                             // here we will sent the question , response, doctor name date
//                             return const ResponseLi();
//                           },
//                         ),
//                       );
//                     },
//                     child: const Padding(
//                       padding: EdgeInsets.all(12.0),
//                       child: ListTile(
//                         title: Text("Doctor Name"),
//                         subtitle: Row(
//                           children: [
//                             Expanded(child: Text("The AnsWered quesion ?", )),
//                             Padding(
//                               padding: EdgeInsets.all(8.0),
//                               child: Text("20/10/2023"),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ) : questionNotAnswered==1 || questionNotAnswered>1 ? const Center(child: Text("Nothing to show")) : null;
//
//
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// Working version : 1

import 'package:flutter/material.dart';
import 'package:patient_health_care/view/home/componects/drawer.dart';
import 'package:get/get.dart';
import 'package:patient_health_care/view/screens/question_answer/Answered/response_list.dart';

import '../../../../controller/doctor_controller.dart';

class AnsWer extends StatefulWidget {
  const AnsWer({super.key});

  @override
  State<AnsWer> createState() => _AnsWerState();
}

class _AnsWerState extends State<AnsWer> {
  // DoctorController doctorAnswerController = Get.put(DoctorController());

  @override
  void initState() {
    loadDataOfDoctorsReplay();
    super.initState();
  }

  Future<void> loadDataOfDoctorsReplay() async {
    Get.put(DoctorController());
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Get.find<DoctorController>().getAllQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("উত্তর সমূহ"),
      ),
      drawer: const AllDrawer(),
      body: GetBuilder<DoctorController>(
        builder: (doctorAnswerController) {
          return ListView.builder(
            itemCount: doctorAnswerController.allQuestion.length,
            itemBuilder: (BuildContext context, int index) {
              var doctorName = doctorAnswerController.doctorList
                      .firstWhereOrNull((element) =>
                          element.id.toString() ==
                          doctorAnswerController.allQuestion[index].doctorId)
                      ?.docName ??
                  "error";
              return doctorAnswerController.allQuestion[index].answer == null
                  ? const SizedBox.shrink()
                  : Card(
                      child: GestureDetector(
                        onTap: () {
                          // Navigate to another page when the card is tapped
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                // here we will sent the question , response, doctor name date
                                return const ResponseLi();
                              },
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ListTile(
                            title: Text(doctorName),
                            subtitle: Row(
                              children: [
                                Expanded(
                                    child: Text(doctorAnswerController
                                            .allQuestion[index].question ??
                                        "")),
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(doctorAnswerController
                                        .allQuestion[index].createdAt
                                        .toString()
                                        .substring(0, 10))),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
            },
          );
        },
      ),
    );
  }
}
