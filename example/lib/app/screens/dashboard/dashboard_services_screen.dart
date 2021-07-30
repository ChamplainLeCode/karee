import '../../utils/Style.dart';
import 'package:flutter/material.dart';
import 'package:karee/widgets.dart';
import 'package:karee/internationalization.dart';

/// Generated Karee Screen
///
/// `DashboardServicesScreen` is set as Screen with name `dashboard_service`
class DashboardServicesScreen extends RoutableWidget {
  @override
  Widget builder(BuildContext context, _) {
    return Scaffold(
      body: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text('karee.module.service.title'.translate(),
                    style: Style.moduleTitleStyle)),
            Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  'karee.module.service.details'.translate(),
                  textAlign: TextAlign.justify,
                  style: Style.moduleDetailStyle,
                )),
            Text('eg'.translate()),
            Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Style.dashboardSelectedMenu, width: 2)),
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child:
                    Image(image: AssetImage('assets/images/service-def.png'))),
          ])),
    );
  }
}
