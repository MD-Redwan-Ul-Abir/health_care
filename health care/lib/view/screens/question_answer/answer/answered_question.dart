import 'package:flutter/material.dart';
import 'package:patient_health_care/view/home/componects/drawer.dart';
import 'package:patient_health_care/view/screens/question_answer/answer/response_list.dart';

class AnsWer extends StatefulWidget {
  const AnsWer({super.key});

  @override
  State<AnsWer> createState() => _AnsWerState();
}

class _AnsWerState extends State<AnsWer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("উত্তর সমূহ"),
      ),
      drawer: const AllDrawer(),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return Card(
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
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: ListTile(
                  title: Text("Doctor Name"),
                  subtitle: Row(
                    children: [
                      Expanded(child: Text("The AnsWered quesion ?")),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("20/10/2023"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
