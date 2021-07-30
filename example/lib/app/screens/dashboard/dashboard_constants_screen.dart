import '../../utils/Style.dart';
import 'package:flutter/material.dart';
import 'package:karee/widgets.dart';
import 'package:karee/internationalization.dart';

/// Generated Karee Screen
/// @email champlainmarius20@gmail.com
/// @github ChamplainLeCode
///
///
///
/// `DashboardConstantsScreen` is set as Screen
///
class DashboardConstantsScreen extends RoutableWidget {
  @override
  Widget builder(BuildContext context, parameter) {
    return Scaffold(
      body: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text('karee.module.constant.title'.translate(),
                    style: Style.moduleTitleStyle)),
            Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  'karee.module.constant.details'.translate(),
                  style: Style.moduleDetailStyle,
                )),
            Row(children: [
              Icon(Icons.verified_user, color: Style.dashboardSelectedMenu),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: '  KareeInstanceProfile',
                    style: TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.w400,
                        fontSize: 18),
                    children: [
                      TextSpan(
                        text: '.',
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextSpan(
                          text: 'production',
                          style: TextStyle(color: Colors.blueGrey))
                    ])
              ]))
            ]),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'karee.module.constant.profile.prod.detail'.translate(),
                  textAlign: TextAlign.justify,
                  style: Style.moduleItemDetail,
                  textScaleFactor: 1.1,
                )),
            Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Style.dashboardSelectedMenu, width: 2)),
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child:
                    Image(image: AssetImage('assets/images/error-prod.png'))),
            Row(children: [
              Icon(Icons.developer_mode, color: Style.dashboardSelectedMenu),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: '  KareeInstanceProfile',
                    style: TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.w400,
                        fontSize: 18),
                    children: [
                      TextSpan(
                        text: '.',
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextSpan(
                          text: 'development',
                          style: TextStyle(color: Colors.blueGrey))
                    ])
              ]))
            ]),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'karee.module.constant.profile.dev.detail'.translate(),
                  textAlign: TextAlign.justify,
                  style: Style.moduleItemDetail,
                  textScaleFactor: 1.1,
                )),
            Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Style.dashboardSelectedMenu, width: 2)),
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: Image(image: AssetImage('assets/images/error-dev.png'))),
            Row(children: [
              Icon(Icons.add_to_home_screen_outlined,
                  color: Style.dashboardSelectedMenu),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: '  KareeConstants',
                    style: TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.w400,
                        fontSize: 18),
                    children: [
                      TextSpan(
                        text: '.',
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextSpan(
                          text: 'kareeErrorScreenName',
                          style: TextStyle(color: Colors.blueGrey))
                    ])
              ]))
            ]),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'karee.module.constant.errorScreenName.detail'.translate(),
                  textAlign: TextAlign.justify,
                  style: Style.moduleItemDetail,
                  textScaleFactor: 1.1,
                ))
          ])),
    );
  }
}
