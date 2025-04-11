
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Usa el color de la BottomNavBar definido en el tema, o el del scaffold
    final navBarBackgroundColor = theme.bottomNavigationBarTheme.backgroundColor ?? theme.scaffoldBackgroundColor;
    // Color para el botón "+" (puede ser el primario del tema)
    final addButtonColor = theme.colorScheme.primary;
    // Get the app's scaffold background color to match
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    
    return Container(
      decoration: BoxDecoration(
        color: scaffoldBackgroundColor, // Match app background
        // Opcional: Añadir sombra si se quiere separar visualmente
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.05),
        //     blurRadius: 2,
        //     offset: const Offset(0, -1),
        //   ),
        // ],
      ),
      // Ajusta la altura para incluir padding de safe area si es necesario
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      height: 80 + MediaQuery.of(context).padding.bottom, // Altura base + safe area
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(0, LucideIcons.house, 'Home'),
          _buildNavItem(1, LucideIcons.layoutGrid, 'Search'),
          // Center add button with special styling
          _buildAddButton(addButtonColor),
          _buildNavItem(3, LucideIcons.messageSquare, 'Notifications'),
          _buildNavItem(4, LucideIcons.bell, 'Profile'),
        ],
      ),
    );
  }

  Widget _buildNavItem(int itemIndex, IconData icon, String label) {
    final theme = Theme.of(context);
    // El índice SELECCIONADO REAL viene de widget.selectedIndex
    // Comparamos el índice VISUAL (itemIndex) con el índice SELECCIONADO LÓGICO
    // Necesitamos mapear: 0->0, 1->1, 3->2, 4->3
    int logicalIndex = itemIndex;
    // if (itemIndex > 2) {
    //   logicalIndex = itemIndex - 1; // Ajuste para saltar el botón '+'
    // }
    // final isSelected = widget.selectedIndex == index;
    final isSelected = widget.selectedIndex == logicalIndex;

    // Colores del tema para seleccionado/no seleccionado
    final selectedColor = theme.bottomNavigationBarTheme.selectedItemColor ?? theme.colorScheme.primary;
    final unselectedColor = theme.bottomNavigationBarTheme.unselectedItemColor ?? Colors.grey;    

    return Expanded(
      child: InkWell(
        onTap: () => widget.onItemSelected(itemIndex),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? 
                selectedColor  : unselectedColor,
              size: 30,
            ),
            const SizedBox(height: 4),
            // Text(
            //   label,
            //   style: TextStyle(
            //     color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
            //     fontSize: 12,
            //     fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton(Color backgroundColor) {
    return GestureDetector(
      onTapDown: (_) {
        _animationController.forward();
      },
      onTapUp: (_) {
        _animationController.reverse();
        widget.onItemSelected(2); // Index 2 for the add button
      },
      onTapCancel: () {
        _animationController.reverse();
      },
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: backgroundColor.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                LucideIcons.plus,
                color: Colors.white,
                size: 40,
              ),
            ),
          );
        },
      ),
    );
  }
}
