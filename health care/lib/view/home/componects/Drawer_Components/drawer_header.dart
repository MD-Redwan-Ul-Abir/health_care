import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../controller/profile_controller.dart';

class MyHeaderDrawer extends StatefulWidget {
  const MyHeaderDrawer({Key? key});

  @override
  State<MyHeaderDrawer> createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  bool isEdit = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final Box _profile = Hive.box('profileDetails');
  XFile? image;

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _profile.put(_profile.get('name'), pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return DrawerHeader(
      decoration: const BoxDecoration(color: Color.fromRGBO(32, 63, 140, 1.0)),
      padding: const EdgeInsets.all(10),
      child: GetBuilder<ProfileController>(
        builder: (menueProfileController) {
          emailController.text = _profile.get('email') ??
              menueProfileController.profileDetailsList[0].data!.email!;
          nameController.text = _profile.get('name') ??
              menueProfileController.profileDetailsList[0].data!.name!;
          image = XFile(_profile.get(_profile.get('name')) ?? 'assets/pp.png');
          return Stack(
            children: [
              // Container(),
              // Image
              Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: isEdit
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () => isEdit ? pickImage() : null,
                      child: Container(
                        width: size.width * 0.2,
                        height: size.width * 0.2,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(
                              image!.path,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: isEdit ? size.height * 0.005 : 0,
                    ),
                    // Name
                    isEdit
                        ? SizedBox(
                            height: size.height * 0.035,
                            child: TextFormField(
                              controller: nameController,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                hintText: "Name",
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                nameController.text = value;
                              },
                            ),
                          )
                        : Text(
                            nameController.text,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                    SizedBox(
                      height: isEdit ? size.height * 0.005 : 0,
                    ),
                    // Email
                    isEdit
                        ? SizedBox(
                            height: size.height * 0.035,
                            child: TextFormField(
                              controller: emailController,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  hintText: "Email",
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  )),
                              onChanged: (value) {
                                emailController.text = value;
                              },
                            ),
                          )
                        : Text(
                            emailController.text,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300),
                          ),
                  ],
                ),
              ),
              // Edit button for profile
              const SizedBox(
                width: 10,
              ),
              Positioned(
                top: 0,
                right: 0,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (isEdit) {
                        // Save changes to the profile details
                        // menueProfileController.updateProfile(
                        //   nameController.text,
                        //   emailController.text,
                        //   image,
                        // );
                        _profile.put('name', nameController.text);
                        _profile.put('email', emailController.text);
                        _profile.put(_profile.get('name'), image!.path);
                      }
                      isEdit = !isEdit;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minimumSize: const Size(40, 30),
                  ),
                  child: Text(
                    isEdit ? "Save" : "Edit",
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
