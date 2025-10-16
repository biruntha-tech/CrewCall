import 'package:flutter/material.dart';
import 'package:crewcall_flutter/theme/app_theme.dart';

class TalentProfilePage extends StatefulWidget {
  const TalentProfilePage({super.key});

  @override
  State<TalentProfilePage> createState() => _TalentProfilePageState();
}

class _TalentProfilePageState extends State<TalentProfilePage> {
  String? selectedExperience = "Professional";
  final Set<String> selectedSkills = {"Lighting", "Sound", "Video", "Stage", "Projection"};

  final List<Map<String, dynamic>> experienceLevels = [
    {"name": "Professional", "image": "assets/images/professional_icon.png", "icon": Icons.workspace_premium, "color": const Color(0xFFFFE4E1)},
    {"name": "Hobbyist", "image": "assets/images/hobbyist_icon.png", "icon": Icons.palette, "color": const Color(0xFFF4E6)},
    {"name": "Student", "image": "assets/images/student_icon.png", "icon": Icons.school, "color": const Color(0xFFE6F3FF)},
  ];
  final List<String> skills = [
    "Lighting",
    "Sound",
    "Video",
    "Rigging",
    "Stage",
    "Projection",
    "Broadcast",
    "Camera",
    "Editing",
    "VFX",
    "Director",
    "Producer",
    "Gaffer",
    "Grip",
    "FOH",
    "Monitor Engineer",
    "Live Streaming",
    "Drone",
    "Makeup",
    "Hair",
    "Wardrobe",
    "Set Design",
    "Props",
    "Teleprompter",
    "Photography",
    "colorist",
    "Animator",
    "motion graphics",
    "playback",
    "SFX",
    "Art Department",
    "PA"
  ];

  // 🎨 Custom color palette
  final Color unselectedColor = const Color(0xFFF3F4F6);
  final Color selectedColor = const Color(0xFFFFF7ED);
  final Color selectedTextColor = const Color(0xFF9A3413);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(
          children: [
            const Icon(Icons.headphones, color: AppColors.primary, size: 30),
            const SizedBox(width: 8),
            Text(
              "CrewCall",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey, width: 2),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Set up your talent profile",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Choose your experience and skills. You can edit this anytime.",
                  style: TextStyle(color: Colors.grey[600]),
                ),
            const SizedBox(height: 20),

                const SizedBox(height: 20),
                
                // Experience level
                const Text(
                  "Experience level",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: experienceLevels.map((level) {
                      final isSelected = selectedExperience == level["name"];
                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedExperience = level["name"];
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.primary : level["color"],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected ? AppColors.primary : Colors.grey[300]!,
                                width: 2,
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: isSelected ? Colors.white : Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.asset(
                                    level["image"],
                                    width: 32,
                                    height: 32,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(
                                        level["icon"],
                                        size: 32,
                                        color: isSelected ? AppColors.primary : Colors.grey[600],
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  level["name"],
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                
                const SizedBox(height: 25),
                const Text(
                  "Pick your skills",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 10),
                
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: skills.map((skill) {
                      final isSelected = selectedSkills.contains(skill);
                      return FilterChip(
                        label: Text(skill),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              selectedSkills.add(skill);
                            } else {
                              selectedSkills.remove(skill);
                            }
                          });
                        },
                        selectedColor: AppColors.selectedChip,
                        backgroundColor: AppColors.unselectedChip,
                        labelStyle: TextStyle(
                          color: isSelected ? AppColors.selectedText : Colors.black,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // Skip and Next Buttons
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            side: const BorderSide(color: AppColors.primary),
                          ),
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/main');
                          },
                          child: const Text(
                            "Skip",
                            style: TextStyle(fontSize: 16, color: AppColors.primary),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/main');
                          },
                          child: const Text(
                            "Next",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner:false,
    home: TalentProfilePage(),
  ));
}