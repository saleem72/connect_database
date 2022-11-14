//

import 'package:flutter/material.dart';

class RoutingErrorScreen extends StatelessWidget {
  const RoutingErrorScreen({Key? key, required this.error}) : super(key: key);
  final String error;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Routing error'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 32),
          Text(
            'Routing error',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            error,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
