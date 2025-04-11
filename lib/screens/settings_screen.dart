import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart'; // Necesario para el switch de tema si lo pones aquí
import '../providers/theme_provider.dart'; // Importa el ThemeProvider

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtener el tema para colores consistentes
    final theme = Theme.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context); // Para el switch

    return Scaffold(
      // AppBar específica para esta pantalla
      appBar: AppBar(
        title: const Text('Configuración'),
        // El botón de regreso se añade automáticamente por MaterialPageRoute
        // pero puedes personalizarlo si quieres:
        // leading: BackButton(color: theme.appBarTheme.iconTheme?.color),
      ),
      body: ListView(
        children: <Widget>[
          // --- Sección Cuenta ---
          _buildSectionHeader(context, 'Cuenta'),
          ListTile(
            leading: Icon(LucideIcons.user, color: theme.iconTheme.color),
            title: Text('Editar Perfil', style: theme.textTheme.bodyLarge),
            trailing: Icon(LucideIcons.chevronRight, color: theme.iconTheme.color?.withOpacity(0.5)),
            onTap: () {
              // TODO: Navegar a la pantalla de edición de perfil
              print('Navegar a Editar Perfil');
              // Navigator.push(context, MaterialPageRoute(builder: (_) => EditProfileScreen()));
            },
          ),
          ListTile(
            leading: Icon(LucideIcons.keyRound, color: theme.iconTheme.color),
            title: Text('Seguridad y Contraseña', style: theme.textTheme.bodyLarge),
             trailing: Icon(LucideIcons.chevronRight, color: theme.iconTheme.color?.withOpacity(0.5)),
            onTap: () {
              // TODO: Navegar a la pantalla de seguridad
              print('Navegar a Seguridad');
            },
          ),

          Divider(
            color: Theme.of(context).dividerColor, // Color del separador
          ),

          // --- Sección Notificaciones ---
          _buildSectionHeader(context, 'Notificaciones'),
           ListTile(
            leading: Icon(LucideIcons.bellRing, color: theme.iconTheme.color),
            title: Text('Preferencias de Notificación', style: theme.textTheme.bodyLarge),
             trailing: Icon(LucideIcons.chevronRight, color: theme.iconTheme.color?.withOpacity(0.5)),
            onTap: () {
              // TODO: Navegar a la pantalla de preferencias de notificación
              print('Navegar a Preferencias de Notificación');
            },
          ),
          // Ejemplo de un switch directamente aquí
          SwitchListTile(
             secondary: Icon(LucideIcons.mail, color: theme.iconTheme.color),
             title: Text('Notificaciones por Email', style: theme.textTheme.bodyLarge),
             subtitle: Text('Recibir resúmenes y noticias importantes', style: theme.textTheme.bodySmall),
             value: true, // TODO: Usar un valor real del estado de la configuración
             onChanged: (bool value) {
                // TODO: Actualizar el estado de esta configuración
                print('Switch Email Notif: $value');
             },
              activeColor: theme.colorScheme.primary,
          ),

          Divider(
            color: Theme.of(context).dividerColor, // Color del separador
          ), 

          // --- Sección Apariencia ---
          _buildSectionHeader(context, 'Apariencia'),
          // Mantenemos el switch principal de Dark Mode en el Drawer
          // pero podríamos tener más opciones aquí.
          ListTile(
            leading: Icon(themeProvider.isDarkMode ? LucideIcons.moon : LucideIcons.sun, color: theme.iconTheme.color),
            title: Text('Modo Oscuro', style: theme.textTheme.bodyLarge),
            trailing: Switch(
               value: themeProvider.isDarkMode,
               onChanged: (bool value) {
                   // Llamamos al provider para cambiar el tema
                   Provider.of<ThemeProvider>(context, listen: false).toggleTheme(value);
               },
               activeColor: theme.colorScheme.primary,
             ),
            // No hacemos nada en onTap porque el Switch maneja la acción
            onTap: () {
                // Permitir tap en toda la fila para cambiar el switch
                 Provider.of<ThemeProvider>(context, listen: false).toggleTheme(!themeProvider.isDarkMode);
            },
          ),
           ListTile(
            leading: Icon(LucideIcons.type, color: theme.iconTheme.color),
            title: Text('Tamaño del Texto', style: theme.textTheme.bodyLarge),
             trailing: Icon(LucideIcons.chevronRight, color: theme.iconTheme.color?.withOpacity(0.5)),
            onTap: () {
              // TODO: Mostrar opciones de tamaño de texto
              print('Abrir opciones Tamaño Texto');
            },
          ),

          Divider(
            color: Theme.of(context).dividerColor, // Color del separador
          ), 

          // --- Sección Acerca de ---
           _buildSectionHeader(context, 'Información'),
           ListTile(
            leading: Icon(LucideIcons.circleHelp, color: theme.iconTheme.color),
            title: Text('Ayuda y Soporte', style: theme.textTheme.bodyLarge),
            onTap: () {
              // TODO: Abrir FAQ, contacto o web de ayuda
              print('Abrir Ayuda');
            },
          ),
           ListTile(
            leading: Icon(LucideIcons.shieldCheck, color: theme.iconTheme.color),
            title: Text('Política de Privacidad', style: theme.textTheme.bodyLarge),
            onTap: () {
              // TODO: Abrir URL de política de privacidad
              print('Abrir Política de Privacidad');
            },
          ),
           ListTile(
            leading: Icon(LucideIcons.info, color: theme.iconTheme.color),
            title: Text('Acerca de la App', style: theme.textTheme.bodyLarge),
            onTap: () {
              // Mostrar diálogo estándar de "Acerca de"
              showAboutDialog(
                 context: context,
                 applicationName: 'Stack App Mockup', // Reemplaza con tu nombre real
                 applicationVersion: '1.0.0', // Reemplaza con tu versión real
                 applicationIcon: Icon(LucideIcons.layers, size: 40, color: theme.colorScheme.primary),
                 applicationLegalese: '© ${DateTime.now().year} Tu Nombre/Empresa',
                 children: <Widget>[
                   const Padding(
                     padding: EdgeInsets.only(top: 15),
                     child: Text('Una aplicación de ejemplo creada con Flutter.')
                   )
                 ],
              );
            },
          ),
        ],
      ),
    );
  }

  // Helper para crear cabeceras de sección visualmente distintas
  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 8.0),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary, // Usa el color primario
          fontWeight: FontWeight.bold,
          fontSize: 12.0,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}