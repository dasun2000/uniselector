import 'package:flutter/material.dart';

class DegreesScreen extends StatelessWidget {
  const DegreesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Degrees Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}