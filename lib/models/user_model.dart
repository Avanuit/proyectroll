class User {
  final String id;
  final String username;
  final String name;
  final String imageUrl;
  final String bio;
  final int followers;
  final int following;
  final int posts;
  final bool isVerified;

  User({
    required this.id,
    required this.username,
    required this.name,
    required this.imageUrl,
    this.bio = '',
    this.followers = 0,
    this.following = 0,
    this.posts = 0,
    this.isVerified = false,
  });

  User copyWith({
    String? id,
    String? username,
    String? name,
    String? imageUrl,
    String? bio,
    int? followers,
    int? following,
    int? posts,
    bool? isVerified,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      bio: bio ?? this.bio,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      posts: posts ?? this.posts,
      isVerified: isVerified ?? this.isVerified,
    );
  }
}