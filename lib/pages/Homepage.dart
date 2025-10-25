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

  // Filter options
  final List<String> sortOptions = [
    "Best match",
    "Experience",
    "Rating",
    "Skills",
    "Gear"
  ];

  final List<String> skillOptions = [
    "Lighting",
    "Sound",
    "Video",
    "Rigging",
    "Stage",
    "Projection",
    "Broadcast"
  ];

  final List<String> gearOptions = [
    "Camera",
    "Lighting",
    "Sound",
  ];

  final List<String> paidOptions = ["any", "paid", "unpaid"];

  // Selected filter values
  String selectedSort = "Best match";
  Set<String> selectedSkills = {};
  String selectedPaid = "any";
  Set<String> selectedGear = {};

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

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                constraints: const BoxConstraints(maxHeight: 600),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Filter Talents',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Sort by
                            const Text(
                              'Sort by',
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            DropdownButtonFormField<String>(
                              value: selectedSort,
                              items: sortOptions
                                  .map((option) => DropdownMenuItem(
                                        value: option,
                                        child: Text(option),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setDialogState(() {
                                  selectedSort = value!;
                                });
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            
                            // Skills priority
                            const Text(
                              'Skills priority',
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 4,
                              children: skillOptions.map((skill) {
                                final isSelected = selectedSkills.contains(skill);
                                return FilterChip(
                                  label: Text(skill),
                                  selected: isSelected,
                                  selectedColor: AppColors.primary.withOpacity(0.2),
                                  onSelected: (selected) {
                                    setDialogState(() {
                                      if (selected) {
                                        selectedSkills.add(skill);
                                      } else {
                                        selectedSkills.remove(skill);
                                      }
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 20),
                            
                            // Paid or unpaid
                            const Text(
                              'Paid or unpaid',
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            DropdownButtonFormField<String>(
                              value: selectedPaid,
                              items: paidOptions
                                  .map((option) => DropdownMenuItem(
                                        value: option,
                                        child: Text(option.toUpperCase()),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setDialogState(() {
                                  selectedPaid = value!;
                                });
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            
                            // Gear
                            const Text(
                              'Gear',
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 4,
                              children: gearOptions.map((gear) {
                                final isSelected = selectedGear.contains(gear);
                                return FilterChip(
                                  label: Text(gear),
                                  selected: isSelected,
                                  selectedColor: AppColors.primary.withOpacity(0.2),
                                  onSelected: (selected) {
                                    setDialogState(() {
                                      if (selected) {
                                        selectedGear.add(gear);
                                      } else {
                                        selectedGear.remove(gear);
                                      }
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    // Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              setDialogState(() {
                                selectedSort = "Best match";
                                selectedSkills.clear();
                                selectedPaid = "any";
                                selectedGear.clear();
                              });
                            },
                            child: const Text('Clear All'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                            ),
                            onPressed: () {
                              setState(() {
                                // Apply filters here
                                _filterUsers();
                              });
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Apply Filters',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
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
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BookmarkedTalentsPage(),
                ),
              );
              setState(() {}); // Refresh the page when returning
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
                    onPressed: _showFilterDialog,
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
