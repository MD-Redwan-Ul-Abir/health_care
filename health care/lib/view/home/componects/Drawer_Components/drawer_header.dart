import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/profile_controller.dart';

class MyHeaderDrawer extends StatefulWidget {
  const MyHeaderDrawer({super.key});

  @override
  State<MyHeaderDrawer> createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  // ProfileController menueProfileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return DrawerHeader(
      decoration: const BoxDecoration(color: Color.fromRGBO(32, 63, 140, 1.0)),
      padding: const EdgeInsets.all(10),
      child: GetBuilder<ProfileController>(
        builder: (menueProfileController) {
          final image = menueProfileController.profileDetailsList[0].data?.image;
          return Column(
            children: [

              //Image
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                height: size.height * 0.090,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                  image: image != null
                      ? DecorationImage(image: AssetImage(image))
                      : null,
                ),
                child: image == null
                    ? Center(
                  child: Text(
                    menueProfileController.profileDetailsList[0].data?.email?[0] ?? '',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                )
                    : null,
              ),

              //Name
              Text(
                "${menueProfileController.profileDetailsList[0].data!.name}",
                style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
              ),
              Text(
                  "${menueProfileController.profileDetailsList[0].data!.email}",
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
