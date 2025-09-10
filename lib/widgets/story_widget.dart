import 'package:flutter/material.dart';
import '../models/story_model.dart';

class StoryWidget extends StatelessWidget {
  final Story story;
  final VoidCallback? onTap;

  const StoryWidget({super.key, required this.story, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70, // Ancho fijo
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min, // IMPORTANTE: Evita que el Column se expanda
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Contenedor del círculo de la historia
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: story.isViewed
                    ? null
                    : const LinearGradient(
                        colors: [
                          Colors.red,
                          Colors.orange,
                          Colors.purple,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(story.imageUrl),
                ),
              ),
            ),
            const SizedBox(height: 4),
            // Nombre de usuario con límite de líneas
            SizedBox(
              width: 70,
              child: Text(
                story.user.username,
                style: const TextStyle(
                  fontSize: 12,
                  height: 1.2, // Reduce la altura de línea
                ),
                maxLines: 1, // Máximo 1 línea
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}