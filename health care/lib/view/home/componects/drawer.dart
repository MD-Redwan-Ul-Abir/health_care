import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:patient_health_care/view/home/Home.dart';
import 'package:patient_health_care/view/registration/log_in.dart';
import 'package:patient_health_care/view/screens/appointment/all_apointment.dart';
import 'package:patient_health_care/view/screens/appointment/new_appointment.dart';
import 'package:patient_health_care/view/screens/appointment/painding_appointment.dart';
import 'package:patient_health_care/view/screens/diabetes.dart';
import 'package:patient_health_care/view/screens/question_answer/answer/answered_question.dart';
import 'package:patient_health_care/view/screens/question_answer/ask_question.dart';
import 'package:patient_health_care/view/screens/question_answer/not_answered.dart';

class AllDrawer extends StatefulWidget {
  const AllDrawer({super.key});

  @override
  State<AllDrawer> createState() => _DraderState();
}

class _DraderState extends State<AllDrawer> {
  final Box _boxLogin = Hive.box("login");
  final Box _boxAccount = Hive.box("accounts");

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromRGBO(32, 63, 140, 1.0),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.apartment_sharp,
                  size: 30,
                  color: Colors.white,
                ),
                Text(
                  'হিয়ে',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
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
              _boxLogin.clear();
              _boxAccount.clear();
              Get.offAll(() => const Login());
            },
          ),
        ],
      ),
    );
  }
}
