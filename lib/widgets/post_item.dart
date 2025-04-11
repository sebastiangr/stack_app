import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart'; // Asegúrate de importar Lucide si usas sus iconos aquí
import '../models/post_data.dart';

class PostItem extends StatelessWidget {
  final PostData postData;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback onRepost;
  final VoidCallback onShare;
  final VoidCallback onSubscribe;
  final VoidCallback onMenu;

  const PostItem({
    Key? key,
    required this.postData,
    required this.onLike,
    required this.onComment,
    required this.onRepost,
    required this.onShare,
    required this.onSubscribe,
    required this.onMenu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 1. Obtén el tema actual
    final theme = Theme.of(context);
    // Define colores comunes basados en el tema
    final primaryTextColor = theme.textTheme.bodyLarge?.color;
    final secondaryTextColor = theme.textTheme.bodyMedium?.color?.withOpacity(0.7);
    final iconColor = theme.iconTheme.color?.withOpacity(0.8);
    final subscribeButtonColor = theme.colorScheme.primary; // O usa textButtonTheme

    return Container(
      // El color de fondo se manejará en FeedScreen o por el CardTheme
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      // Quita el margin de aquí si lo manejas en FeedScreen con el Container/Card
      // margin: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Info Row
          Row(
            children: [
              CircleAvatar(
                radius: 20.0,
                backgroundImage: NetworkImage(postData.userAvatarUrl),
                onBackgroundImageError: (exception, stackTrace) => {},
                backgroundColor: theme.colorScheme.onBackground.withOpacity(0.1), // Color de fondo del avatar
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 2. Usa el color del tema para el nombre de usuario
                    Text(
                      postData.userName,
                      style: theme.textTheme.titleMedium?.copyWith(
                         fontWeight: FontWeight.bold,
                         // El color ya está definido en titleMedium, pero puedes forzarlo si es necesario
                         // color: primaryTextColor
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    // 3. Usa un color secundario del tema para el nombre del canal/tiempo
                    Text(
                      postData.channelName,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: secondaryTextColor, // Color más sutil
                        // fontSize: 12.0, // El tamaño ya viene de bodySmall
                      ),
                    ),
                  ],
                ),
              ),
              // 4. Usa el TextButtonTheme definido en main.dart
              TextButton(
                onPressed: onSubscribe,
                // El estilo (color, etc.) vendrá del TextButtonThemeData global
                child: const Text('Suscribirse'),
              ),
              IconButton(
                // 5. Usa el color de icono del tema
                icon: Icon(LucideIcons.ellipsis, color: iconColor), 
                iconSize: 20.0,// Usa Lucide
                onPressed: onMenu,
                tooltip: 'Opciones',
              ),
            ],
          ),
          const SizedBox(height: 12.0),

          // 6. Usa el color de texto principal del tema para el contenido
          Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  postData.content,
                  // Usa un estilo de texto del tema, como bodyMedium
                  style: theme.textTheme.bodyMedium?.copyWith(
                    height: 1.4, // Puedes ajustar el interlineado si es necesario
                    // El color ya viene definido por el tema
                  ),
                ),
                const SizedBox(height: 16.0),

                // Action Bar Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildActionItem(
                      context: context, // Pasa el contexto
                      icon: postData.likedByCurrentUser ? LucideIcons.heart : LucideIcons.heart, // Usa Lucide (o usa Filled/Outline)
                      count: postData.likes,
                      onTap: onLike,
                      isActive: postData.likedByCurrentUser,
                      activeColor: Colors.pinkAccent, // Mantenemos un color distintivo para 'like'
                    ),
                    _buildActionItem(
                      context: context,
                      icon: LucideIcons.messageCircle, // Usa Lucide
                      count: postData.comments,
                      onTap: onComment,
                    ),
                    _buildActionItem(
                      context: context,
                      icon: LucideIcons.repeat, // Usa Lucide
                      count: postData.reposts,
                      onTap: onRepost,
                    ),
                    IconButton(
                      // 7. Usa el color de icono del tema para compartir
                      icon: Icon(LucideIcons.share2, color: iconColor), // Usa Lucide
                      onPressed: onShare,
                      iconSize: 20.0, // Ajusta tamaño si es necesario
                      // padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      tooltip: 'Compartir',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget for action items (Like, Comment, Repost)
  Widget _buildActionItem({
    required BuildContext context, // Necesitamos el contexto para acceder al tema
    required IconData icon,
    required int count,
    required VoidCallback onTap,
    bool isActive = false, // Para saber si está activo (ej: liked)
    Color? activeColor, // Color específico cuando está activo
  }) {
    // 8. Obtén colores del tema dentro del helper también
    final theme = Theme.of(context);
    final defaultIconColor = theme.iconTheme.color?.withOpacity(0.7);
    final defaultTextColor = theme.textTheme.bodySmall?.color?.withOpacity(0.9);
    // Determina el color final basado en si está activo
    final Color finalColor = isActive ? (activeColor ?? theme.colorScheme.primary) : (defaultIconColor ?? Colors.grey);
    final Color finalTextColor = isActive ? finalColor : (defaultTextColor ?? Colors.grey);


    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icono con color dinámico
            Icon(
              icon,
              // Si el icono es 'heart' y está activo, usa la versión llena (si existe y la usas)
              // Ejemplo: icon: isActive && icon == LucideIcons.heart ? Icons.favorite : icon, // O LucideIcons.heartFilled si existe
              color: finalColor,
              size: 20.0, // Ajusta tamaño si es necesario
            ),
            const SizedBox(width: 5.0),
            // Muestra el contador solo si es mayor que 0
            if (count > 0)
              Text(
                count.toString(),
                // Texto con color dinámico y estilo del tema
                style: theme.textTheme.bodySmall?.copyWith(
                   color: finalTextColor,
                   fontSize: 13.0, // Puedes ajustar
                ),
              ),
          ],
        ),
      ),
    );
  }
}