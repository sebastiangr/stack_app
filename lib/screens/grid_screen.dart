import 'package:flutter/material.dart';

class GridScreen extends StatelessWidget {
  const GridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Implementar vista Grid de Cards
    return Scaffold(
      appBar: AppBar(title: const Text('Grid View')), // AppBar opcional
      body: const Center(
        child: Text('Grid Screen Placeholder'),
      ),
    );
  }
}