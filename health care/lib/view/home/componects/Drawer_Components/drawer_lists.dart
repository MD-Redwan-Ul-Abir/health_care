import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:get/get.dart';
import '../../../registration/log_in.dart';
import '../../../screens/appointment/all_apointment.dart';
import '../../../screens/appointment/new_appointment.dart';
import '../../../screens/appointment/painding_appointment.dart';
import '../../../screens/diabetes.dart';
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
            // Implement All Appoinment

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const Homepage();
                },
              ),
            );
          },
        ),
        ExpansionTile(
          leading: const Icon(Icons.note_alt),
          title: const Text('ডায়াবেটিস'),
          children: <Widget>[
            ListTile(
              title: const Text('প্রয়োজনীয় তথ্য'),
              onTap: () {
                // Implement Necessary Information
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const diabates_info();
                  },
                ));
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
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const AskQuestion();
                  },
                ));
              },
            ),
            ListTile(
              title: const Text('পেইনডিং প্রশ্ন'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const NotAnswerd();
                  },
                ));
              },
            ),
            ListTile(
              title: const Text('সকল উত্তর'),
              onTap: () {
                // Implement All Question/Answer
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                      return const AnsWer();
                    }));
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
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                      return const NewAppointment();
                    }));
              },
            ),
            ListTile(
              title: const Text('পেন্ডিং এপোয়েনমেন্ট'),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                      return const PaindingAppointment();
                    }));
              },
            ),
            ListTile(
              title: const Text('সকল এপোয়েনমেন্ট'),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                      return const AllAppointment();
                    }));
              },
            ),
          ],
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
