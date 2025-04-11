class PostData {
  final String id;
  final String userAvatarUrl;
  final String userName;
  final String channelName; // Or subtitle like "1 días"
  final String content;
  final int likes;
  final int comments;
  final int reposts;
  final bool likedByCurrentUser; // To potentially change like icon state

  PostData({
    required this.id,
    required this.userAvatarUrl,
    required this.userName,
    required this.channelName,
    required this.content,
    this.likes = 0,
    this.comments = 0,
    this.reposts = 0,
    this.likedByCurrentUser = false,
  });
}