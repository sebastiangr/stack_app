
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
    // Get the app's scaffold background color to match
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    
    return Container(
      decoration: BoxDecoration(
        color: scaffoldBackgroundColor, // Match app background
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.1),
        //     blurRadius: 4,
        //     offset: const Offset(0, -1),
        //   ),
        // ],
      ),
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(0, LucideIcons.house, 'Home'),
          _buildNavItem(1, LucideIcons.layoutGrid, 'Search'),
          // Center add button with special styling
          _buildAddButton(),
          _buildNavItem(3, LucideIcons.messageSquare, 'Notifications'),
          _buildNavItem(4, LucideIcons.bell, 'Profile'),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = widget.selectedIndex == index;
    return InkWell(
      onTap: () => widget.onItemSelected(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? 
              Colors.orange : Colors.grey,
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
    );
  }

  Widget _buildAddButton() {
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
                color: Colors.orange,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.3),
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
