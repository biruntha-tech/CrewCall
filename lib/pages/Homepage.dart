import 'package:flutter/material.dart';
import 'package:crewcall_flutter/theme/app_theme.dart';
import 'package:crewcall_flutter/pages/talent_detail_page.dart';
import 'package:crewcall_flutter/pages/bookmarked_talents_page.dart';

// Global bookmarked talents list
List<Map<String, String>> globalBookmarkedTalents = [];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();
  final Set<String> selectedCategories = {};
  List<Map<String, String>> filteredUsers = [];

  // Sample chip data
  final List<String> categories = [
    "Lighting",
    "Sound",
    "Video",
    "Rigging",
    "Beginner",
    "Intermediate",
    "Expert",
  ];

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
  void initState() {
    super.initState();
    filteredUsers = users;
    searchController.addListener(_filterUsers);
  }

  void _filterUsers() {
    setState(() {
      filteredUsers = users.where((user) {
        final searchLower = searchController.text.toLowerCase();
        final nameLower = user["name"]!.toLowerCase();
        final bioLower = user["bio"]!.toLowerCase();
        return nameLower.contains(searchLower) ||
            bioLower.contains(searchLower);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.headphones, color: Colors.white, size: 30),
            const SizedBox(width: 8),
            const Text(
              "CrewCall",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.primary,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookmarkedTalentsPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Search Bar
            Container(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Search talents...",
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.filter_list),
                    onPressed: () {
                      // Filter action
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            // Filter Chips
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 8,
                runSpacing: 4,
                children: categories.map((category) {
                  final isSelected = selectedCategories.contains(category);
                  return FilterChip(
                    label: Text(category),
                    selected: isSelected,
                    selectedColor: AppColors.selectedChip,
                    backgroundColor: AppColors.unselectedChip,
                    labelStyle: TextStyle(
                      color: isSelected ? AppColors.selectedText : Colors.black,
                    ),
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          selectedCategories.add(category);
                        } else {
                          selectedCategories.remove(category);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),

            // User List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: filteredUsers.length,
                itemBuilder: (context, index) {
                  final user = filteredUsers[index];
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
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TalentDetailPage(talent: user),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
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
