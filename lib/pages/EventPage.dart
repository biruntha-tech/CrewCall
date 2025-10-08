import 'package:crewcall_flutter/pages/talentpage.dart';
import 'package:crewcall_flutter/pages/profilePage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key});

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  File? selectedImage;
    int _selectIndex = 0;
  final ImagePicker _picker = ImagePicker();

  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController participantsController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();
  final TextEditingController excerptController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  String visibility = "Public";

  // Roles selection
  final List<String> roles = [
    "Lighting",
    "Sound",
    "Video",
    "Rigging",
    "Stage",
    "Projection",
    "Broadcast",
  ];
  final Set<String> selectedRoles = {};

void onTapped(int index)
{
  setState(() {
    _selectIndex = index;
  });
  
  if (index == 1) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const talentPage()));
  } else if (index == 2) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Event"),
        backgroundColor: Colors.orange,
        // foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover Image
            const Text("Cover image",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: Center(
                child: selectedImage != null
                    ? Image.file(selectedImage!, fit: BoxFit.cover)
                    : OutlinedButton(
                        onPressed: () async {
                          final XFile? image = await _picker.pickImage(
                            source: ImageSource.gallery,
                          );
                          if (image != null) {
                            setState(() {
                              selectedImage = File(image.path);
                            });
                          }
                        },
                        child: const Text("Choose Image"),
                      ),
              ),
            ),
            const SizedBox(height: 20),

            // Event Name
            TextField(
              controller: eventNameController,
              decoration: InputDecoration(
                labelText: "Event name",
                hintText: "e.g., Summer Fest 2025",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Date & Time
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2030),
                      );
                      if (pickedDate != null) {
                        setState(() => selectedDate = pickedDate);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today,
                              size: 20, color: Colors.grey),
                          const SizedBox(width: 8),
                          Text(
                            selectedDate == null
                                ? "Pick a date"
                                : DateFormat.yMMMd().format(selectedDate!),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedTime != null) {
                        setState(() => selectedTime = pickedTime);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.access_time,
                              size: 20, color: Colors.grey),
                          const SizedBox(width: 8),
                          Text(
                            selectedTime == null
                                ? "--:--"
                                : selectedTime!.format(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Location
            TextField(
              controller: locationController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.location_on_outlined),
                hintText: "City, Venue, or Address",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Roles
            const Text("Required roles",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: roles.map((role) {
                final isSelected = selectedRoles.contains(role);
                return ChoiceChip(
                  label: Text(role),
                  selected: isSelected,
                  selectedColor: Colors.orange.shade100,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        selectedRoles.add(role);
                      } else {
                        selectedRoles.remove(role);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // Participants
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: participantsController,
                    decoration: InputDecoration(
                      hintText: "Add names or roles",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Add participant
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text("Add"),
                )
              ],
            ),
            const SizedBox(height: 20),

            // Budget & Visibility
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: budgetController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixText: "\$ ",
                      hintText: "e.g., 1200",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: visibility,
                    items: ["Public", "Private"]
                        .map((v) =>
                            DropdownMenuItem(value: v, child: Text(v)))
                        .toList(),
                    onChanged: (v) => setState(() => visibility = v!),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),

            // Excerpt
            TextField(
              controller: excerptController,
              maxLines: 2,
              decoration: InputDecoration(
                hintText: "Short description shown on cards",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Notes
            TextField(
              controller: notesController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Details, load-in times, contact, gear, etc.",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
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
                      // TODO: Save draft
                    },
                    child: const Text("Save Draft"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Send request
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text("Send Request"),
                  ),
                ),
              ],
            ),  
          ],
        ),
      ),

      // Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectIndex,
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
        onTap: onTapped
        // (currentIndex) {
        //   Navigator.push(context, MaterialPageRoute(builder:(context)=> const CreateEventPage()));
        //   Navigator.push(context, MaterialPageRoute(builder: (context)=> const talentPage()));
        //   Navigator.push(context, MaterialPageRoute(builder: (context)=> const ProfilePage()));
        // },
      ),
    );
  }
}

// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: CreateEventPage(),
//   ));
// }
