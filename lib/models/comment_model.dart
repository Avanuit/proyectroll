import 'user_model.dart';

class Comment {
  final String id;
  final User user;
  final String text;
  final DateTime timestamp;
  final int likes;

  Comment({
    required this.id,
    required this.user,
    required this.text,
    required this.timestamp,
    this.likes = 0,
  });
}