import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.inversePrimary,
      child: const Text(
        'Page Not Found',
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }
}
