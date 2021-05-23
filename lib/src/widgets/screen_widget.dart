import 'package:flutter/material.dart';

import '../routes/Router.dart' show KareeRouter;

@immutable
abstract class StatelessScreen extends StatelessWidget {
  dynamic get arguments => ModalRoute.of(KareeRouter.currentContext!)?.settings.arguments;

  @protected
  Size get screenSize => MediaQuery.of(KareeRouter.currentContext!).size;

  MediaQueryData get mediaQuery => MediaQuery.of(context);

  BuildContext get context => KareeRouter.currentContext!;

  @protected
  Widget builder(BuildContext context);

  @override
  Widget build(BuildContext context) {
    KareeRouter.currentContext = context;
    return builder(context);
  }
}

@immutable
abstract class StatelessComponent extends StatelessWidget {
  dynamic get arguments => ModalRoute.of(KareeRouter.currentContext!)?.settings.arguments;

  @protected
  Size get screenSize => MediaQuery.of(KareeRouter.currentContext!).size;

  MediaQueryData get mediaQuery => MediaQuery.of(context);

  BuildContext get context => KareeRouter.currentContext!;

  @protected
  Widget builder(BuildContext context);

  @override
  Widget build(BuildContext context) {
    KareeRouter.currentContext = context;
    return builder(context);
  }
}

@immutable
abstract class StatefulComponent extends StatefulWidget {
  final Key? key;

  @mustCallSuper
  StatefulComponent({this.key}) : super(key: key);

  @override
  ComponentState<StatefulComponent> createState();
}

abstract class ComponentState<T extends StatefulComponent> extends State<T> {
  dynamic? arguments;

  // BuildContext context;

  @protected
  Size get screenSize => MediaQuery.of(context).size;

  @protected
  Widget builder(BuildContext context);

  @override
  Widget build(BuildContext context) {
    KareeRouter.currentContext = context;
    arguments = ModalRoute.of(context)?.settings.arguments;
    return builder(context);
  }

  void update() => setState(() {});
}

@immutable
abstract class StatefulScreen extends StatefulWidget {
  final Key? key;

  @mustCallSuper
  StatefulScreen({this.key}) : super(key: key);

  @override
  ScreenState<StatefulScreen> createState();
}

abstract class ScreenState<T extends StatefulScreen> extends State<T> {
  dynamic? arguments;

  // BuildContext context;

  @protected
  Size get screenSize => MediaQuery.of(context).size;

  @protected
  Widget builder(BuildContext context);

  @override
  Widget build(BuildContext context) {
    KareeRouter.currentContext = context;
    arguments = ModalRoute.of(context)?.settings.arguments;
    return builder(context);
  }
}