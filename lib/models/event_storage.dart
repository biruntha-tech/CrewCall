class EventStorage {
  static final EventStorage _instance = EventStorage._internal();
  factory EventStorage() => _instance;
  EventStorage._internal();

  final List<Map<String, dynamic>> _createdEvents = [];
  final List<Map<String, dynamic>> _reservedEvents = [];

  List<Map<String, dynamic>> get createdEvents => List.unmodifiable(_createdEvents);
  List<Map<String, dynamic>> get reservedEvents => List.unmodifiable(_reservedEvents);

  void addCreatedEvent(Map<String, dynamic> event) {
    _createdEvents.add(event);
  }

  void addReservedEvent(Map<String, dynamic> event) {
    if (!_reservedEvents.any((e) => e["title"] == event["title"])) {
      _reservedEvents.add(event);
    }
  }

  void removeReservedEvent(Map<String, dynamic> event) {
    _reservedEvents.removeWhere((e) => e["title"] == event["title"]);
  }

  List<Map<String, dynamic>> getAllEvents() {
    final defaultEvents = [
      {
        "title": "Summer Music Festival",
        "date": "July 15, 2024",
        "location": "Central Park, NYC",
        "organizer": "Music Events Co.",
        "image": "https://images.unsplash.com/photo-1459749411175-04bf5292ceea?w=300&h=200&fit=crop",
        "status": "Open",
        "participants": "25/50",
        "participantList": ["Alice Johnson", "Bob Smith", "Carol Davis", "David Wilson", "Emma Brown"],
      },
      {
        "title": "Jazz Night Live",
        "date": "July 20, 2024",
        "location": "Blue Note Club",
        "organizer": "Jazz Productions",
        "image": "https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=300&h=200&fit=crop",
        "status": "Almost Full",
        "participants": "18/20",
        "participantList": ["Frank Miller", "Grace Lee", "Henry Taylor", "Ivy Chen"],
      },
      {
        "title": "Rock Concert Series",
        "date": "August 5, 2024",
        "location": "Madison Square Garden",
        "organizer": "Rock Events LLC",
        "image": "https://images.unsplash.com/photo-1501386761578-eac5c94b800a?w=300&h=200&fit=crop",
        "status": "Open",
        "participants": "12/100",
        "participantList": [],
      },
      {
        "title": "Acoustic Evening",
        "date": "July 25, 2024",
        "location": "Coffee House Downtown",
        "organizer": "Indie Music Group",
        "image": "https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?w=300&h=200&fit=crop",
        "status": "New",
        "participants": "5/15",
        "participantList": [],
      },
      {
        "title": "Electronic Dance Party",
        "date": "August 10, 2024",
        "location": "Warehouse District",
        "organizer": "EDM Collective",
        "image": "https://images.unsplash.com/photo-1470229722913-7c0e2dbbafd3?w=300&h=200&fit=crop",
        "status": "Open",
        "participants": "30/80",
        "participantList": [],
      },
    ];
    
    return [...defaultEvents, ..._createdEvents];
  }
}