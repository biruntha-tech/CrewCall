import 'package:flutter/material.dart';
import 'EventPage.dart';
import 'profilePage.dart';
import 'events_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(
          children: [
            const Icon(Icons.headphones, color: Colors.orange, size: 30),
            const SizedBox(width: 8),
            Text(
              "CrewCall",
              // textAlign: Alignment.center,
              style: TextStyle(
                // textAlign:Alignment.center,
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Images section
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildImage("https://picsum.photos/300/400?random=1"),
                  _buildImage("https://picsum.photos/300/400?random=2"),
                  _buildImage("https://picsum.photos/300/400?random=3"),
                  _buildImage("https://picsum.photos/300/400?random=4"),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // App navigation buttons
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Navigating to Create Event...'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CreateEventPage()),
                  );
                },
                icon: const Icon(
                  Icons.event,
                  color: Colors.white,
                  size: 24,
                ),
                label: const Text(
                  "Create Event",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Loading all events...'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const EventsPage()),
                  );
                },
                icon: const Icon(Icons.event_available, color: Colors.white),
                label: const Text(
                  "View All Events",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Opening your profile...'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfilePage()),
                  );
                },
                icon: const Icon(Icons.person, color: Colors.white),
                label: const Text(
                  "View Profile",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Authentication button (for future use)
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: Colors.orange),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Authentication'),
                        content: const Text('Authentication features will be available soon!\n\nFor now, you can explore the app features above.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.login, color: Colors.orange),
                label: const Text(
                  "Sign In / Sign Up",
                  style: TextStyle(fontSize: 16, color: Colors.orange),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Welcome to CrewCall!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Connect with talent and organize amazing events',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String url) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
      ),
    );
  }
}


