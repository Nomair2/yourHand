import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yourhand/view/adminView/manageUsersAccounts.dart';
import '../../theme.dart';
import 'service_provider_view.dart';
import 'service_view.dart';

class ServiceAndServiceProvider extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        backgroundColor: ThemeColor.background,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: ThemeColor.primary,
          title: ZoomIn(
            delay: Duration(milliseconds: 300),
            child: Text('الخدمات',
                style: TextStyle(color: ThemeColor.white, fontSize: 23)),
          ),
          toolbarHeight: 80,
          automaticallyImplyLeading: false,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25)),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              TabBar(
                  labelColor: ThemeColor.primary,
                  unselectedLabelColor: ThemeColor.black.withOpacity(0.5),
                  indicatorColor: ThemeColor.primary,
                  labelStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  dividerColor: ThemeColor.black.withOpacity(0.2),
                  tabs: [
                    Tab(
                      child: Text(" مزودي الخدمة"),
                    ),
                    Tab(
                      child: Text("الخدمات"),
                    ),
                    Tab(
                      child: Text("المستخدمون"),
                    ),
                  ]),
              SizedBox(height: 20),
              Expanded(
                child: TabBarView(children: [
                  ServiceProviderView(),
                  ServiceView(),
                  ManageUsersAccounts()
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
