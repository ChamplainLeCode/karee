import 'package:flutter/material.dart';
import '../constances/constances.dart';
import '../../internationalization.dart';
import '../routes/router.dart';
import '../observables/observable_widget.dart';

class RouterWidget extends StatefulWidget {
  final Symbol name;
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

  Widget? child;
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

abstract class RoutableWidget extends StatelessWidget {
  final _RoutableWidgetParameter _parameter = _RoutableWidgetParameter();
  void onParam(Object? parameters) {
    _parameter.value = parameters;
  }

  Widget builder(BuildContext context, Object? parameter);

  @override
  Widget build(BuildContext context) {
    return Observer.on<AppLocalization>(
        tag: KareeConstants.kApplicationLocalizationTag,
        builder: (_, l) => builder(context, _parameter.value));
  }
}

class _RoutableWidgetParameter {
  dynamic? value;

  _RoutableWidgetParameter([this.value]);
}
