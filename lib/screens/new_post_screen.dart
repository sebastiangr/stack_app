import 'package:flutter/material.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Implementar formulario de creación de Post
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Nuevo Post'),
        leading: IconButton( // Botón para cerrar la pantalla modal
          icon: const Icon(Icons.close), // O usa LucideIcons.x
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: const Center(
        child: Text('New Post Screen Placeholder'),
      ),
    );
  }
}