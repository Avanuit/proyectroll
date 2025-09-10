import 'package:flutter/material.dart';
import '../models/post_model.dart';

class PostWidget extends StatefulWidget {
  final Post post;

  const PostWidget({super.key, required this.post});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> with SingleTickerProviderStateMixin {
  late Post post;
  bool _isLiked = false;
  bool _isSaved = false;
  int _likeCount = 0;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    post = widget.post;
    _isLiked = post.isLiked;
    _isSaved = post.isSaved;
    _likeCount = post.likes;
    
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      _likeCount = _isLiked ? _likeCount + 1 : _likeCount - 1;
      
      if (_isLiked) {
        _animationController.forward().then((value) {
          Future.delayed(const Duration(milliseconds: 500), () {
            _animationController.reverse();
          });
        });
      }
    });
  }

  void _toggleSave() {
    setState(() {
      _isSaved = !_isSaved;
    });
  }

  void _showComments(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          maxChildSize: 0.9,
          minChildSize: 0.5,
          initialChildSize: 0.7,
          builder: (context, scrollController) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    'Comments',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const CircleAvatar(
                            backgroundImage: NetworkImage('https://picsum.photos/200'),
                          ),
                          title: const Text('Usuario'),
                          subtitle: const Text('Este es un comentario de ejemplo'),
                          trailing: IconButton(
                            icon: const Icon(Icons.favorite_border, size: 20),
                            onPressed: () {},
                          ),
                        );
                      },
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Add a comment...',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header del post
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(post.user.imageUrl),
          ),
          title: Text(post.user.username),
          trailing: IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.flag),
                        title: const Text('Report'),
                        onTap: () => Navigator.pop(context),
                      ),
                      ListTile(
                        leading: const Icon(Icons.link),
                        title: const Text('Copy link'),
                        onTap: () => Navigator.pop(context),
                      ),
                      ListTile(
                        leading: const Icon(Icons.share),
                        title: const Text('Share to...'),
                        onTap: () => Navigator.pop(context),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
        // Imagen del post
        GestureDetector(
          onDoubleTap: _toggleLike,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.network(
                post.imageUrl,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _animation.value,
                    child: Transform.scale(
                      scale: _animation.value * 1.5,
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 80,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        // Acciones del post
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      _isLiked ? Icons.favorite : Icons.favorite_border,
                      color: _isLiked ? Colors.red : Colors.black,
                    ),
                    onPressed: _toggleLike,
                  ),
                  IconButton(
                    icon: const Icon(Icons.chat_bubble_outline),
                    onPressed: () => _showComments(context),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {},
                  ),
                ],
              ),
              IconButton(
                icon: Icon(
                  _isSaved ? Icons.bookmark : Icons.bookmark_border,
                  color: _isSaved ? Colors.black : Colors.black,
                ),
                onPressed: _toggleSave,
              ),
            ],
          ),
        ),
        // Likes
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '$_likeCount likes',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        // Caption
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black),
              children: [
                TextSpan(
                  text: '${post.user.username} ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: post.caption),
              ],
            ),
          ),
        ),
        // Comentarios
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: GestureDetector(
            onTap: () => _showComments(context),
            child: Text(
              'View all ${post.comments} comments',
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ),
        // Tiempo
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: Text(
            '2 hours ago',
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
        ),
        const Divider(),
      ],
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}