import '../../utils/Style.dart';
import 'package:flutter/material.dart';
import 'package:karee/widgets.dart';
import 'package:karee/internationalization.dart';

/// Generated Karee Screen
/// @github ChamplainLeCode
///
/// `DashboardControllersScreen` is set as Screen with name `dashboard_controller`
class DashboardControllersScreen extends RoutableWidget {
  @override
  Widget builder(BuildContext context, _) {
    return Scaffold(
      body: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text('karee.module.controller.title'.translate(),
                    style: Style.moduleTitleStyle)),
            Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  'karee.module.controller.details'.translate(),
                  textAlign: TextAlign.justify,
                  style: Style.moduleDetailStyle,
                )),
            Row(children: [
              Icon(Icons.miscellaneous_services,
                  color: Style.dashboardSelectedMenu),
              Text('  ' + 'karee.module.controller.service.title'.translate(),
                  style: TextStyle(
                      color: Style.dashboardSelectedMenu,
                      fontWeight: FontWeight.w400,
                      fontSize: 18))
            ]),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "karee.module.controller.service.detail".translate(),
                  textAlign: TextAlign.justify,
                  style: Style.moduleItemDetail,
                  textScaleFactor: 1.1,
                )),
            Row(children: [
              Icon(Icons.settings_ethernet_rounded,
                  color: Style.dashboardSelectedMenu),
              Text('  ' + 'karee.module.controller.variable.title'.translate(),
                  style: TextStyle(
                      color: Style.dashboardSelectedMenu,
                      fontWeight: FontWeight.w400,
                      fontSize: 18))
            ]),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "karee.module.controller.variable.detail".translate(),
                  textAlign: TextAlign.justify,
                  style: Style.moduleItemDetail,
                  textScaleFactor: 1.1,
                )),
          ])),
    );
  }
}
