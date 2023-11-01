import 'package:flutter/material.dart';
import 'package:patient_health_care/view/home/componects/drawer.dart';

class AllAppointment extends StatefulWidget {
  const AllAppointment({super.key});

  @override
  State<AllAppointment> createState() => _AllAppointmentState();
}

class _AllAppointmentState extends State<AllAppointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All question"),
      ),
      drawer: const AllDrawer(),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return const Card(
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: ListTile(
                title: Text(
                  "Doctor Name",
                  style: TextStyle(
                    color: Colors.orange,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("All the appoontments."),
                    Row(
                      children: [
                        Icon(Icons.email),
                        SizedBox(width: 8),
                        Text(
                          "doctor@example.com",
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
                        Text("20/10/2023 10:00 AM"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
