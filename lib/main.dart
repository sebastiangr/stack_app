import 'package:flutter/material.dart';
import 'screens/feed_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feed Mockup',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark, // Use dark theme globally
        primarySwatch: Colors.orange, // Base color for some components
        scaffoldBackgroundColor: const Color(0xFF121212), // Main background
        appBarTheme: const AppBarTheme(
           backgroundColor: Color(0xFF1F1F1F), // Specific AppBar color
           elevation: 0,
           iconTheme: IconThemeData(color: Colors.white70), // Default icon color in AppBar
           titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
         bottomNavigationBarTheme: BottomNavigationBarThemeData(
           backgroundColor: const Color(0xFF1F1F1F),
           selectedItemColor: Colors.white,
           unselectedItemColor: Colors.white54,
         ),
         // Define text button style globally if needed
         textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
               foregroundColor: Colors.orangeAccent, // Default text color for TextButtons
            )
         ),
         // Define card theme if needed
         cardTheme: CardTheme(
            color: Colors.grey[850], // Default card background if not specified
            elevation: 0, // No shadow for cards by default
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
            ),
            margin: EdgeInsets.zero, // Control margin within PostItem/HorizontalCardItem
         )
      ),
      home: const FeedScreen(),
    );
  }
}