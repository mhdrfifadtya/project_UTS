import 'package:apkgawee/viewes/chat_room.dart';
import 'package:flutter/material.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final List<Map<String, dynamic>> messages = [
    {
      'name': 'Sam Verdinand',
      'message': 'OK. Lorem ipsum dolor sect...',
      'status': 'Read',
      'image': 'https://i.pravatar.cc/150?img=1'
    },
    {
      'name': 'Freddie Ronan',
      'message': 'Roger that sir, thankyou',
      'status': 'Pending',
      'image': 'https://i.pravatar.cc/150?img=2'
    },
    {
      'name': 'Ethan Jacoby',
      'message': 'Lorem ipsum dolor',
      'status': 'Read',
      'image': 'https://i.pravatar.cc/150?img=3'
    },
    {
      'name': 'Alfie Mason',
      'message': 'Lorem ipsum dolor sect...',
      'status': 'Pending',
      'image': 'https://i.pravatar.cc/150?img=4'
    },
    {
      'name': 'Archie Parker',
      'message': 'OK. Lorem ipsum dolor sect...',
      'status': 'Pending',
      'image': 'https://i.pravatar.cc/150?img=5'
    },
  ];

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
          'Messages',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(Icons.more_vert, color: Colors.black),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                hintText: 'Search job here...',
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final m = messages[index];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ChatRoomPage(name: m['name'], image: m['image']),
                      ),
                    );
                  },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(m['image']),
                    radius: 25,
                  ),
                  title: Text(
                    m['name'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(m['message']),
                  trailing: Text(
                    m['status'],
                    style: TextStyle(
                      color: m['status'] == 'Read'
                          ? Colors.purple
                          : Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
