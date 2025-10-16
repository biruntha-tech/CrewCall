import 'package:flutter/material.dart';
import 'package:crewcall_flutter/theme/app_theme.dart';
import 'package:crewcall_flutter/pages/event_detail_page.dart';

class EventHistoryPage extends StatefulWidget {
  final List<Map<String, dynamic>> participatedEvents;

  const EventHistoryPage({super.key, required this.participatedEvents});

  @override
  State<EventHistoryPage> createState() => _EventHistoryPageState();
}

class _EventHistoryPageState extends State<EventHistoryPage> {
  late List<Map<String, dynamic>> events;

  @override
  void initState() {
    super.initState();
    events = List.from(widget.participatedEvents);
  }

  void _removeEvent(Map<String, dynamic> event) {
    setState(() {
      events.removeWhere((e) => e["title"] == event["title"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event History"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: events.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.history, size: 80, color: Colors.grey),
                      SizedBox(height: 20),
                      Text(
                        "No Event History",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Your participated events will appear here",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            event["image"]!,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          event["title"]!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("📅 ${event["date"]!}"),
                            Text("📍 ${event["location"]!}"),
                          ],
                        ),
                        trailing: const Icon(Icons.check_circle, color: Colors.green),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EventDetailPage(
                                event: event,
                                onDisjoin: _removeEvent,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}