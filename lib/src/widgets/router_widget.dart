import 'package:flutter/material.dart';
import '../routes/router.dart';

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
  late final dynamic? _parameter;
  void onParam(Object? parameters) {
    _parameter = parameters;
  }

  Widget builder(BuildContext context, dynamic parameter);

  @override
  Widget build(BuildContext context) {
    return builder(context, _parameter);
  }
}
