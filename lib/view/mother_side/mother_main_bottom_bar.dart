// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../theme.dart';
import 'mother_chat_bot/chat_bot_view.dart';
import 'mother_notification/notification&messages.dart';
import 'mother_orders/mother_orders_view.dart';
import 'mother_services/mother_service_view.dart';
import 'mother_profile_view.dart';

class MotherMainBottomBar extends StatefulWidget {
  const MotherMainBottomBar({super.key});

  @override
  State<MotherMainBottomBar> createState() => _MotherMainBottomBarState();
}

class _MotherMainBottomBarState extends State<MotherMainBottomBar> {
  List<Widget> screens = <Widget>[
    MotherProfile(),
    MotherNotificationAndMessage(),
    ChatBotView(),
    MotherServices(),
    MotherOrdersView(),
  ];
  int selectedTab = 0;
  void goToTab(index) {
    setState(() {
      selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ThemeColor.background,
        bottomNavigationBar: SizedBox(
          height: 95,
          child: BottomNavigationBar(
            showUnselectedLabels: true,
            iconSize: 40,
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: ThemeColor.black.withOpacity(0.4),
            currentIndex: selectedTab,
            onTap: (index) {
              goToTab(index);
            },
            selectedItemColor: ThemeColor.primary,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'حسابي',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'الإشعارات',
              ),
              BottomNavigationBarItem(
                icon: Center(
                    child: Image(
                  image: AssetImage("assets/img/womens-voice.png"),
                  width: 40,
                  height: 40,
                )),
                label: 'chat bot',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'الخدمات',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category_outlined),
                label: 'طلباتي',
              ),
            ],
          ),
        ),
        body: screens[selectedTab]);
  }
}
