import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourhand/controller/admin_Controller/adminController.dart';
import '../../theme.dart';

class ManageUsersAccounts extends StatelessWidget {
  const ManageUsersAccounts({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AdminController());
    return GetBuilder<AdminController>(builder: (controller)=>
        Scaffold(
            backgroundColor: ThemeColor.background,
            bottomNavigationBar: SizedBox(
              height: 95,
              child: BottomNavigationBar(
                showUnselectedLabels: true,
                iconSize: 40,
                type: BottomNavigationBarType.fixed,
                unselectedItemColor: ThemeColor.black.withOpacity(0.4),
                currentIndex: controller.selectedTab,
                onTap: (index) {
                  controller. goToTab(index);
                },
                selectedItemColor: ThemeColor.primary,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.woman),
                    label: 'الأمهات',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'مزودي الخدمة',
                  ),
                ],
              ),
            ),
            body: controller.screens[controller.selectedTab])

    );
  }
  }

