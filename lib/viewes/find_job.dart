import 'package:apkgawee/viewes/company_list.dart';
import 'package:apkgawee/viewes/constraint.dart';
import 'package:apkgawee/viewes/resume.dart';
import 'package:flutter/material.dart';


const Color appPrimaryColor = Color(0xFF884DF4);
const Color appBackgroundColor = Color(0xFFF7F4FA);

class JobSearchScreen extends StatefulWidget {
  const JobSearchScreen({super.key});

  @override
  State<JobSearchScreen> createState() => _JobSearchScreenState();
}

class _JobSearchScreenState extends State<JobSearchScreen> {
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  @override
  void dispose() {
    _jobTitleController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  // --- Widget Pembantu ---

  Widget _buildSearchSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Input 1: Job Title
          TextField(
            controller: _jobTitleController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              hintText: 'job title, keywords, or company',
            ),
          ),
          const SizedBox(height: 10),

          // Input 2: City/Location
          TextField(
            controller: _cityController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.location_on_outlined, color: Colors.grey),
              hintText: 'Enter city or locality',
            ),
          ),
          const SizedBox(height: 20),

          // Tombol Search: Navigasi ke CompanyListScreen
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Navigasi ke halaman Company List
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CompanyListScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                'SEARCH',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularSearches() {
    final List<String> popular = [
      'Software developer fresher', 'Worker From Home', 'Driver',
      'hr frsher', 'softwere testing', 'seles executive',
      'business analyst', 'receptionist', 'data analyst', 'seo executive',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Popular Searches',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: popular.map((text) {
              return Chip(
                avatar: const Icon(Icons.search, size: 18, color: Colors.black),
                label: Text(text, style: const TextStyle(color: Colors.black54)),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide.none,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildCreateResumeLink() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const UploadResumeScreen()),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Create Your Resume',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 18, color: Colors.black54),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Find Job'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: ListView(
        children: [
          _buildSearchSection(),
          _buildPopularSearches(),
          _buildCreateResumeLink(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}