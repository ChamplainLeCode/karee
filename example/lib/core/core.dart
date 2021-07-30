// import 'package:karee_sample/core/extensions.dart';
import 'package:flutter/widgets.dart';
import 'app.module.dart';
import '../app/routes/routes.dart';
import 'core.reflectable.dart';
import 'package:karee/core.dart';
import 'extensions/extensions_controllers.dart';

///
/// by Champlain Marius Bakop
///
/// email champlainmarius20@gmail.com
///
/// github ChamplainLeCode
///
///

void initControllerReflectable() {
  ///
  /// Here we subscribe controllers
  ///

  controllers.forEach(subscribeController);
  screens.forEach(subscribeScreen);
}

Future<void> initCore() async {
  print('Initialisation started');
  WidgetsFlutterBinding.ensureInitialized();
  await loadAppConfig();
  initializeReflectable();
  registeredRoute();
  initControllerReflectable();
  print('Initialisation ended');
}

void main() async {}
