import 'package:flutter/material.dart';

class WebConstrainedBox extends StatelessWidget {
  final Widget child;
  const WebConstrainedBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: child,
      ),
    );
  }
}
