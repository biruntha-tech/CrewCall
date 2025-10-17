import 'package:flutter/material.dart';
import 'package:crewcall_flutter/theme/app_theme.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:crewcall_flutter/pages/welcome.dart';
import 'package:crewcall_flutter/pages/AccountSignUP.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

// Global user data storage
class UserData {
  static String? name;
  static String? email;
  static String? phone;
  static List<String> workLocations = [];
  static String? profileImagePath;

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
    profileImagePath = null;
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
  final ImagePicker _picker = ImagePicker();

  bool notificationsEnabled = true;

  void _switchAccount() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Switch Account'),
          content: const Text('Choose an option to continue:'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                UserData.clearUserData();
                Navigator.of(context).pop();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TalentSignupPage(),
                  ),
                  (route) => false,
                );
              },
              child: const Text('Create Account'),
            ),
            ElevatedButton(
              onPressed: () {
                UserData.clearUserData();
                Navigator.of(context).pop();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const WelcomePage()),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              child: const Text('Login Different'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location services are disabled')),
        );
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')),
          );
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Location permissions are permanently denied'),
          ),
        );
        return;
      }

      Position position = await Geolocator.getCurrentPosition();
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String address =
            '${place.locality}, ${place.administrativeArea}, ${place.country}';
        setState(() {
          locationController.text = address;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error getting location: $e')));
    }
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 75,
      );

      if (image != null) {
        setState(() {
          UserData.profileImagePath = image.path;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey, width: 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Header
                Row(
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.grey,
                        backgroundImage: UserData.profileImagePath != null
                            ? FileImage(File(UserData.profileImagePath!))
                            : null,
                        child: UserData.profileImagePath == null
                            ? const Icon(
                                Icons.person,
                                size: 40,
                                color: Colors.white,
                              )
                            : null,
                      ),
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
                        onPressed: _pickImage,
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
                              UserData.workLocations.add(
                                locationController.text,
                              );
                              locationController.clear();
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                        ),
                        child: const Text(
                          "Add",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.all(4),
                      child: IconButton(
                        onPressed: _getCurrentLocation,
                        icon: const Icon(Icons.my_location),
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                        ),
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
                  hoverColor: AppColors.primary,
                  activeColor: AppColors.primary,
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 12,
                  ),
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
                          onPressed: _switchAccount,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text(
                            "Switch account",
                            style: TextStyle(color: Colors.white),
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
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: ProfilePage()));
}
