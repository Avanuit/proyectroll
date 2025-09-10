import 'package:flutter/material.dart';
import '../screens/create_post_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/reels_screen.dart';
import '../screens/search_screen.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/story_widget.dart';
import '../widgets/post_widget.dart';
import '../widgets/bottom_nav_bar.dart';
import '../utils/mock_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex == 0
          ? const InstagramAppBar()
          : AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              automaticallyImplyLeading: false,
            ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: const [
          HomeFeedScreen(), // 0
          SearchScreen(), // 1
          CreatePostScreen(), // 2
          ReelsScreen(), // 3
          ProfileScreen(), // 4 <-- Mueve ProfileScreen aquí
        ],
      ),
      bottomNavigationBar: InstagramBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.jumpToPage(index);
          });
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

class HomeFeedScreen extends StatelessWidget {
  const HomeFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (stories.isEmpty) {
      return const Center(child: Text('No stories available'));
    }

    return Column(
      children: [
        SizedBox(
          height: 110, // Aumenta la altura de 100 a 110
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: stories.length,
            itemBuilder: (context, index) {
              if (index < 0 || index >= stories.length) {
                return const SizedBox(width: 70);
              }
              return GestureDetector(
                onTap: () {
                  _showStoryViewer(context, index);
                },
                child: StoryWidget(story: stories[index]),
              );
            },
          ),
        ),
        const Divider(height: 1),
        // Posts
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
            },
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                // Verificación para posts también
                if (index < 0 || index >= posts.length) {
                  return const SizedBox(); // Widget vacío si el índice no es válido
                }
                return PostWidget(post: posts[index]);
              },
            ),
          ),
        ),
      ],
    );
  }

  void _showStoryViewer(BuildContext context, int initialIndex) {
    // Verificar que el initialIndex es válido
    if (initialIndex < 0 || initialIndex >= stories.length) {
      initialIndex =
          0; // Usar el primer índice válido si el proporcionado no lo es
    }

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.black,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: PageView.builder(
              itemCount: stories.length,
              controller: PageController(initialPage: initialIndex),
              itemBuilder: (context, index) {
                // Verificación CRÍTICA para evitar el error de índice
                if (index < 0 || index >= stories.length) {
                  return Container(
                    color: Colors.black,
                    child: const Center(
                      child: Text('Story not available',
                          style: TextStyle(color: Colors.white)),
                    ),
                  );
                }

                return Stack(
                  children: [
                    // Imagen de la historia
                    Image.network(
                      stories[index].imageUrl,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[800],
                          child: const Center(
                            child: Icon(Icons.error,
                                color: Colors.white, size: 50),
                          ),
                        );
                      },
                    ),
                    // Header con información del usuario
                    Positioned(
                      top: 40,
                      left: 16,
                      right: 16,
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(stories[index].user.imageUrl),
                            radius: 20,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            stories[index].user.username,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                    // Barra de progreso
                    Positioned(
                      top: 30,
                      left: 0,
                      right: 0,
                      child: Row(
                        children: List.generate(stories.length, (i) {
                          // Asegurarse de que i es un índice válido
                          if (i < 0 || i >= stories.length) {
                            return const SizedBox(width: 0); // Widget vacío
                          }

                          return Expanded(
                            child: Container(
                              height: 2,
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                color:
                                    i == index ? Colors.white : Colors.white54,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
