import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  // ✅ Data notifikasi
  final List<Map<String, dynamic>> notifications = [
    {
      'title': 'Apply Success',
      'subtitle': 'You has apply an job in Queenify Group as UI Designer',
      'time': '10h ago',
      'color': Colors.teal,
      'read': false,
    },
    {
      'title': 'Interview Calls',
      'subtitle': 'Congratulations! You have interview calls',
      'time': '9h ago',
      'color': Colors.grey,
      'read': false,
    },
    {
      'title': 'Apply Success',
      'subtitle': 'You has apply an job in Queenify Group as UI Designer',
      'time': '8h ago',
      'color': Colors.purple,
      'read': false,
    },
    {
      'title': 'Complete your profile',
      'subtitle':
      'Please verify your profile information to continue using this app',
      'time': '7h ago',
      'color': Colors.teal,
      'read': false,
    },
  ];

  // ✅ Fungsi untuk menandai notifikasi sudah dibaca
  void markAsRead(int index) {
    setState(() {
      notifications[index]['read'] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3EFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF3EFFF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // ← kembali ke halaman sebelumnya
          },
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(Icons.more_vert, color: Colors.black),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final n = notifications[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: n['color'] as Color,
                radius: 6,
              ),
              title: Text(
                n['title'] ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(n['subtitle'] ?? ''),
              ),
              trailing: GestureDetector(
                onTap: () => markAsRead(index),
                child: Text(
                  n['read'] ? 'Read' : 'Mark as read',
                  style: TextStyle(
                    color: n['read'] ? Colors.grey : Colors.purple,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            ),
          );
        },
      ),
    );
  }
}
