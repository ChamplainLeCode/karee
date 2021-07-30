import '../../utils/Style.dart';
import 'package:flutter/material.dart';
import 'package:karee/internationalization.dart';
import 'package:karee/widgets.dart';

class DashboardScreenTabScreen extends RoutableWidget {
  @override
  Widget builder(BuildContext context, parameter) {
    return Scaffold(
      body: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text('karee.module.screen.title'.translate(),
                    style: Style.moduleTitleStyle)),
            Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  'karee.module.screen.details'.translate(),
                  textAlign: TextAlign.justify,
                  style: Style.moduleDetailStyle,
                )),
            Row(children: [
              Icon(Icons.lens_outlined, color: Style.dashboardSelectedMenu),
              Text('  ' + 'karee.module.screen.stls.title'.translate(),
                  style: TextStyle(
                      color: Style.dashboardSelectedMenu,
                      fontWeight: FontWeight.w400,
                      fontSize: 18))
            ]),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'karee.module.screen.stls.detail'.translate(),
                  textAlign: TextAlign.justify,
                  style: Style.moduleItemDetail,
                  textScaleFactor: 1.1,
                )),
            Text('eg'.translate()),
            Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Style.dashboardSelectedMenuBorder, width: 2)),
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: Image(
                    image: AssetImage('assets/images/screen-stl-eg.png'))),
            Row(children: [
              Icon(Icons.lens, color: Style.dashboardSelectedMenu),
              Text('  ' + 'karee.module.screen.stfs.title'.translate(),
                  style: TextStyle(
                      color: Style.dashboardSelectedMenu,
                      fontWeight: FontWeight.w400,
                      fontSize: 18))
            ]),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(children: [
                  Text(
                    "    " + 'karee.module.screen.stfs.detail'.translate(),
                    textAlign: TextAlign.justify,
                    style: Style.moduleItemDetail,
                    textScaleFactor: 1.1,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Style.dashboardSelectedMenuBorder,
                              width: 2)),
                      margin:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      child: Image(
                          image:
                              AssetImage('assets/images/screen-stf-eg.png'))),
                ])),
          ])),
    );
  }
}
