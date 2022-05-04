import 'package:flutter/material.dart';
import '../constances/library.dart' show KareeConstants;
import '../observables/library.dart' show Observer;
import '../utils/app_localization.dart';
import '../routes/router.dart' show KareeRouter;

///
/// StatelessWidget that is used to add some view in Navigation context.
///
/// This widget also allow you to access to context outside the build function.
///
@immutable
abstract class StatelessScreen extends StatelessWidget {
  dynamic get arguments =>
      ModalRoute.of(KareeRouter.currentContext!)?.settings.arguments;

  @protected
  Size get screenSize => MediaQuery.of(context).size;

  MediaQueryData get mediaQuery => MediaQuery.of(context);

  BuildContext get context => KareeRouter.currentContext!;

  @mustCallSuper
  StatelessScreen({Key? key}) : super(key: key);

  @protected
  Widget builder(BuildContext context);

  @override
  Widget build(BuildContext context) {
    KareeRouter.currentContext = context;
    return Observer.on<AppLocalization>(
        tag: KareeConstants.kApplicationLocalizationTag,
        builder: (_, l) => builder(context));
  }
}

///
/// StatelessComponent that is used to substitue StatelessWidget to access
/// context outside the build function, expose also [screenSize], [mediaQuery]
/// and [arguments]
///
@immutable
abstract class StatelessComponent extends StatelessWidget {
  @mustCallSuper
  StatelessComponent({Key? key}) : super(key: key);

  ///
  /// Navigation parameter
  ///
  dynamic get arguments =>
      ModalRoute.of(KareeRouter.currentContext!)?.settings.arguments;

  // BuildContext? _context;

  @protected
  Size get screenSize => MediaQuery.of(KareeRouter.currentContext!).size;

  MediaQueryData get mediaQuery => MediaQuery.of(context);

  BuildContext get context => KareeRouter.currentContext!;

  @protected
  Widget builder(BuildContext context);

  @override
  Widget build(BuildContext context) {
    // _context = context;
    return builder(context);
  }
}

///
/// StatefulComponent that is used to substitue StatefulWidget to access
/// [ComponentState.screenSize], [ComponentState.mediaQuery] and
/// [ComponentState.arguments]
///
@immutable
abstract class StatefulComponent extends StatefulWidget {
  @mustCallSuper
  StatefulComponent({Key? key}) : super(key: key);

  @override
  ComponentState<StatefulComponent> createState();
}

abstract class ComponentState<T extends StatefulComponent> extends State<T> {
  ///
  /// Navigation parameter
  ///
  dynamic get arguments => ModalRoute.of(context)?.settings.arguments;

  MediaQueryData get mediaQuery => MediaQuery.of(context);

  @protected
  Size get screenSize => MediaQuery.of(context).size;

  @protected
  Widget builder(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return builder(context);
  }

  void update() => setState(() {});
}

///
/// StatefulWidget that is used to add some view in Navigation context.
///
@immutable
abstract class StatefulScreen extends StatefulWidget {
  @mustCallSuper
  StatefulScreen({Key? key}) : super(key: key);

  @override
  ScreenState<StatefulScreen> createState();
}

abstract class ScreenState<T extends StatefulScreen> extends State<T> {
  ///
  /// Navigation parameter
  ///
  dynamic get arguments => ModalRoute.of(context)?.settings.arguments;

  MediaQueryData get mediaQuery => MediaQuery.of(context);

  @protected
  Size get screenSize => MediaQuery.of(context).size;

  @protected
  Widget builder(BuildContext context);

  @override
  Widget build(BuildContext context) {
    KareeRouter.currentContext = context;
    return Observer.on<AppLocalization>(
        tag: KareeConstants.kApplicationLocalizationTag,
        builder: (_, l) => builder(context));
  }
}
