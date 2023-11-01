import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:get/get.dart';
import 'package:patient_health_care/view/screens/diabetes.dart';
import 'package:patient_health_care/view/screens/password_change.dart';
import '../../../registration/log_in.dart';
import '../../../screens/appointment/all_apointment.dart';
import '../../../screens/appointment/new_appointment.dart';
import '../../../screens/appointment/painding_appointment.dart';
import '../../../screens/question_answer/Answered/answered_question.dart';
import '../../../screens/question_answer/Question_Asking/ask_question.dart';
import '../../../screens/question_answer/Question_Not_Answered/not_answered.dart';
import '../../Home.dart';

class MyDrawerLists extends StatelessWidget {
  const MyDrawerLists({super.key});

  @override
  Widget build(BuildContext context) {
    final Box boxLogin = Hive.box("login");
    final Box boxAccount = Hive.box("accounts");

    return Column(
      children: [
        ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('ড্যাশবোর্ড'),
            onTap: () {
              Get.to(() => const Homepage());
              Get.back();
            }),
        ExpansionTile(
          leading: const Icon(Icons.note_alt),
          title: const Text('ডায়াবেটিস'),
          children: <Widget>[
            ListTile(
              title: const Text('প্রয়োজনীয় তথ্য'),
              onTap: () {
                Get.to(() => const Dabates_info());
              },
            ),
          ],
        ),
        ExpansionTile(
          leading: const Icon(Icons.question_answer),
          title: const Text('প্রশ্নোত্তর'),
          children: <Widget>[
            ListTile(
              title: const Text('প্রশ্ন করুন'),
              onTap: () {
                Get.to(() => const AskQuestion());
              },
            ),
            ListTile(
              title: const Text('পেইনডিং প্রশ্ন'),
              onTap: () {
                Get.to(() => const NotAnswerd());
              },
            ),
            ListTile(
              title: const Text('সকল উত্তর'),
              onTap: () {
                Get.to(() => const AnsWer());
              },
            ),
          ],
        ),
        ExpansionTile(
          leading: const Icon(Icons.note_alt_outlined),
          title: const Text('এপোয়েনমেন্ট'),
          children: <Widget>[
            ListTile(
              title: const Text('নতুন অ্যাপয়েন্টমেন্ট'),
              onTap: () {
                Get.to(() => const NewAppointment());
              },
            ),
            ListTile(
              title: const Text('পেন্ডিং এপোয়েনমেন্ট'),
              onTap: () {
                Get.to(() => const PaindingAppointment());
              },
            ),
            ListTile(
              title: const Text('সকল এপোয়েনমেন্ট'),
              onTap: () {
                Get.to(() => const AllAppointment());
              },
            ),
          ],
        ),
        ListTile(
          leading: const Icon(Icons.password),
          title: const Text('পাসওয়ার্ড পরিবর্তন'),
          onTap: () {
            Get.to(() => const PwdChangeScreen());
          },
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('লগআউট'),
          onTap: () {
            boxLogin.clear();
            boxAccount.clear();
            Get.offAll(() => const Login());
          },
        ),
      ],
    );
  }
}
