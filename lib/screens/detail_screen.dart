import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String name;
  final String storage;
  final DateTime expiry;

  const DetailScreen({
    super.key,
    required this.name,
    required this.storage,
    required this.expiry,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Item Details')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.kitchen, size: 100, color: Color(0xFF608E61)),
            const SizedBox(height: 18),
            Text(name, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            Text('Stored in: $storage'),
            Text('Expires: ${expiry.day}/${expiry.month}/${expiry.year}'),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
