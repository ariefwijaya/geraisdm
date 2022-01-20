import 'package:flutter/material.dart';

class KeepAliveComponent extends StatefulWidget {
  const KeepAliveComponent({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<KeepAliveComponent> createState() => _KeepAliveComponentState();
}

class _KeepAliveComponentState extends State<KeepAliveComponent>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
