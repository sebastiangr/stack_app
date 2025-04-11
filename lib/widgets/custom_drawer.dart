import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart'; // Usa Lucide Icons
import 'package:stack_app/screens/settings_screen.dart';
import '../providers/theme_provider.dart'; // Importa el ThemeProvider

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtén el ThemeProvider para el switch y los colores
    final themeProvider = Provider.of<ThemeProvider>(context);
    // Define colores basados en el tema actual para consistencia
    final Color textColor = Theme.of(context).textTheme.bodyLarge?.color ?? (themeProvider.isDarkMode ? Colors.white70 : Colors.black87);
    final Color iconColor = Theme.of(context).iconTheme.color ?? (themeProvider.isDarkMode ? Colors.white70 : Colors.grey[700]!);


    return Drawer(
      // Usa el color de fondo del scaffold para el Drawer
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
        ),
      ),
      child: ListView(
        padding: EdgeInsets.zero, // Importante: remueve el padding por defecto
        children: <Widget>[
          // Cabecera del Drawer con información del usuario
          _buildDrawerHeader(context, textColor),

          // Elementos del Listado (Categorías)
          _buildDrawerItem(
            icon: LucideIcons.layoutDashboard,
            text: 'Dashboard',
            onTap: () => _navigateTo(context, 'Dashboard'),
            iconColor: iconColor,
            textColor: textColor
          ),
          _buildDrawerItem(
            icon: LucideIcons.bookmark,
            text: 'Guardados',
            onTap: () => _navigateTo(context, 'Guardados'),
            iconColor: iconColor,
            textColor: textColor
          ),
          _buildDrawerItem(
            icon: LucideIcons.history,
            text: 'Historial',
            onTap: () => _navigateTo(context, 'Historial'),
            iconColor: iconColor,
            textColor: textColor
          ),
           _buildDrawerItem(
            icon: LucideIcons.settings,
            text: 'Configuración',
            onTap: () {
              Navigator.pop(context); // Cierra el drawer primero
              // Navega a la pantalla de configuración
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
            // onTap: () => _navigateTo(context, 'Configuración'),
            iconColor: iconColor,
            textColor: textColor
          ),

          Divider(
            color: Theme.of(context).dividerColor, // Color del separador
          ), // Separador visual

          // Switch para el Tema Oscuro/Claro
          SwitchListTile(
            title: Text(
              'Modo Oscuro',
              style: TextStyle(color: textColor),
            ),
            value: themeProvider.isDarkMode,
            onChanged: (bool value) {
              // Llama al método toggleTheme del provider
              // Usa listen: false aquí porque estamos llamando a un método, no escuchando cambios
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme(value);
            },
            secondary: Icon(
              themeProvider.isDarkMode ? LucideIcons.moon : LucideIcons.sun,
              color: iconColor,
            ),
             activeColor: Theme.of(context).colorScheme.primary, // Color del switch activo
          ),

          // Puedes añadir más items aquí si necesitas (e.g., Logout)
           _buildDrawerItem(
            icon: LucideIcons.logOut,
            text: 'Cerrar Sesión',
            onTap: () => _navigateTo(context, 'Logout'),
            iconColor: iconColor,
            textColor: textColor
          ),
        ],
      ),
    );
  }

  // Widget helper para construir la cabecera del Drawer
  Widget _buildDrawerHeader(BuildContext context, Color textColor) {
    // Puedes reemplazar estos con datos reales del usuario
    const String userName = "Nombre Usuario";
    const String userProfileImageUrl = 'https://picsum.photos/seed/userDrawer/100/100';

    return DrawerHeader(

      decoration: BoxDecoration(
        // Puedes poner un color de fondo o dejarlo transparente para que use el del Drawer
        color: Colors.transparent,
        // Opcional: añadir una imagen de fondo
        // image: DecorationImage(
        //   image: NetworkImage('url_imagen_fondo'),
        //   fit: BoxFit.cover,
        // ),
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor, // Color del separador
            width: 1.0, // Grosor del separador
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end, // Alinea al final
        children: <Widget>[
          // const CircleAvatar(
          //   radius: 30.0,
          //   backgroundImage: NetworkImage(userProfileImageUrl),
          //   backgroundColor: Colors.grey, // Placeholder mientras carga
          // ),
          const SizedBox(height: 10.0),
          Text(
            userName,
            style: TextStyle(
              color: textColor,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5.0),
          // Botón para ver el perfil
          TextButton(
             style: TextButton.styleFrom(
                // padding: EdgeInsets.zero,
                minimumSize: const Size(50, 30), // Tamaño mínimo para que sea fácil tocar
                alignment: Alignment.centerLeft // Alinear texto a la izquierda
             ),
             child: Text(
                'Ver perfil',
                 style: TextStyle(
                    color: Theme.of(context).colorScheme.primary, // Usa el color primario
                    fontSize: 14
                 ),
             ),
             onPressed: () {
                Navigator.pop(context); // Cierra el drawer
                // Aquí navegas a la pantalla de perfil
                print('Ir a la pantalla de perfil');
                // Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
             },
          ),
          const SizedBox(height: 5.0),
        ],
      ),
    );
  }

  // Widget helper para construir cada item del listado del Drawer
  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required GestureTapCallback onTap,
    required Color iconColor,
    required Color textColor
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(text, style: TextStyle(color: textColor)),
      onTap: onTap,
      dense: true, // Hace los items un poco más compactos
    );
  }

  // Función helper para manejar la navegación (cierra el drawer primero)
  void _navigateTo(BuildContext context, String routeName) {
    Navigator.pop(context); // Cierra el Drawer antes de navegar
    // Aquí implementarías la navegación real basada en routeName
    print('Navegando a: $routeName');
    // Ejemplo:
    // if (routeName == 'Settings') {
    //   Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
    // }
  }
}