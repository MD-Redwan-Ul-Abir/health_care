import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_health_care/controller/doctor_controller.dart';

class AskQuestion extends StatefulWidget {
  const AskQuestion({super.key});

  @override
  State<AskQuestion> createState() => _AskQuestionState();
}

class _AskQuestionState extends State<AskQuestion> {
  // final _doctorlist = ["doctor 1", "Doctor 2", "Doctor 3", "Doctor 4"];
  String? _selectedVal = "";
  // _AskQuestionState() {
  //   _selectedVal = _doctorlist[0];
  // }
  // String dropdownvalue = 'Doctor 1';
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _controllerQuestions = TextEditingController();
  @override
  void dispose() {
    _controllerQuestions.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("প্রশ্ন জিজ্ঞাস করুন"),
      ),
      //drawer: all_drower(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: GetBuilder<DoctorController>(
            builder: (controller) {
              _selectedVal = controller.doctorList[0].id.toString();
              return Column(
                children: [
                  const SizedBox(height: 150),
                  Text(
                    "ডাক্তার নির্বাচন করুন",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField(
                    value: _selectedVal,
                    items: controller.doctorList
                        .map(
                          (e) => DropdownMenuItem(
                            value: e.id.toString(),
                            child: Text(e.docName ?? ""),
                          ),
                        )
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        _selectedVal = val.toString();
                        print(_selectedVal);
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_drop_down_circle,
                      color: Color.fromRGBO(32, 63, 129, 1.0),
                    ),
                    dropdownColor: const Color.fromRGBO(212, 223, 253, 1.0),
                    decoration: InputDecoration(
                      labelText: "Doctor",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "আপনার প্রশ্নটি লিখুন",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  // question adding

                  //here user will put their question
                  const SizedBox(
                    height: 10,
                  ),

                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 9 * 20.0),
                    child: TextFormField(
                      controller: _controllerQuestions,
                      keyboardType: TextInputType.name,
                      maxLines: null, // Set to null to allow multiple lines

                      decoration: InputDecoration(
                        labelText: "Question",
                        labelStyle: const TextStyle(
                          fontSize: 16,
                        ),

                        // prefixIcon: Padding(
                        //   padding: const EdgeInsets.all(1),
                        //
                        // ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "আপনার প্রশ্ন টি লিখুন";
                        }
                        return null;
                      },
                    ),
                  ),

                  const SizedBox(height: 50),
                  Column(
                    children: [
                      controller.isLoading
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //   SnackBar(
                                  //     width: 200,
                                  //     backgroundColor:
                                  //         Theme.of(context).colorScheme.secondary,
                                  //     shape: RoundedRectangleBorder(
                                  //       borderRadius: BorderRadius.circular(10),
                                  //     ),
                                  //     behavior: SnackBarBehavior.floating,
                                  //     content:
                                  //         const Text("Question added successfully"),
                                  //   ),
                                  // );
                                  controller.submitQuestion(
                                      _controllerQuestions.text, _selectedVal!);
                                  _formKey.currentState?.reset();

                                  // Navigator.pop(context,MaterialPageRoute(builder: (context){
                                  //   return home();
                                  // }));
                                }
                              },
                              child: const Text("Submit"),
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
