import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:crewcall_flutter/theme/app_theme.dart';
import 'package:crewcall_flutter/pages/Homepage.dart';

class TalentDetailPage extends StatefulWidget {
  final Map<String, String> talent;

  const TalentDetailPage({super.key, required this.talent});

  @override
  State<TalentDetailPage> createState() => _TalentDetailPageState();
}

class _TalentDetailPageState extends State<TalentDetailPage> {
  String? selectedTime;
  String? selectedDuration = '4h';
  String? selectedCompensation = 'Unpaid';
  DateTime? selectedDate;

  final TextEditingController locationController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  // Sample events for review
  final List<String> events = [
    'Summer Music Festival',
    'Jazz Night Live',
    'Rock Concert Series',
    'Acoustic Evening',
    'Electronic Dance Party',
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _showReviewDialog() {
    int? selectedRating;
    String? selectedEvent;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 8,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Review ${widget.talent["name"]}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // Rating Dropdown
                    const Text(
                      'Rating',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<int>(
                      value: selectedRating,
                      hint: const Text('Select rating (1-5)'),
                      items: [1, 2, 3, 4, 5]
                          .map((rating) => DropdownMenuItem(
                                value: rating,
                                child: Row(
                                  children: [
                                    ...List.generate(
                                      rating,
                                      (index) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 20,
                                      ),
                                    ),
                                    ...List.generate(
                                      5 - rating,
                                      (index) => const Icon(
                                        Icons.star_border,
                                        color: Colors.grey,
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text('$rating'),
                                  ],
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setDialogState(() {
                          selectedRating = value;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Event Dropdown
                    const Text(
                      'Event',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: selectedEvent,
                      hint: const Text('Select event'),
                      items: events
                          .map((event) => DropdownMenuItem(
                                value: event,
                                child: Text(event),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setDialogState(() {
                          selectedEvent = value;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Cancel'),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: selectedRating != null && selectedEvent != null
                              ? () {
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Review submitted: $selectedRating stars for $selectedEvent',
                                      ),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                }
                              : null,
                          child: const Text('Submit'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: AppColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(widget.talent["image"]!, fit: BoxFit.cover),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.talent["name"]!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.talent["bio"]!,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Section
                    const Text(
                      "About",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Experienced ${widget.talent["bio"]!.split('•')[0].trim()} with expertise in live performances and event management. Available for bookings across various venues and event types.",
                      style: TextStyle(color: Colors.grey[700], fontSize: 14),
                    ),
                    const SizedBox(height: 20),

                    // Skills Section
                    const Text(
                      "Skills",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children:
                          [
                                'Performance',
                                'Live Music',
                                'Event Management',
                                'Stage Presence',
                              ]
                              .map(
                                (skill) => Chip(
                                  label: Text(skill),
                                  backgroundColor: AppColors.unselectedChip,
                                ),
                              )
                              .toList(),
                    ),
                    const SizedBox(height: 24),

                    // Booking Section
                    const Text(
                      "Book Now",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // DATE SELECTOR
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Date",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: () => _selectDate(context),
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              selectedDate == null
                                  ? "Select a date"
                                  : DateFormat(
                                      'dd MMM yyyy',
                                    ).format(selectedDate!),
                              style: TextStyle(
                                color: selectedDate == null
                                    ? Colors.blueGrey.shade600
                                    : Colors.black87,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // TIME
                    buildDropdown(
                      label: "Time",
                      value: selectedTime,
                      items: const ['10:00 AM', '2:00 PM', '6:00 PM'],
                      onChanged: (v) => setState(() => selectedTime = v),
                    ),
                    const SizedBox(height: 16),

                    // DURATION
                    buildDropdown(
                      label: "Duration",
                      value: selectedDuration,
                      items: const ['1h', '2h', '3h', '4h', '5h'],
                      onChanged: (v) => setState(() => selectedDuration = v),
                    ),
                    const SizedBox(height: 16),

                    // COMPENSATION
                    buildDropdown(
                      label: "Compensation",
                      value: selectedCompensation,
                      items: const ['Unpaid', 'Paid'],
                      onChanged: (v) =>
                          setState(() => selectedCompensation = v),
                    ),
                    const SizedBox(height: 16),

                    // LOCATION
                    buildTextField(
                      label: "Location",
                      hint: "Address or venue",
                      controller: locationController,
                    ),
                    const SizedBox(height: 16),

                    // NOTES
                    buildTextField(
                      label: "Notes",
                      hint: "Optional details for this booking",
                      controller: notesController,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 24),

                    // CONFIRM BOOKING BUTTON
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () {
                          // Add to bookmarked talents if not already bookmarked
                          if (!globalBookmarkedTalents.any(
                            (t) => t["name"] == widget.talent["name"],
                          )) {
                            globalBookmarkedTalents.add(widget.talent);
                          }

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Booking confirmed for ${widget.talent["name"]} and added to bookmarks',
                              ),
                              backgroundColor: AppColors.primary,
                            ),
                          );
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Confirm booking",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    // REVIEW TALENT BUTTON
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          side: BorderSide(color: AppColors.primary),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: _showReviewDialog,
                        child: const Text(
                          "Review Talent",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          items: items
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }
}
