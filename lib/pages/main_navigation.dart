import 'package:crewcall_flutter/pages/Create_EventPage.dart';
import 'package:crewcall_flutter/pages/Reserved_events_page.dart';
import 'package:crewcall_flutter/pages/profilePage.dart';
import 'package:crewcall_flutter/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Homepage.dart';
// import 'package:crewcall_flutter/pages/EventPage.dart';
// import 'package:crewcall_flutter/pages/event_registration_page.dart';
// import 'package:crewcall_flutter/pages/talentpage.dart';

class MainNavigation extends StatefulWidget {
  final bool fromLogin;
  const MainNavigation({super.key, this.fromLogin = false});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int selectedIndex = 0;
  List<Map<String, dynamic>> events = [];
  Key eventsPageKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    _loadSelectedIndex();
  }

  _loadSelectedIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (widget.fromLogin) {
      selectedIndex = 0; // Always go to home when coming from login
      await prefs.setInt('selectedIndex', 0); // Save home as current tab
    } else {
      selectedIndex = prefs.getInt('selectedIndex') ?? 0;
    }
    setState(() {});
  }

  _saveSelectedIndex(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('selectedIndex', index);
  }

  void onTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    _saveSelectedIndex(index);
  }

  void addEvent(Map<String, dynamic> event) {
    setState(() {
      events.add(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const HomePage(),
      EventsPage(key: eventsPageKey),
      const ProfilePage(),
    ];

    return WillPopScope(
      onWillPop: () async {
        if (selectedIndex != 0) {
          // If not on home page, go to home page
          setState(() {
            selectedIndex = 0;
          });
          _saveSelectedIndex(0);
          return false; // Don't exit app
        }
        return true; // Allow exit from home page
      },
      child: Scaffold(
        body: IndexedStack(index: selectedIndex, children: pages),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Home",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.event), label: "Events"),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: "Profile",
            ),
          ],
          onTap: onTapped,
        ),
        floatingActionButton: selectedIndex == 1
            ? FloatingActionButton(
                backgroundColor: AppColors.primary,
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateEventPage(),
                    ),
                  );
                  // Force refresh by creating new key
                  setState(() {
                    eventsPageKey = UniqueKey();
                  });
                },
                child: const Icon(Icons.add, color: Colors.white),
              )
            : null,
      ),
    );
  }
}

// Global reserved events list
List<Map<String, dynamic>> globalReservedEvents = [];

// class TalentsHomePage extends StatelessWidget {
//   const TalentsHomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Talents"),
//         backgroundColor: Colors.orange,
//         foregroundColor: Colors.white,
//         automaticallyImplyLeading: false,
//       ),
//       body: const talentPage(),
//     );
//   }
// }

// class ReservedEventsPage extends StatefulWidget {
//   const ReservedEventsPage({super.key});

//   @override
//   State<ReservedEventsPage> createState() => _ReservedEventsPageState();
// }

// class _ReservedEventsPageState extends State<ReservedEventsPage> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("My Reserved Events"),
//         backgroundColor: Colors.orange,
//         foregroundColor: Colors.white,
//         automaticallyImplyLeading: false,
//       ),
//       body: globalReservedEvents.isEmpty
//           ? const Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.event_busy, size: 80, color: Colors.grey),
//                   SizedBox(height: 20),
//                   Text(
//                     "No Reserved Events",
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     "Go to Home to join events",
//                     style: TextStyle(color: Colors.grey),
//                   ),
//                 ],
//               ),
//             )
//           : ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: globalReservedEvents.length,
//               itemBuilder: (context, index) {
//                 final event = globalReservedEvents[index];
//                 return Card(
//                   margin: const EdgeInsets.only(bottom: 16),
//                   child: ListTile(
//                     leading: ClipRRect(
//                       borderRadius: BorderRadius.circular(8),
//                       child: Image.network(
//                         event["image"]!,
//                         width: 60,
//                         height: 60,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     title: Text(event["title"]!, style: const TextStyle(fontWeight: FontWeight.bold)),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text("📅 ${event["date"]!}"),
//                         Text("📍 ${event["location"]!}"),
//                       ],
//                     ),
//                     trailing: const Icon(Icons.check_circle, color: Colors.green),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }

// class ProfilePageWithNav extends StatelessWidget {
//   const ProfilePageWithNav({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Profile"),
//         backgroundColor: Colors.orange,
//         foregroundColor: Colors.white,
//         automaticallyImplyLeading: false,
//       ),
//       body: const Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircleAvatar(
//               radius: 50,
//               backgroundColor: Colors.orange,
//               child: Icon(Icons.person, size: 50, color: Colors.white),
//             ),
//             SizedBox(height: 20),
//             Text("John Doe", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//             Text("john.doe@example.com", style: TextStyle(fontSize: 16, color: Colors.grey)),
//             SizedBox(height: 30),
//             Text("Profile features coming soon!", style: TextStyle(fontSize: 16)),
//           ],
//         ),
//       ),
//     );
//   }
// }

void main() {
  runApp(
    const MaterialApp(
      home: MainNavigation(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
