import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Implementar lista de Notificaciones
    return Scaffold(
      appBar: AppBar(title: const Text('Notificaciones')), // AppBar opcional
      body: const Center(
        child: Text('Notifications Screen Placeholder'),
      ),
    );
  }
}