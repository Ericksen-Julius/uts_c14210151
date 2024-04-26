import 'package:flutter/material.dart';

class BlankPage extends StatelessWidget {
  const BlankPage({super.key, required this.myColor});

  final Color myColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColor,
    );
  }
}
