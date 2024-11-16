import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../theme.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import '../../common_widgets/settings_value.dart';
import '../../common_widgets/textField.dart';
import '../../controller/admin_Controller/adminController.dart';

class SettingsView extends GetView<AdminController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AdminController());
    return Scaffold(
        backgroundColor: ThemeColor.background,
        body: SingleChildScrollView(
          child: SafeArea(
              child: GetBuilder<AdminController>(
            builder: (controller) => Column(children: [
              const SizedBox(height: 35),
              FadeInDown(
                delay: const Duration(milliseconds: 200),
                curve: Curves.decelerate,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        const CircleAvatar(
                          radius: 70,
                          backgroundImage:
                              AssetImage("assets/img/profilePic.png"),
                        ),
                        Positioned(
                          right: 10,
                          bottom: 1,
                          child: InkWell(
                            onTap: () {},
                            child: CircleAvatar(
                              backgroundColor: ThemeColor.white,
                              radius: 20,
                              child: const Icon(
                                Icons.camera_alt,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 15,
                                    bottom: 2,
                                  ),
                                  child: Text(
                                    "معلومات حسابي ",
                                    style: TextStyle(
                                        color: ThemeColor.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 20, right: 20, bottom: 20),
                              child: Column(children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                      top: 15,
                                      right: 15,
                                      bottom: 15,
                                      left: 2.5),
                                  decoration: BoxDecoration(
                                    color: ThemeColor.primary.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Column(
                                    children: [
                                      SettingsValue(
                                        name: "الاسم",
                                        icon: Icons.person,
                                        child: Text(
                                          "${controller.name}",
                                          style: TextStyle(
                                              color: ThemeColor.white),
                                        ),
                                        onTap2: () {},
                                      ),
                                      const SizedBox(height: 5),
                                      SettingsValue(
                                        name: "البريد الإلكتروني",
                                        icon: Icons.mail,
                                        child: Text(
                                          "${controller.email}",
                                          style: TextStyle(
                                              color: ThemeColor.white),
                                        ),
                                        onTap2: () {},
                                      ),
                                      const SizedBox(height: 5),
                                      SettingsValue(
                                        name: "كلمة السر ",
                                        icon: Icons.password,
                                        child: Text(
                                          "${controller.password}",
                                          style: TextStyle(
                                              color: ThemeColor.white),
                                        ),
                                        onTap2: () {},
                                      ),
                                      const SizedBox(height: 10),
                                      InkWell(
                                        onTap: () {
                                          _showEditProfileDialog(context);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              top: 8,
                                              bottom: 8,
                                              right: 15,
                                              left: 15),
                                          decoration: BoxDecoration(
                                              color: ThemeColor.primary
                                                  .withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              border: Border.all(
                                                  color: ThemeColor.primary
                                                      .withOpacity(0.15))),
                                          child: Text(
                                            "تعديل ",
                                            style: TextStyle(
                                                color: ThemeColor.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                            Container(
                              // height: media.width * 1,
                              padding: const EdgeInsets.only(
                                  top: 10, left: 20, right: 20, bottom: 20),
                              child: Column(children: [
                                Container(
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: ThemeColor.primary.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Column(
                                    children: [
                                      SettingsValue(
                                        name: "تسجيل خروج ",
                                        icon: Icons.logout_outlined,
                                        child: const SizedBox(),
                                        onTap2: () {
                                          showPlatformDialog(
                                            context: context,
                                            builder: (context) =>
                                                BasicDialogAlert(
                                              title: const Text(
                                                  "هل تريد الخروج من الحساب "),
                                              actions: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    BasicDialogAction(
                                                      title: const Text("نعم"),
                                                      onPressed: () {
                                                        controller.logout();
                                                      },
                                                    ),
                                                    BasicDialogAction(
                                                      title: const Text("لا"),
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 5),
                                      SettingsValue(
                                        name: "حذف الحساب",
                                        icon: Icons.delete,
                                        child: const SizedBox(),
                                        onTap2: () {
                                          showPlatformDialog(
                                            context: context,
                                            builder: (context) =>
                                                BasicDialogAlert(
                                              title: const Center(
                                                  child: Text(
                                                      "هل تريد حذف الحساب ")),
                                              actions: <Widget>[
                                                BasicDialogAction(
                                                  title: const Text("نعم"),
                                                  onPressed: () {
                                                    controller.delete(
                                                        "Admin",
                                                        FirebaseAuth.instance
                                                            .currentUser!.uid);
                                                  },
                                                ),
                                                BasicDialogAction(
                                                  title: const Text("لا"),
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ]),
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
            ]),
          )),
        ));
  }

  void _showEditProfileDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return GetBuilder<AdminController>(
            builder: (controller) => AlertDialog(
                  content: Form(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomTextFieldWithoutIcon(
                          onIconPressed: () {},
                          title: "${controller.userNameC.text}",
                          controller: controller.userNameC,
                          keyboardType: TextInputType.name,
                          obscureText: false,
                        ),
                        const SizedBox(height: 10),
                        CustomTextFieldWithoutIcon(
                          onIconPressed: () {},
                          title: "${controller.emailC.text}",
                          controller: controller.emailC,
                          keyboardType: TextInputType.name,
                          obscureText: false,
                        ),
                        const SizedBox(height: 10),
                        CustomTextFieldWithoutIcon(
                          onIconPressed: () {},
                          title: "${controller.passwordC.text}",
                          controller: controller.passwordC,
                          keyboardType: TextInputType.name,
                          obscureText: false,
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          child: const Text('ألغاء'),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                        TextButton(
                          child: const Text('حفظ'),
                          onPressed: () {
                            controller.saveChanges();
                          },
                        ),
                      ],
                    )
                  ],
                ));
      },
    );
  }
}
