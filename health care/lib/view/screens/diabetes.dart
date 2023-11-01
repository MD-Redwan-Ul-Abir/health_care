import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_health_care/controller/profile_controller.dart';

import '../../controller/needed_information_controller.dart';

class Dabates_info extends StatefulWidget {
  const Dabates_info({Key? key}) : super(key: key);

  @override
  State<Dabates_info> createState() => DabatesinfoState();
}

class DabatesinfoState extends State<Dabates_info> {
  final TextEditingController _controllerBeforeMeal = TextEditingController();
  final TextEditingController _controllerAfterMeal = TextEditingController();
  final TextEditingController _systoleController = TextEditingController();
  final TextEditingController _diastolicController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ডায়াবেটিস এর তথ্য প্রদান করুন"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 50),
              const Text("আপনার রক্তচাপ (Blood Pressure) এর তথ্য প্রদান করুন"),
              const SizedBox(height: 10),
              Column(
                children: [
                  TextFormField(
                    controller: _systoleController,
                    keyboardType: TextInputType.phone,
                    maxLength: 3,
                    decoration: const InputDecoration(
                      labelText: "Systole",
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          int.tryParse(value) == null) {
                        return "Please enter valid information.";
                      } else if (int.tryParse(value)! < 80 ||
                          int.tryParse(value)! > 140) {
                        return "valid range 80-140";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: _diastolicController,
                    keyboardType: TextInputType.phone,
                    maxLength: 3,
                    decoration: const InputDecoration(
                      labelText: "Diastolic",
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          int.tryParse(value) == null) {
                        return "Please enter valid information.";
                      } else if (int.tryParse(value)! < 80 ||
                          int.tryParse(value)! > 140) {
                        return "valid range 80-140";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                      text: TextSpan(
                    children: [
                      TextSpan(
                          text: "ডায়াবেটিস ",
                          style: Theme.of(context).textTheme.bodyMedium),
                      TextSpan(
                          text: "(*যদি থাকে)",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.red)),
                    ],
                  )),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _controllerBeforeMeal,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: "খাবার আগে",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          int.tryParse(value) == null) {
                        return "Please enter valid information.";
                      } else if (int.tryParse(value)! < 0 ||
                          int.tryParse(value)! > 100) {
                        return "valid range 0-100";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _controllerAfterMeal,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: "খাবার পর",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null ||
                          value.isEmpty ||
                          int.tryParse(value) == null) {
                        return "Please enter valid information.";
                      } else if (int.tryParse(value)! < 0 ||
                          int.tryParse(value)! > 100) {
                        return "valid range 0-100";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  GetBuilder<ProfileController>(
                      builder: (profileControllerContext) {
                    // if (profileControllerContext.profileDetailsList.isEmpty) {
                    //   return const SizedBox.shrink();
                    // } else if (profileControllerContext
                    //         .profileDetailsList[0].data !=
                    //     null) {
                    //   var age = profileControllerContext
                    //       .profileDetailsList[0].data!.age;
                    //   var gender = profileControllerContext
                    //       .profileDetailsList[0].data!.gender;

                    return GetBuilder<DiabetesController>(
                        init: DiabetesController(),
                        builder: (context) {
                          return context.isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      var submitData = {
                                        "age": profileControllerContext
                                            .profileDetailsList[0].data!.age,
                                        "gender": profileControllerContext
                                            .profileDetailsList[0].data!.gender,
                                        "bp_sys": _systoleController.text,
                                        "bp_dias": _diastolicController.text,
                                        "db_before_meal":
                                            _controllerBeforeMeal.text,
                                        "db_after_meal":
                                            _controllerAfterMeal.text,
                                      };
                                      context.submitAllDetails(submitData);
                                    }
                                  },
                                  child: const Text("Submit"),
                                );
                        });
                    // }
                    // else {
                    //   return const SizedBox.shrink();
                    // }
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
