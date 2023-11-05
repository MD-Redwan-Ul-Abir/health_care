import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:patient_health_care/controller/auth_controller.dart';

class Veryfy extends StatefulWidget {
  const Veryfy({super.key});

  @override
  State<Veryfy> createState() => _VeryfyState();
}

class _VeryfyState extends State<Veryfy> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final Box _boxRegister = Hive.box('accounts');
  final TextEditingController _controllerCode = TextEditingController();
  final AuthController _authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verification Code"),
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
                controller: _controllerCode,
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
                  } else if (_controllerCode.text !=
                      _boxRegister.get('resetOtp')) {
                    return "Please enter correct code";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => _authController.isLoading.value
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            _authController.forgetPassword(
                                isSend: false,
                                isDone: true,
                                otp: _controllerCode.text,
                                resetToken: _boxRegister.get('resetToken'));
                            _formKey.currentState?.reset();
                          }
                        },
                        child: const Text("Verify"),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
