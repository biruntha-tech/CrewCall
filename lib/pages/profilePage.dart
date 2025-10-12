import 'package:flutter/material.dart';
// import 'package:crewcall_flutter/pages/EventPage.dart';
// import 'package:crewcall_flutter/pages/talentpage.dart';

// Global user data storage
class UserData {
  static String? name;
  static String? email;
  static String? phone;
  static List<String> workLocations = [];

  static void setUserData(String userName, String userEmail, String userPhone) {
    name = userName;
    email = userEmail;
    phone = userPhone;
  }

  static void clearUserData() {
    name = null;
    email = null;
    phone = null;
    workLocations.clear();
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  bool notificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    // Load user data if available
    if (UserData.name != null) {
      nameController.text = UserData.name!;
    }
    if (UserData.email != null) {
      emailController.text = UserData.email!;
    }
    if (UserData.phone != null) {
      phoneController.text = UserData.phone!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black, width: 2),
            ),
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
                        Text(
                          nameController.text.isEmpty
                              ? "Your Name"
                              : nameController.text,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: nameController.text.isEmpty
                                ? Colors.grey
                                : Colors.black,
                          ),
                        ),
                        Text(
                          emailController.text.isEmpty
                              ? "your.email@example.com"
                              : emailController.text,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    child: OutlinedButton(
                      onPressed: () {
                        // TODO: Add photo picker
                      },
                      child: const Text("Update Photo"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Name
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Email
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Phone
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: "Phone",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Work locations
              const Text(
                "Work locations",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: locationController,
                      decoration: InputDecoration(
                        hintText: "Add a city or region",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.all(4),
                    child: ElevatedButton(
                      onPressed: () {
                        if (locationController.text.isNotEmpty) {
                          setState(() {
                            UserData.workLocations.add(locationController.text);
                            locationController.clear();
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                      ),
                      child: const Text("Add"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                children: UserData.workLocations
                    .map(
                      (loc) => Chip(
                        label: Text(loc),
                        onDeleted: () {
                          setState(() => UserData.workLocations.remove(loc));
                        },
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 20),

              // Notifications
              SwitchListTile(
                value: notificationsEnabled,
                //  tileColor: Colors.orange,
                 hoverColor: Colors.orange,
                 activeColor: Colors.orange,
                onChanged: (val) {
                  setState(() => notificationsEnabled = val);
                },
                title: const Text("Notifications"),
                subtitle: const Text(
                  "Receive updates about requests and bookings",
                ),
              ),
              const SizedBox(height: 20),

              // Payment
              const Text(
                "Payment",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Expanded(child: Text("No payment method added")),
                  Container(
                    padding: const EdgeInsets.all(4),
                    child: OutlinedButton(
                      onPressed: () {
                        // TODO: Add payment update logic
                      },
                      child: const Text("Add Card"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Log out + Switch account
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            UserData.clearUserData();
                            nameController.clear();
                            emailController.clear();
                            phoneController.clear();
                          });
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
              ),
            ],
          ),
        ),
      ),
      )
    );
  }
}

void main() {
  runApp(
    MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ProfilePage(),
  ));
}
