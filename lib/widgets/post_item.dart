import 'package:flutter/material.dart';
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
    super.key,
    required this.postData,
    required this.onLike,
    required this.onComment,
    required this.onRepost,
    required this.onShare,
    required this.onSubscribe,
    required this.onMenu,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF121212), // Match main background or slightly different
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      margin: const EdgeInsets.only(bottom: 8.0), // Space between posts
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Info Row
          Row(
            children: [
              CircleAvatar(
                radius: 20.0,
                backgroundImage: NetworkImage(postData.userAvatarUrl),
                onBackgroundImageError: (exception, stackTrace) => {}, // Handle error
                backgroundColor: Colors.grey[800], // Placeholder color
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      postData.userName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      postData.channelName, // Could be channel or time like "1 días"
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 13.0,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: onSubscribe,
                style: TextButton.styleFrom(
                    foregroundColor: Colors.orangeAccent, // Text color
                    padding: EdgeInsets.zero, // Remove default padding
                    minimumSize: Size(50, 30) // Ensure it's tappable
                    ),
                child: const Text('Suscribirse'),
              ),
              IconButton(
                icon: Icon(Icons.more_horiz, color: Colors.white.withOpacity(0.8)),
                onPressed: onMenu,
                tooltip: 'Opciones',
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Padding(
            padding: const EdgeInsets.only(left: 60.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Content Text
                Text(
                  postData.content,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14.5,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16.0),

                // Action Bar Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 12.0), // Add a left margin of 12
                    _buildActionItem(
                        icon: postData.likedByCurrentUser ? Icons.favorite : Icons.favorite_border,
                        count: postData.likes,
                        onTap: onLike,
                        activeColor: Colors.pinkAccent), // Use pink/red for liked
                    _buildActionItem(
                        icon: Icons.chat_bubble_outline,
                        count: postData.comments,
                        onTap: onComment),
                    _buildActionItem(
                        icon: Icons.repeat, // Or Icons.sync for repost
                        count: postData.reposts,
                        onTap: onRepost),
                    IconButton(
                      icon: Icon(Icons.share_outlined, color: Colors.white.withOpacity(0.7)),
                      onPressed: onShare,
                      iconSize: 22.0,
                      padding: EdgeInsets.zero,
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
    required IconData icon,
    required int count,
    required VoidCallback onTap,
    Color? activeColor, // Optional color when active (e.g., liked)
  }) {
    final color = activeColor ?? Colors.white.withOpacity(0.7);
    return InkWell( // Make the whole area tappable
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0), // Small padding around icon+text
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 22.0),
              const SizedBox(width: 5.0),
              if (count > 0) // Only show count if > 0
                Text(
                  count.toString(),
                  style: TextStyle(color: color, fontSize: 13.5),
                ),
            ],
          ),
        ));
  }
}