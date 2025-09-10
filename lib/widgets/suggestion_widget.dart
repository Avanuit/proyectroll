import 'package:flutter/material.dart';
import '../models/user_model.dart';

class SuggestionWidget extends StatelessWidget {
  final User user;
  final VoidCallback? onFollow;

  const SuggestionWidget({super.key, required this.user, this.onFollow});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(user.imageUrl),
      ),
      title: Text(user.username),
      subtitle: const Text('Suggested for you'),
      trailing: TextButton(
        onPressed: onFollow,
        child: const Text('Follow'),
      ),
    );
  }
}