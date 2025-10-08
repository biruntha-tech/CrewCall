import 'package:flutter/material.dart';
import 'package:crewcall_flutter/pages/EventPage.dart';
import 'package:crewcall_flutter/pages/talentpage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController nameController =
      TextEditingController(text: "Rushil Arumugam");
  final TextEditingController emailController =
      TextEditingController(text: "rushil@example.com");
  final TextEditingController phoneController =
      TextEditingController(text: "1234567890");
  final TextEditingController locationController = TextEditingController();
int selectedIndex =0;
  bool notificationsEnabled = true;

  final List<String> workLocations = ["Seattle"];

void onTapped(int index){
  setState(() {
    selectedIndex = index;
  });
  
  if (index == 0) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateEventPage()));
  } else if (index == 1) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const talentPage()));
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.orange,
                elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            Row(
              children: [
                const CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, size: 40, color: Colors.white),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(nameController.text,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(emailController.text,
                          style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    // TODO: Add photo picker
                  },
                  child: const Text("Update Photo"),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Name
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Name",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 16),

            // Email
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 16),

            // Phone
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: "Phone",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 20),

            // Work locations
            const Text("Work locations",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: locationController,
                    decoration: InputDecoration(
                      hintText: "Add a city or region",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (locationController.text.isNotEmpty) {
                      setState(() {
                        workLocations.add(locationController.text);
                        locationController.clear();
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  child: const Text("Add"),
                )
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              children: workLocations
                  .map((loc) => Chip(
                        label: Text(loc),
                        onDeleted: () {
                          setState(() => workLocations.remove(loc));
                        },
                      ))
                  .toList(),
            ),
            const SizedBox(height: 20),

            // Notifications
            SwitchListTile(
              value: notificationsEnabled,
              tileColor: Colors.orange,
              hoverColor: Colors.orange,
              onChanged: (val) {
                setState(() => notificationsEnabled = val);
              },
              title: const Text("Notifications"),
              subtitle:
                  const Text("Receive updates about requests and bookings"),
            ),
            const SizedBox(height: 20),

            // Payment
            const Text("Payment",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                const Expanded(child: Text("Card ending •••• 1234")),
                OutlinedButton(
                  onPressed: () {
                    // TODO: Add payment update logic
                  },
                  child: const Text("Update"),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Log out + Switch account
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // TODO: Logout logic
                    },
                    child: const Text("Log out"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Switch account logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text("Switch account"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      // Bottom Nav
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
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
      ),
    );
  }
}

// void main() {
//   runApp(
//      MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: ProfilePage()));
// }
