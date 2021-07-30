import 'package:karee/widgets.dart';
import 'package:karee/annotations.dart';
import 'package:karee/navigation.dart';
import 'package:karee/core.dart';
import '../utils/Style.dart';
import 'package:flutter/material.dart' hide Page;
import 'package:url_launcher/url_launcher.dart' as launcher;
/*
 * @Author Champlain Marius Bakop
 * @email champlainmarius20@gmail.com
 * @github ChamplainLeCode
 * 
 */

@Screen('home', isInitial: true)
class HomeScreen extends StatefulScreen {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ScreenState<HomeScreen> {
  @override
  Widget builder(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            body: Container(
                alignment: Alignment.center,
                color: Style
                    .dashboardSelectedMenu, // Style.primaryColor.withOpacity(0.125),
                padding: EdgeInsets.only(left: 10, right: 10),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                          image:
                              AssetImage('assets/karee.png', package: 'karee')),
                      Text(
                        'Another way to build Beautiful Application using Flutter with MVC',
                        style: TextStyle(
                            fontSize: 30,
                            color: Style.whiteText,
                            fontWeight: FontWeight.w200),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Verision v2.1.0',
                        style: TextStyle(fontSize: 20, color: Style.whiteText),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          if (await launcher
                              .canLaunch(KareeConstants.kareeGithub)) {
                            await launcher.launch(KareeConstants.kareeGithub);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.primaries.first),
                        child: Text('Get\'s started'),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: () async {
                          KareeRouter.goto('/dashboard');
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Style.warningColor, elevation: 10),
                        icon: Icon(
                          Icons.dashboard_customize,
                          size: 15,
                        ),
                        label: Text('Dashboard'),
                      ),
                    ],
                  ),
                ))));
  }
}
