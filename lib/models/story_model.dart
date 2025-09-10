import 'user_model.dart';

class Story {
  final String id;
  final User user;
  final String imageUrl;
  final bool isViewed;

  Story({
    required this.id,
    required this.user,
    required this.imageUrl,
    this.isViewed = false,
  });
}