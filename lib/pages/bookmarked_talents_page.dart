import 'package:flutter/material.dart';
import 'package:crewcall_flutter/theme/app_theme.dart';
import 'package:crewcall_flutter/pages/talent_detail_page.dart';
import 'package:crewcall_flutter/pages/Homepage.dart';

class BookmarkedTalentsPage extends StatefulWidget {
  const BookmarkedTalentsPage({super.key});

  @override
  State<BookmarkedTalentsPage> createState() => _BookmarkedTalentsPageState();
}

class _BookmarkedTalentsPageState extends State<BookmarkedTalentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookmarked Talents"),
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
          child: globalBookmarkedTalents.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.bookmark_border, size: 80, color: Colors.grey),
                      SizedBox(height: 20),
                      Text(
                        "No Bookmarked Talents",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Book talents to see them here",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: globalBookmarkedTalents.length,
                  itemBuilder: (context, index) {
                    final talent = globalBookmarkedTalents[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 28,
                          backgroundImage: NetworkImage(talent["image"]!),
                        ),
                        title: Text(
                          talent["name"]!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(talent["bio"]!),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.bookmark,
                            color: Colors.orange,
                          ),
                          onPressed: () {
                            setState(() {
                              globalBookmarkedTalents.removeAt(index);
                            });
                          },
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TalentDetailPage(talent: talent),
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
