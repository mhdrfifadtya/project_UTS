import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class ChatRoomPage extends StatefulWidget {
  final String name;
  final String image;

  const ChatRoomPage({super.key, required this.name, required this.image});

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> messages = [];
  bool isTyping = false;

  final List<String> autoReplies = [
    "Sure thing!",
    "Let me check that for you.",
    "Got it!",
    "Haha, that's great!",
    "Sounds awesome!",
    "I’ll get back to you soon.",
  ];

  @override
  void initState() {
    super.initState();

    // Tambahkan pesan awal agar room terlihat ramai
    messages.addAll([
      {'sender': widget.name, 'text': "Hey there! How’s it going?"},
      {'sender': 'You', 'text': "Hi! Everything’s good, how about you?"},
      {'sender': widget.name, 'text': "I’m doing great, thanks for asking!"},
      {'sender': 'You', 'text': "Been busy lately?"},
      {'sender': widget.name, 'text': "Yeah, kinda. Lots of projects."},
      {'sender': 'You', 'text': "Same here. Flutter assignments everywhere 😅"},
      {'sender': widget.name, 'text': "Haha, I feel you!"},
    ]);
  }

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      messages.add({'sender': 'You', 'text': text});
    });
    _controller.clear();
    _simulateReply();
  }

  void _simulateReply() {
    setState(() => isTyping = true);

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      final randomReply = autoReplies[Random().nextInt(autoReplies.length)];
      setState(() {
        isTyping = false;
        messages.add({'sender': widget.name, 'text': randomReply});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3EFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEAF3FF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.name,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                final isUser = msg['sender'] == 'You';
                return Align(
                  alignment: isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue : Colors.grey[700],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      msg['text'],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          if (isTyping)
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.image),
                    radius: 14,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "is typing",
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(width: 6),
                  const AnimatedTypingBubbles(),
                ],
              ),
            ),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              color: Colors.white.withOpacity(0.7),
              child: Row(
                children: [
                  const Icon(Icons.camera_alt, color: Colors.black54),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: "Message",
                        border: InputBorder.none,
                      ),
                      onSubmitted: sendMessage,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.grey),
                    onPressed: () => sendMessage(_controller.text),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedTypingBubbles extends StatefulWidget {
  const AnimatedTypingBubbles({super.key});

  @override
  State<AnimatedTypingBubbles> createState() => _AnimatedTypingBubblesState();
}

class _AnimatedTypingBubblesState extends State<AnimatedTypingBubbles>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(3, (index) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (_, __) {
            double value =
            sin((_controller.value * 2 * pi) + (index * pi / 3));
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              width: 6,
              height: 6 + (value * 3),
              decoration: const BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
            );
          },
        );
      }),
    );
  }
}