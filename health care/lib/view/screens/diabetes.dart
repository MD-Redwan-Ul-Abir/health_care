import 'package:flutter/material.dart';


class diabates_info extends StatefulWidget {

  const diabates_info({super.key});


  @override
  State<diabates_info> createState() => _diabates_infoState();
}

class _diabates_infoState extends State<diabates_info> {

  final TextEditingController _controllerBefore_Meal = TextEditingController();
  final TextEditingController _controllerAfter_Meal = TextEditingController();

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
              Text("আপনার রক্তচাপ (Blood Pressure) এর তথ্য প্রদান করুন"),
              const SizedBox(height: 10),
               Column(
                 children: [
                   TextFormField(

                     keyboardType: TextInputType.phone,
                     maxLength: 3,
                     decoration: InputDecoration(
                       labelText: "Systole",
                     ),
                   ),
                   const SizedBox(height: 5,),
                   TextFormField(
                     keyboardType: TextInputType.phone,
                     maxLength: 3,
                     decoration: InputDecoration(
                       labelText: "Diastolic",

                     ),
                   ),
                   const SizedBox(height: 10,),
                   Text("ডায়াবেটিস (*যদি থাকে)",
                     style: Theme.of(context).textTheme.bodyMedium,),
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
                   ElevatedButton(
                     style: ElevatedButton.styleFrom(
                       minimumSize: const Size.fromHeight(50),
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(20),
                       ),
                     ),
                     onPressed: () {
                       //implement this function after implemeting api

                     },
                     child: const Text("Submit"),
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
