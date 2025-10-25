import 'package:flutter/material.dart';
import 'package:crewcall_flutter/theme/app_theme.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:crewcall_flutter/models/event_storage.dart';
import 'package:crewcall_flutter/widgets/location_picker.dart';
import 'package:crewcall_flutter/widgets/talent_selector.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key});

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  File? selectedImage;

  final ImagePicker _picker = ImagePicker();

  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController participantsController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();
  final TextEditingController excerptController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  String visibility = "Public";
  bool _isGettingLocation = false;
  List<Map<String, String>> selectedParticipants = [];

  Future<void> _getCurrentLocation() async {
    setState(() => _isGettingLocation = true);
    
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showError('Location services are disabled');
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showError('Location permissions are denied');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _showError('Location permissions are permanently denied');
        return;
      }

      Position position = await Geolocator.getCurrentPosition();
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String address = '${place.locality}, ${place.administrativeArea}, ${place.country}';
        setState(() {
          locationController.text = address;
        });
      }
    } catch (e) {
      _showError('Error getting location: $e');
    } finally {
      setState(() => _isGettingLocation = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Create Event",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey, width: 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cover Image
                const Text(
                  "Cover image",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
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
                const Text(
                  "Event Name",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: eventNameController,
                  decoration: InputDecoration(
                    hintText: "e.g., Summer Fest 2025",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Date & Time
                const Text(
                  "Date & Time",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
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
                            vertical: 14,
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.calendar_today,
                                size: 20,
                                color: Colors.grey,
                              ),
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
                            vertical: 14,
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.access_time,
                                size: 20,
                                color: Colors.grey,
                              ),
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
                const Text(
                  "Location",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: locationController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.location_on_outlined),
                          hintText: "City, Venue, or Address",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: _isGettingLocation ? null : _getCurrentLocation,
                      icon: _isGettingLocation 
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.my_location),
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => LocationPicker(
                            onLocationSelected: (location) {
                              setState(() {
                                locationController.text = location;
                              });
                            },
                          ),
                        );
                      },
                      icon: const Icon(Icons.search),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Roles
                const Text(
                  "Required roles",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: roles.map((role) {
                    final isSelected = selectedRoles.contains(role);
                    return ChoiceChip(
                      label: Text(role),
                      selected: isSelected,
                      selectedColor: AppColors.primary,
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
                const Text(
                  "Participants",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
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
                        showDialog(
                          context: context,
                          builder: (context) => TalentSelector(
                            selectedTalents: selectedParticipants,
                            onTalentsSelected: (talents) {
                              setState(() {
                                selectedParticipants = talents;
                              });
                            },
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Add",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (selectedParticipants.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Selected Participants:",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: selectedParticipants.map((participant) {
                            return Chip(
                              avatar: CircleAvatar(
                                backgroundImage: NetworkImage(participant["image"]!),
                              ),
                              label: Text(participant["name"]!),
                              onDeleted: () {
                                setState(() {
                                  selectedParticipants.remove(participant);
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 20),

                // Budget & Visibility
                const Text(
                  "Budget & Visibility",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
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
                            .map(
                              (v) => DropdownMenuItem(value: v, child: Text(v)),
                            )
                            .toList(),
                        onChanged: (v) => setState(() => visibility = v!),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Excerpt
                const Text(
                  "Event Description",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: excerptController,
                  maxLines: 2,
                  decoration: InputDecoration(
                    labelText: "Event Description",
                    hintText: "Short description shown on cards",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Notes
                const Text(
                  "Additional Notes",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
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
                          if (eventNameController.text.isEmpty ||
                              selectedDate == null ||
                              selectedTime == null ||
                              locationController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please fill all required fields'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          final newEvent = {
                            "title": eventNameController.text,
                            "date": DateFormat.yMMMd().format(selectedDate!),
                            "location": locationController.text,
                            "organizer": "You",
                            "image": "https://images.unsplash.com/photo-1459749411175-04bf5292ceea?w=300&h=200&fit=crop",
                            "status": "New",
                            "participants": "0/50",
                            "participantList": selectedParticipants.map((p) => p["name"]!).toList(),
                            "roles": selectedRoles.toList(),
                            "budget": budgetController.text,
                            "visibility": visibility,
                            "description": excerptController.text,
                            "notes": notesController.text,
                          };

                          final storage = EventStorage();
                          storage.addCreatedEvent(newEvent);
                          print('Event created: ${newEvent["title"]}');
                          print('Total events: ${storage.getAllEvents().length}');
                          print('Created events count: ${storage.createdEvents.length}');
                          print('All events: ${storage.getAllEvents().map((e) => e["title"]).toList()}');
                          
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Event created successfully!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "create event",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
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
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: CreateEventPage()),
  );
}
