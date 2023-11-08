import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_health_care/controller/profile_controller.dart';

import '../../controller/needed_information_controller.dart';

class Dabates_info extends StatefulWidget {

  const Dabates_info({Key? key}) : super(key: key);


  @override
  State<Dabates_info> createState() => _Dabates_infoState();
}

class _Dabates_infoState extends State<Dabates_info> {

  //
  // @override
  // void initState() {
  //   loadData();
  //   super.initState();
  // }
  //
  // Future<void> loadData() async {
  //   Get.put(ProfileController());
  //   WidgetsBinding.instance.addPostFrameCallback((_) async {
  //     await Get.find<ProfileController>().profileDetailsList[0];
  //   });
  //
  //   WidgetsBinding.instance.addPostFrameCallback((_) async {
  //     await Get.find<diabetesController>().isLoading;
  //   });
  // }


  final TextEditingController _controllerBefore_Meal = TextEditingController();
  final TextEditingController _controllerAfter_Meal = TextEditingController();
  final TextEditingController _systoleController = TextEditingController();
  final TextEditingController _diastolicController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ডায়াবেটিস এর তথ্য প্রদান করুন"),
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
                   ),
                   const SizedBox(height: 5,),
                   TextFormField(
                     controller: _diastolicController,
                     keyboardType: TextInputType.phone,
                     maxLength: 3,
                     decoration: const InputDecoration(
                       labelText: "Diastolic",

                     ),
                   ),
                   const SizedBox(height: 10,),
                   // Text("ডায়াবেটিস (*যদি থাকে)",
                   //   style: Theme.of(context).textTheme.bodyMedium,),

                   RichText(
                       text: TextSpan(
                         children: [
                           TextSpan(text: "ডায়াবেটিস ",style: Theme.of(context).textTheme.bodyMedium),
                           TextSpan(text: "(*যদি থাকে)",style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.red)),
                         ],
                       )
                   ),
                   const SizedBox(height: 30,),
                   TextFormField(
                     controller: _controllerBefore_Meal,
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
                     validator: (String? value) {
                       if (value == null || value.isEmpty) {
                         return "Please enter username.";
                       }

                       return null;
                     },

                   ),
                   const SizedBox(height: 10,),

                   TextFormField(
                     controller: _controllerAfter_Meal,
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
                       if (value == null || value.isEmpty) {
                         return "Please enter username.";
                       }

                       return null;
                     },

                   ),
                   const SizedBox(height: 80,),
                   GetBuilder<ProfileController>(
                       builder: (profileControllerContext){
                         if(profileControllerContext.profileDetailsList.isEmpty){
                           return const SizedBox.shrink();
                         }
                         else if(profileControllerContext.profileDetailsList[0].data != null){
                             var age = profileControllerContext.profileDetailsList[0].data!.age;
                             var gender = profileControllerContext.profileDetailsList[0].data!.gender;

                             return GetBuilder<DiabetesController>(
                                 init: DiabetesController(),
                                 builder: (context){
                                   return context.isLoading ? const Center(child: CircularProgressIndicator(),) :  ElevatedButton(
                                     style: ElevatedButton.styleFrom(
                                       minimumSize: const Size.fromHeight(50),
                                       shape: RoundedRectangleBorder(
                                         borderRadius: BorderRadius.circular(20),
                                       ),
                                     ),
                                     onPressed: () {
                                       //implement this function after implemeting api
                                       print("${age},\n${gender},\n${_systoleController.text},\n${_diastolicController.text},\n${_controllerBefore_Meal.text},\n${_controllerAfter_Meal.text},\n");

                                       var submitData = {
                                         "age" : age,
                                         "gender" : gender,
                                         "bp_sys" : _systoleController.text,
                                         "bp_dias" : _diastolicController.text,
                                         "db_before_meal" : _controllerBefore_Meal.text,
                                         "db_after_meal" : _controllerAfter_Meal.text,

                                       };

                                       context.submitAllDetails(submitData);
                                     },
                                     child: const Text("Submit"),
                                   );
                                 }
                             );
                           }
                         else{
                           return const SizedBox.shrink();
                         }




                       }
                   ),


                 ],
               ),



            ],
          ),
        ),
      ),
    );
  }
}
