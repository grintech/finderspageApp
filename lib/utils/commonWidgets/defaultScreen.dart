import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projects/utils/colorConstants.dart';

class DefaultScreen extends StatelessWidget {
  const DefaultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Default'),
      ),
      body: const Center(
        child: Text('Coming Soon', style: TextStyle(
          fontWeight: FontWeight.w600, color: fieldBorderColor, fontSize: 18
        ),),
      ),
    );return const Placeholder();
  }
}
