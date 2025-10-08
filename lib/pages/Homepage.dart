import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Example data (you can fetch from backend later)
  final List<Map<String, String>> users = const [
    {
      "name": "Alice Johnson",
      "bio": "Singer • Performer • Music Lover",
      "image": "https://i.pravatar.cc/150?img=5",
    },
    {
      "name": "David Smith",
      "bio": "Event Organizer • Producer",
      "image": "https://i.pravatar.cc/150?img=15",
    },
    {
      "name": "Sophie Brown",
      "bio": "Guitarist • Composer • Stage Performer",
      "image": "https://i.pravatar.cc/150?img=25",
    },
    {
      "name": "John Williams",
      "bio": "DJ • Live Music Enthusiast",
      "image": "https://i.pravatar.cc/150?img=30",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CrewCall Home"),
        backgroundColor: Colors.orange,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(user["image"]!),
              ),
              title: Text(
                user["name"]!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                user["bio"]!,
                style: TextStyle(color: Colors.grey[700]),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  // Show user profile / actions
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: HomePage(),
//   ));
// }
