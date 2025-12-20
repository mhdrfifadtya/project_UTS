import 'package:apkgawee/viewes/constraint.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.more_vert, color: Colors.black),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Foto profil
              CircleAvatar(
                radius: 50,
                backgroundImage: const NetworkImage(
                  'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e',
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Richard Brownlee',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                'Engineer',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 12),
              const Text(
                'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(height: 20),

              // Tombol Resume
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF8E24AA),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: kPrimaryColor.withOpacity(0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ListTile(
                  title: const Text(
                    'My Resume',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: const Text(
                    'david_resume.pdf',
                    style: TextStyle(color: Colors.white70),
                  ),
                  trailing: const Icon(Icons.file_download, color: Colors.white),
                  onTap: () {},
                ),
              ),

              const SizedBox(height: 24),

              // Skill Section
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Skills',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 12),
              buildSkillBar('Problem Solving', 0.7),
              buildSkillBar('Drawing', 0.35),
              buildSkillBar('Illustration', 0.8),
              buildSkillBar('Photoshop', 0.34),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSkillBar(String skill, double percent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(skill, style: const TextStyle(fontWeight: FontWeight.w500)),
              Text('${(percent * 100).round()}%',
                  style: const TextStyle(color: Colors.black54)),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: percent,
              minHeight: 6,
              backgroundColor: Colors.grey.shade300,
              valueColor:
              const AlwaysStoppedAnimation<Color>(Color(0xFF8E24AA)),
            ),
          ),
        ],
      ),
    );
  }
}
