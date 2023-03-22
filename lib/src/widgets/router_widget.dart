import 'package:flutter/material.dart';
import '../constances/constances.dart';
import '../../internationalization.dart';
import '../routes/router.dart';
import '../observables/observable_widget.dart';

///
/// RouterWidget is a widget that allows you to use internal navigation in your
/// application.
///
/// To use this widget you need to specify the name, which is a unique symbol that
/// references your widget router, and the initial widget displayed.
///
/// ```dart
/// RouterWidget(
///   name: #myDashboardRouter,
///   initial: Center(
///     child: Text('Welcome on my dashboard')
///   )
/// )
/// ```
/// See [RoutableWidget]
///
/// See [RouteMode.INTERNAL]
///
class RouterWidget extends StatefulWidget {
  /// The unique symbol that reference the widget router.
  final Symbol name;

  /// The initial widget displayed.
  final Widget initial;

  RouterWidget({required this.name, required this.initial});

  @override
  RouterWidgetState createState() => _RouterWidgetState();
}

abstract class RouterWidgetState extends State<RouterWidget> {
  load(RoutableWidget child);
}

class _RouterWidgetState extends RouterWidgetState {
  @override
  initState() {
    subscribeRouterWidget(widget.name, this);
    super.initState();
  }

  @override
  dispose() {
    unsubscribeRouterWidget(widget.name, this);
    super.dispose();
  }

  /// The widget to be displayed in the router widget.
  /// It should be a routable widget.
  ///
  /// See [RoutableWidget]
  Widget? child;
  @override
  void load(RoutableWidget child) {
    this.child = child;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(),
      child: child ?? widget.initial,
    );
  }
}

///
/// `RoutableWidget`, is an abstract widget that allows you to extend injectable
/// widget in your RouterWidget.
///
/// ```dart
/// class PendingTransactionTab extends RoutableWidget {
///
///   Widget builder(BuildContext context, Object? parameter) => Center(
///     child: Text('Pending transaction')
///   );
/// }
/// ```
///
/// See [RouteMode.INTERNAL]
///
/// See [RouterWidget]
///
abstract class RoutableWidget extends StatelessWidget {
  RoutableWidget({Key? key}) : super(key: key);

  /// The Routable widget parameters object.
  final _RoutableWidgetParameter _parameter = _RoutableWidgetParameter();

  /// **onParam()**: Function to set the Routable widget parameters value.
  void onParam(Object? parameters) {
    _parameter.value = parameters;
  }

  /// **builder()**: Function that provides the widget localization in the tree
  /// (context), and the widget parameter.
  Widget builder(BuildContext context, Object? parameter);

  @override
  Widget build(BuildContext context) {
    return Observer.on<AppLocalization>(
        tag: KareeConstants.kApplicationLocalizationTag,
        builder: (_, l) => builder(context, _parameter.value));
  }
}

///
/// `_RoutableWidgetParameter`: Object representing the Routable widget
/// parameter instance.
///
class _RoutableWidgetParameter {
  dynamic value;

  _RoutableWidgetParameter([this.value]);
}
