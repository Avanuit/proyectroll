import 'package:flutter/material.dart';
import '../screens/activity_screen.dart';
import '../screens/direct_messages_screen.dart';

class InstagramAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBackButton;

  const InstagramAppBar({
    Key? key,
    this.title,
    this.showBackButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      title: Row(
        children: [
          Image.asset(
            'assets/logo.png',
            height: 32,
          ),
          const SizedBox(width: 8),
          Text(
            title ?? 'Despuesgram',
            style: TextStyle(
              color: Colors.black,
              fontFamily: title == null ? 'Billabong' : null,
              fontSize: title == null ? 32 : 20,
              fontWeight: title == null ? FontWeight.normal : FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.favorite_border, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ActivityScreen()),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.send, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const DirectMessagesScreen()),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}