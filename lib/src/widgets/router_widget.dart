import 'package:flutter/material.dart';
import './../routes/Router.dart';

class RouterWidget extends StatefulWidget {
  final Symbol name;

  RouterWidget({required this.name});

  @override
  RouterWidgetState createState() => _RouterWidgetState();
}

abstract class RouterWidgetState extends State<RouterWidget> {
  load(Widget child);
}

class _RouterWidgetState extends RouterWidgetState {
  @override
  initState() {
    subscribeRouterWidget(widget.name, this);
    super.initState();
  }

  Widget? child;
  void load(Widget child) {
    this.child = child;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: child ?? Container(),
    );
  }
}
