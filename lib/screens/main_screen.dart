import 'package:flutter/material.dart';
import 'feed_screen.dart'; // Tu pantalla Home original
import 'grid_screen.dart';
import 'new_post_screen.dart';
import 'messages_screen.dart';
import 'notifications_screen.dart';
import '../widgets/bottom_navigation.dart'; // Importa tu barra personalizada

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Índice de la pantalla VISIBLE en el IndexedStack (0 a 3)
  int _selectedIndex = 0;

  // Lista de las pantallas principales que se mostrarán en el body
  // ¡OJO! No incluye la pantalla de "Crear Post"
  final List<Widget> _screens = const [
    FeedScreen(),      // Índice lógico 0
    GridScreen(),      // Índice lógico 1
    MessagesScreen(),  // Índice lógico 2
    NotificationsScreen(), // Índice lógico 3
  ];

  // Función que se pasa a CustomBottomNavigationBar
  void _onItemTapped(int visualIndex) {
    // El índice visual viene de la barra (0, 1, 2, 3, 4)

    if (visualIndex == 2) {
      // Acción especial para el botón "+" (índice visual 2)
      // Navega a la pantalla de creación de forma modal
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NewPostScreen()),
      );
    } else {
      // Calcula el índice lógico para el IndexedStack
      // 0 -> 0
      // 1 -> 1
      // 3 -> 2
      // 4 -> 3
      int logicalIndex = visualIndex;
      if (visualIndex > 2) {
        logicalIndex = visualIndex - 1;
      }

      // Actualiza el estado solo si el índice lógico es diferente
      if (_selectedIndex != logicalIndex) {
        setState(() {
          _selectedIndex = logicalIndex;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // El AppBar se definirá dentro de cada pantalla (_screens[selectedIndex])
      // si es necesario, o puedes tener uno aquí si es común a todas.
      // appBar: AppBar(title: Text("App Title")), // AppBar común opcional

      // IndexedStack mantiene el estado de las pantallas
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),

      // Tu barra de navegación personalizada
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex, // Pasa el índice lógico
        onItemSelected: _onItemTapped, // Pasa la función de callback
      ),
    );
  }
}