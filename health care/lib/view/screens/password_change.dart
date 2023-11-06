import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:patient_health_care/controller/auth_controller.dart';

class PwdChangeScreen extends StatefulWidget {
  const PwdChangeScreen({super.key});

  @override
  State<PwdChangeScreen> createState() => _PwdChangeScreenState();
}

class _PwdChangeScreenState extends State<PwdChangeScreen> {
  bool isVisible = false;
  final Box boxLogin = Hive.box("login");
  final TextEditingController _controllerOldPassword = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConfirmPassword =
      TextEditingController();
  final AuthController _authController = Get.put(AuthController());
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('পাসওয়ার্ড পরিবর্তন'),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const Text(
                textAlign: TextAlign.center,
                'আপনার পাসওয়ার্ড পরিবর্তন করতে নিচের তথ্য দিয়ে সাবমিট করুন',
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _controllerOldPassword,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.password),
                    border: OutlineInputBorder(),
                    labelText: 'পুরাতন পাসওয়ার্ড',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'পুরাতন পাসওয়ার্ড দিন';
                    }
                    if (value != boxLogin.get(boxLogin.get('email'))) {
                      return 'পুরাতন পাসওয়ার্ড ভুল';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _controllerPassword,
                  obscureText: isVisible ? false : true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        child: Icon(isVisible
                            ? Icons.visibility
                            : Icons.visibility_off)),
                    border: const OutlineInputBorder(),
                    labelText: 'নতুন পাসওয়ার্ড',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'নতুন পাসওয়ার্ড দিন';
                    }
                    if (value.length < 6) {
                      return 'পাসওয়ার্ড অবশ্যই ৬ অক্ষরের বেশি হতে হবে';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _controllerConfirmPassword,
                  obscureText: isVisible ? false : true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        child: Icon(isVisible
                            ? Icons.visibility
                            : Icons.visibility_off)),
                    border: const OutlineInputBorder(),
                    labelText: 'নতুন পাসওয়ার্ড নিশ্চিত করুন',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'নতুন পাসওয়ার্ড নিশ্চিত করুন';
                    }
                    if (value != _controllerPassword.text) {
                      return 'পাসওয়ার্ড মিলছে না';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              Obx(
                () => _authController.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _authController.changePassword(
                                _controllerOldPassword.text,
                                _controllerPassword.text);
                          }
                        },
                        child: const Text('সাবমিট'),
                      ),
              ),
            ],
          ),
        ));
  }
}
