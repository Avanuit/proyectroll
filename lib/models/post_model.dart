import 'user_model.dart';

class Post {
  final String id;
  final User user;
  final String imageUrl;
  final String caption;
  final int likes;
  final int comments;
  final DateTime timestamp;
  final bool isLiked;
  final bool isSaved;

  Post({
    required this.id,
    required this.user,
    required this.imageUrl,
    required this.caption,
    this.likes = 0,
    this.comments = 0,
    required this.timestamp,
    this.isLiked = false,
    this.isSaved = false,
  });

  Post copyWith({
    String? id,
    User? user,
    String? imageUrl,
    String? caption,
    int? likes,
    int? comments,
    DateTime? timestamp,
    bool? isLiked,
    bool? isSaved,
  }) {
    return Post(
      id: id ?? this.id,
      user: user ?? this.user,
      imageUrl: imageUrl ?? this.imageUrl,
      caption: caption ?? this.caption,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      timestamp: timestamp ?? this.timestamp,
      isLiked: isLiked ?? this.isLiked,
      isSaved: isSaved ?? this.isSaved,
    );
  }
}