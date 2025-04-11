import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:stack_app/widgets/custom_drawer.dart';
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
  // 1. Mueve la GlobalKey aquí
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
      // 2. Asigna la key al Scaffold principal
      key: _scaffoldKey,

      // 3. Define el AppBar aquí para que sea persistente
      appBar: AppBar(
        // El estilo (color, elevación) viene del tema global
        // El leading ahora usa la _scaffoldKey de esta pantalla
        leading: IconButton(
          icon: const Icon(LucideIcons.menu),
          tooltip: 'Abrir menú',
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        // Opcional: Título dinámico basado en la pantalla actual
        // title: Text(_screenTitles[_selectedIndex]),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.search),
            onPressed: () {
              print("Search tapped");
              // Navegar a pantalla de búsqueda o mostrar overlay
            },
            tooltip: 'Buscar',
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                 // El avatar también abre el drawer
                 _scaffoldKey.currentState?.openDrawer();
                 print("User Avatar tapped");
              },
              child: const CircleAvatar(
                radius: 16.0,
                backgroundImage: NetworkImage('https://picsum.photos/seed/user/100/100'),
                backgroundColor: Colors.grey,
              ),
            ),
          ),
        ],
      ),

      // 4. Define el Drawer aquí
      drawer: const CustomDrawer(),

      // El body cambia según el índice seleccionado
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),

      // La barra de navegación permanece aquí
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemSelected: _onItemTapped,
      ),
    );
  }
}