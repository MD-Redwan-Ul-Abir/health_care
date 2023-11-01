import 'package:flutter/material.dart';

class ResponseLi extends StatefulWidget {
  const ResponseLi({super.key});

  @override
  State<ResponseLi> createState() => _ResponseLiState();
}

class _ResponseLiState extends State<ResponseLi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("উত্তর"),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: GestureDetector(
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: ListTile(
                  title: Text("The answered question?"),
                  subtitle: Row(
                    children: [
                      Expanded(
                          child: Text(
                              "here we have answered the question from the patient. now we are just checking it ")),
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
