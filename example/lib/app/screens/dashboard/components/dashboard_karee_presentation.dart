import '../../../utils/Style.dart';
import 'package:flutter/cupertino.dart';
import 'package:karee/widgets.dart';
import 'package:karee/internationalization.dart';

class DashboardKareePresentation extends StatelessComponent {
  @override
  Widget builder(BuildContext context) {
    return Container(
        child: Column(children: [
      Padding(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: Text(
              'welcome.message'.translateWithParams({'username': 'Karee'}),
              style: Style.moduleTitleStyle)),
      // Spacer(),
      Align(
          alignment: Alignment.center,
          child: Text('welcome.message1'.translate(),
              textAlign: TextAlign.center, style: Style.moduleTitleStyle)),
      Align(
          alignment: Alignment.center,
          child: Text('welcome.message2'.translate(),
              style: Style.moduleTitleStyle, textAlign: TextAlign.center)),
      Spacer()
    ]));
  }
}
