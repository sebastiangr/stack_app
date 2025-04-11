import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importa provider
import 'package:stack_app/screens/main_screen.dart';
import 'screens/feed_screen.dart';
import 'providers/theme_provider.dart'; // Importa tu ThemeProvider

void main() {
  runApp(
    // 1. Envuelve tu App con ChangeNotifierProvider
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(), // Crea una instancia del ThemeProvider
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 2. Escucha los cambios del ThemeProvider
    final themeProvider = Provider.of<ThemeProvider>(context);

    // Define los colores base para evitar repetirlos
    const Color lightScaffoldColor = Color(0xFFF5F5F5); // Un gris muy claro
    const Color darkScaffoldColor = Color(0xFF121212); // Negro/Gris oscuro

    return MaterialApp(
      title: 'Feed Mockup',
      debugShowCheckedModeBanner: false,
      // 3. Configura los temas y el themeMode
      theme: ThemeData( // TEMA CLARO
        brightness: Brightness.light,
        primarySwatch: Colors.orange,
        // 1. Asigna el color de fondo del Scaffold
        scaffoldBackgroundColor: lightScaffoldColor,
        appBarTheme: AppBarTheme(
          // 2. Asigna el MISMO color al AppBar
          backgroundColor: lightScaffoldColor,
          // 3. Pon la elevación a 0 para quitar la sombra
          elevation: 0,
          scrolledUnderElevation: 0, // También importante para SliverAppBars
          iconTheme: IconThemeData(color: Colors.grey[800]), // Iconos oscuros sobre fondo claro
          titleTextStyle: TextStyle(
            color: Colors.grey[900], // Título oscuro sobre fondo claro
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.orange, // Icono seleccionado naranja
          unselectedItemColor: Colors.grey[500], // Icono no seleccionado gris
        ),
          // Define otros colores y estilos para el modo claro si es necesario
          colorScheme: ColorScheme.light(
            primary: Colors.orange,
            secondary: Colors.orangeAccent,
            // background: lightScaffoldColor,
            surface: lightScaffoldColor, // Color de fondo para Cards, Dialogs etc
            onPrimary: Colors.white,
            onSecondary: Colors.black,
            onBackground: Colors.black,
            onSurface: Colors.black, // Color del texto sobre 'surface'
          ),
          // Estilo para TextButton en modo claro
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Colors.orange,
            )
          ),
          cardTheme: CardTheme(
            color: Colors.white, // Las cards pueden tener un fondo distinto
            elevation: 0.5, // Sombra muy sutil para las cards,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16)
          ),
          dividerColor: Colors.grey[300], // Color del divisor
      ),
      darkTheme: ThemeData( // TEMA OSCURO
        brightness: Brightness.dark,
        primarySwatch: Colors.orange,
        // 1. Asigna el color de fondo del Scaffold
        scaffoldBackgroundColor: darkScaffoldColor,
        appBarTheme: const AppBarTheme(
           // 2. Asigna el MISMO color al AppBar
          backgroundColor: darkScaffoldColor,
          // 3. Pon la elevación a 0
          elevation: 0,
          scrolledUnderElevation: 0,
          iconTheme: IconThemeData(color: Colors.white70), // Iconos claros sobre fondo oscuro
          titleTextStyle: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF1F1F1F), // Puedes mantenerla un poco diferente o usar darkScaffoldColor
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.white54,
          elevation: 4, // Puedes añadirle sombra si quieres que destaque un poco
        ),
        // Define otros colores y estilos para el modo oscuro
        colorScheme: ColorScheme.dark(
          primary: Colors.orange,
          secondary: Colors.orangeAccent,
          background: darkScaffoldColor, // <-- Usa la variable
          surface: Color(0xFF1F1F1F), // Fondo para Cards, etc. (puede ser diferente)
          onPrimary: Colors.black,
          onSecondary: Colors.black,
          onBackground: Colors.white, // Texto sobre el fondo principal
          onSurface: Colors.white,
        ),
         // Estilo para TextButton en modo oscuro
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.orangeAccent,
          )
        ),
          cardTheme: CardTheme(
            color: const Color(0xFF1F1F1F), // Color de las Card en oscuro
            elevation: 0,
             shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
            ),
             margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16)
         ),
         dividerColor: Colors.grey[850], // Color del divisor
      ),
      themeMode: themeProvider.themeMode, // <- Usa el modo del provider
      home: const MainScreen(),
    );
  }
}