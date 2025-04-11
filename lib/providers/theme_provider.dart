import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart'; // Para obtener el brillo del sistema

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system; // Inicia con el tema del sistema

  ThemeMode get themeMode => _themeMode;

  // Obtiene si el modo oscuro está activo actualmente (considerando el sistema)
  bool get isDarkMode {
    if (_themeMode == ThemeMode.system) {
      // Obtiene el brillo actual de la plataforma (teléfono)
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return _themeMode == ThemeMode.dark;
    }
  }

  // Método para cambiar el tema
  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners(); // Notifica a los widgets que escuchan para que se reconstruyan
  }
}