import 'package:flutter/material.dart';
import '../widgets/app_bar_widget.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const InstagramAppBar(title: 'Reels', showBackButton: false),
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              // Video
              Container(
                color: Colors.grey[900],
                child: const Center(
                  child: Icon(
                    Icons.play_arrow,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
              ),
              // User info
              Positioned(
                bottom: 20,
                left: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '@username',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Video description goes here...',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.music_note, color: Colors.white, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          'Original audio - username',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Actions
              Positioned(
                bottom: 20,
                right: 16,
                child: Column(
                  children: [
                    Column(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.favorite, color: Colors.white),
                          onPressed: () {},
                        ),
                        const Text('123K', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Column(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.chat_bubble_outline, color: Colors.white),
                          onPressed: () {},
                        ),
                        const Text('1.2K', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Column(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.send, color: Colors.white),
                          onPressed: () {},
                        ),
                        const Text('Share', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Icon(Icons.more_vert, color: Colors.white),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}