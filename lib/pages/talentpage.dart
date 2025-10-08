import 'package:flutter/material.dart';
import 'package:crewcall_flutter/pages/EventPage.dart';
import 'package:crewcall_flutter/pages/profilePage.dart';

class talentPage extends StatefulWidget {
  const talentPage({super.key});

  @override
  State<talentPage> createState() => _talentPageState();
}

class _talentPageState extends State<talentPage> {
  int selectedIndex = 1;

  void onTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    
    if (index == 0) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateEventPage()));
    } else if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
    }
  }

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
        title: const Text("Talent Page"),
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
      
      // Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: Colors.orange,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: "Reservations",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
        onTap: onTapped,
      ),
    );
  }
}


void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: talentPage(),
  ));
}
