// import 'package:crewcall_flutter/pages/Create_EventPage.dart';
// import 'package:crewcall_flutter/pages/main_navigation.dart';
import 'package:flutter/material.dart';
import 'package:crewcall_flutter/theme/app_theme.dart';
import 'Homepage.dart';
// import 'package:crewcall_flutter/pages/EventPage.dart';
import 'package:crewcall_flutter/pages/profilePage.dart';
import 'package:crewcall_flutter/pages/my_reservations_page.dart';
import 'package:crewcall_flutter/pages/event_history_page.dart';
// import 'package:crewcall_flutter/pages/event_registration_page.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  int selectedIndex = 1;
  final TextEditingController searchController = TextEditingController();
  String selectedStatusFilter = "All";
  List<Map<String, dynamic>> filteredEvents = [];

  void onTapped(int index) {
    setState(() {
      selectedIndex = index;
    });

    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfilePage()),
      );
    }
  }

  List<Map<String, dynamic>> reservedEvents = [];

  // Sample participated events history
  List<Map<String, dynamic>> participatedEvents = [
    {
      "title": "Spring Concert 2024",
      "date": "March 15, 2024",
      "location": "City Hall",
      "image":
          "https://images.unsplash.com/photo-1459749411175-04bf5292ceea?w=300&h=200&fit=crop",
    },
    {
      "title": "Winter Festival",
      "date": "December 20, 2023",
      "location": "Downtown Plaza",
      "image":
          "https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=300&h=200&fit=crop",
    },
  ];

  void _reserveEvent(Map<String, dynamic> event) {
    setState(() {
      if (!reservedEvents.any((e) => e["title"] == event["title"])) {
        reservedEvents.add(event);
      }
    });
  }

  List<Map<String, dynamic>> events = [
    {
      "title": "Summer Music Festival",
      "date": "July 15, 2024",
      "location": "Central Park, NYC",
      "organizer": "Music Events Co.",
      "image":
          "https://images.unsplash.com/photo-1459749411175-04bf5292ceea?w=300&h=200&fit=crop",
      "status": "Open",
      "participants": "25/50",
      "participantList": [
        "Alice Johnson",
        "Bob Smith",
        "Carol Davis",
        "David Wilson",
        "Emma Brown",
      ],
    },
    {
      "title": "Jazz Night Live",
      "date": "July 20, 2024",
      "location": "Blue Note Club",
      "organizer": "Jazz Productions",
      "image":
          "https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=300&h=200&fit=crop",
      "status": "Almost Full",
      "participants": "18/20",
      "participantList": [
        "Frank Miller",
        "Grace Lee",
        "Henry Taylor",
        "Ivy Chen",
      ],
    },
    {
      "title": "Rock Concert Series",
      "date": "August 5, 2024",
      "location": "Madison Square Garden",
      "organizer": "Rock Events LLC",
      "image":
          "https://images.unsplash.com/photo-1501386761578-eac5c94b800a?w=300&h=200&fit=crop",
      "status": "Open",
      "participants": "12/100",
      "participantList": [],
    },
    {
      "title": "Acoustic Evening",
      "date": "July 25, 2024",
      "location": "Coffee House Downtown",
      "organizer": "Indie Music Group",
      "image":
          "https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?w=300&h=200&fit=crop",
      "status": "New",
      "participants": "5/15",
      "participantList": [],
    },
    {
      "title": "Electronic Dance Party",
      "date": "August 10, 2024",
      "location": "Warehouse District",
      "organizer": "EDM Collective",
      "image":
          "https://images.unsplash.com/photo-1470229722913-7c0e2dbbafd3?w=300&h=200&fit=crop",
      "status": "Open",
      "participants": "30/80",
      "participantList": [],
    },
  ];

  @override
  void initState() {
    super.initState();
    filteredEvents = events;
    searchController.addListener(_filterEvents);
  }

  void _filterEvents() {
    setState(() {
      filteredEvents = events.where((event) {
        final searchLower = searchController.text.toLowerCase();
        final titleMatch = event["title"]!.toLowerCase().contains(searchLower);
        final locationMatch = event["location"]!.toLowerCase().contains(
          searchLower,
        );
        final organizerMatch = event["organizer"]!.toLowerCase().contains(
          searchLower,
        );

        final searchMatch = titleMatch || locationMatch || organizerMatch;
        final statusMatch =
            selectedStatusFilter == "All" ||
            event["status"] == selectedStatusFilter;

        return searchMatch && statusMatch;
      }).toList();
    });
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Open':
        return Colors.green;
      case 'Almost Full':
        return Colors.orange;
      case 'New':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  void _showParticipants(BuildContext context, Map<String, dynamic> event) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final participants = event["participantList"] as List<String>? ?? [];
        return AlertDialog(
          title: Text("Participants - ${event["title"]!}"),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: participants.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(child: Text(participants[index][0])),
                  title: Text(participants[index]),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showEventDetails(BuildContext context, Map<String, dynamic> event) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(15),
                  ),
                  child: Image.network(
                    event["image"]!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event["title"]!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            color: Colors.orange,
                          ),
                          const SizedBox(width: 8),
                          Text(event["date"]!),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.orange),
                          const SizedBox(width: 8),
                          Expanded(child: Text(event["location"]!)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.person, color: Colors.orange),
                          const SizedBox(width: 8),
                          Text(event["organizer"]!),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.group, color: Colors.orange),
                          const SizedBox(width: 8),
                          Text("${event["participants"]!} participants"),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Close'),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                            ),
                            onPressed: () {
                              final reservationCode =
                                  'RC${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}';
                              _reserveEvent(event);
                              Navigator.of(context).pop();
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Reservation Confirmed'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                        size: 50,
                                      ),
                                      const SizedBox(height: 10),
                                      Text('Event: ${event["title"]!}'),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Reservation Code: $reservationCode',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange,
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: const Text('Join Event'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Reservation"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      EventHistoryPage(participatedEvents: participatedEvents),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MyReservationsPage(reservedEvents: reservedEvents),
                ),
              );
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list),
            onSelected: (value) {
              setState(() {
                selectedStatusFilter = value;
                _filterEvents();
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: "All", child: Text("All Events")),
              const PopupMenuItem(value: "Open", child: Text("Open")),
              const PopupMenuItem(
                value: "Almost Full",
                child: Text("Almost Full"),
              ),
              const PopupMenuItem(value: "New", child: Text("New")),
            ],
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
                  hintText: "Search events...",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            // Events List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: filteredEvents.length,
                itemBuilder: (context, index) {
                  final event = filteredEvents[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(15),
                          ),
                          child: Image.network(
                            event["image"]!,
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      event["title"]!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(event["status"]!),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      event["status"]!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_today,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    event["date"]!,
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      event["location"]!,
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.person,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    "Organized by ${event["organizer"]!}",
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () =>
                                        _showParticipants(context, event),
                                    child: Text(
                                      "Participants: ${event["participants"]!}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.orange,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    onPressed: () {
                                      _showEventDetails(context, event);
                                    },
                                    child: const Text("View Details"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
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

void main() {
  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: EventsPage()),
  );
}
