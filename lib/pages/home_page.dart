import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text(
        'Home Page',
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }
}
