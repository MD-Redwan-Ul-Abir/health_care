import 'package:flutter/material.dart';
import 'package:patient_health_care/view/registration/forgetPassword/setNewPassword.dart';

class veryfy extends StatefulWidget {
  const veryfy({super.key});

  @override
  State<veryfy> createState() => _veryfyState();
}

class _veryfyState extends State<veryfy> {
  final RegExp _NumberRegExp = RegExp(r'^[0-9]+$');
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verification Code"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              const SizedBox(
                height: 200,
              ),
              TextFormField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Verification Code",
                  prefixIcon: const Icon(Icons.domain_verification),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter verification code";
                  } else if (!_NumberRegExp.hasMatch(value)) {
                    return "Wrong code";
                  }

                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.reset();

                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return set_new_password();
                    }));
                  }
                },
                child: const Text("Verify"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
