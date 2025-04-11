import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Implementar lista de Mensajes
    return Scaffold(
       appBar: AppBar(title: const Text('Mensajes')), // AppBar opcional
      body: const Center(
        child: Text('Messages Screen Placeholder'),
      ),
    );
  }
}