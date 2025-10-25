import 'package:flutter/material.dart';
import 'package:crewcall_flutter/theme/app_theme.dart';

class TalentSelector extends StatefulWidget {
  final Function(List<Map<String, String>>) onTalentsSelected;
  final List<Map<String, String>> selectedTalents;
  
  const TalentSelector({
    super.key, 
    required this.onTalentsSelected,
    this.selectedTalents = const [],
  });

  @override
  State<TalentSelector> createState() => _TalentSelectorState();
}

class _TalentSelectorState extends State<TalentSelector> {
  final TextEditingController searchController = TextEditingController();
  List<Map<String, String>> filteredTalents = [];
  Set<String> selectedTalentNames = {};

  final List<Map<String, String>> talents = const [
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
    filteredTalents = talents;
    selectedTalentNames = widget.selectedTalents.map((t) => t["name"]!).toSet();
    searchController.addListener(_filterTalents);
  }

  void _filterTalents() {
    setState(() {
      filteredTalents = talents.where((talent) {
        final searchLower = searchController.text.toLowerCase();
        final nameLower = talent["name"]!.toLowerCase();
        final bioLower = talent["bio"]!.toLowerCase();
        return nameLower.contains(searchLower) || bioLower.contains(searchLower);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Talents'),
      content: SizedBox(
        width: 350,
        height: 400,
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search talents...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 16),
            
            Expanded(
              child: ListView.builder(
                itemCount: filteredTalents.length,
                itemBuilder: (context, index) {
                  final talent = filteredTalents[index];
                  final isSelected = selectedTalentNames.contains(talent["name"]);
                  
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(talent["image"]!),
                      ),
                      title: Text(talent["name"]!),
                      subtitle: Text(talent["bio"]!),
                      trailing: Checkbox(
                        value: isSelected,
                        onChanged: (selected) {
                          setState(() {
                            if (selected == true) {
                              selectedTalentNames.add(talent["name"]!);
                            } else {
                              selectedTalentNames.remove(talent["name"]!);
                            }
                          });
                        },
                      ),
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            selectedTalentNames.remove(talent["name"]!);
                          } else {
                            selectedTalentNames.add(talent["name"]!);
                          }
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final selected = talents
                .where((talent) => selectedTalentNames.contains(talent["name"]))
                .toList();
            widget.onTalentsSelected(selected);
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
          ),
          child: const Text(
            'Add Selected',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}