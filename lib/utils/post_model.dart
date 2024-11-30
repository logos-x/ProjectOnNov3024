class Comment {
  final String userName;
  final String text;

  Comment({required this.userName, required this.text});
}

class Post {
  final String userName;
  final String content;
  final String? imageUrl;
  final String? videoUrl;
  int likes;
  List<Comment> comments;

  Post({
    required this.userName,
    required this.content,
    this.imageUrl,
    this.videoUrl,
    this.likes = 0,
    List<Comment>? comments,
  }) : comments = comments ?? [];
}
