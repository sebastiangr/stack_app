import 'package:flutter/material.dart';
import '../models/card_data.dart';

class HorizontalCardItem extends StatelessWidget {
  final CardData cardData;

  const HorizontalCardItem({super.key, required this.cardData});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Adjust card width based on screen size, showing roughly 1.5 cards
    final cardWidth = screenWidth * 0.65;

    return Container(
      width: cardWidth,
      margin: const EdgeInsets.only(right: 12.0),
      decoration: BoxDecoration(
        color: cardData.backgroundColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with Gradient
          Expanded(
            flex: 5, // Adjust flex factor for image height
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0),
                  ),
                  child: Image.network(
                    cardData.imageUrl,
                    fit: BoxFit.cover,
                    // Loading and error builders are good practice
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                            : null,
                        strokeWidth: 2,
                        color: Colors.white54,
                      ));
                    },
                    errorBuilder: (context, error, stackTrace) =>
                      Container(color: Colors.grey[700], child: const Icon(Icons.broken_image, color: Colors.white38)),
                  ),
                ),
                // Gradient Overlay
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        topRight: Radius.circular(12.0),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          cardData.backgroundColor.withOpacity(0.5),
                          cardData.backgroundColor,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.0, 0.6, 1.0],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Text Content Area
          Expanded(
            flex: 6, // Adjust flex factor for text area height
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Pushes icons to bottom
                children: [
                  Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisSize: MainAxisSize.min, // Prevent column taking all space
                    children: [
                      Text(
                        cardData.category,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 12.0,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        strutStyle: StrutStyle(forceStrutHeight: true, height: 2.0), // force two lines
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        cardData.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          height: 1.2, // Line spacing
                        ),
                         maxLines: 3, // Allow more lines for title
                         overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  // Bottom row (Status and Icons)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Status Text (Nuevo, % leído, Escucha)
                      Text(
                        cardData.status,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 12.0,
                        ),
                      ),
                      // Icons Row
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.bookmark_border, color: Colors.white.withOpacity(0.8), size: 20.0),
                          const SizedBox(width: 8.0),
                          Icon(Icons.more_horiz, color: Colors.white.withOpacity(0.8), size: 20.0),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}