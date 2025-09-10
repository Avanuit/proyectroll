import 'package:flutter/material.dart';
import '../utils/mock_data.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  int _notificationFilter = 0; // 0: Todas, 1: No leídas

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Activity'),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Filter notifications'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: const Text('All notifications'),
                            leading: Radio(
                              value: 0,
                              // ignore: deprecated_member_use
                              groupValue: _notificationFilter,
                              // ignore: deprecated_member_use
                              onChanged: (value) {
                                setState(() {
                                  _notificationFilter = value as int;
                                });
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text('Unread notifications'),
                            leading: Radio(
                              value: 1,
                              groupValue: _notificationFilter,
                              onChanged: (value) {
                                setState(() {
                                  _notificationFilter = value as int;
                                });
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Following'),
              Tab(text: 'You'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Following Tab
            ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(users[index % users.length].imageUrl),
                  ),
                  title: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: users[index % users.length].username,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(text: ' liked your post'),
                      ],
                    ),
                  ),
                  trailing: Image.network(
                    'https://picsum.photos/100?random=$index',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  subtitle: const Text('2 hours ago'),
                );
              },
            ),
            // You Tab
            ListView.builder(
              itemCount: 15,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(users[index % users.length].imageUrl),
                  ),
                  title: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: users[index % users.length].username,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        if (index % 3 == 0) const TextSpan(text: ' started following you'),
                        if (index % 3 == 1) const TextSpan(text: ' liked your comment: "Nice post!"'),
                        if (index % 3 == 2) const TextSpan(text: ' mentioned you in a comment: "Check this out @"'),
                      ],
                    ),
                  ),
                  trailing: index % 3 == 0
                      ? ElevatedButton(
                          onPressed: () {},
                          child: const Text('Follow back'),
                        )
                      : null,
                  subtitle: Text('${index + 1} hours ago'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}