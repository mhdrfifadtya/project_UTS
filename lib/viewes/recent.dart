import 'package:apkgawee/viewes/job.dart';
import 'package:flutter/material.dart';

class RecentJobPage extends StatefulWidget {
  const RecentJobPage({super.key});

  @override
  State<RecentJobPage> createState() => _RecentJobPageState();
}

class _RecentJobPageState extends State<RecentJobPage> {
  final List<Map<String, dynamic>> jobs = [
    {
      "title": "Junior Software Engineer",
      "location": "Medan, Indonesia",
      "salary": "\$500 - \$1,000",
      "color": Color(0xFF8E44AD),
    },
    {
      "title": "Software Engineer",
      "location": "Medan, Indonesia",
      "salary": "\$500 - \$1,000",
      "color": Color(0xFF9B59B6),
    },
    {
      "title": "Graphic Designer",
      "location": "Medan, Indonesia",
      "salary": "\$500 - \$1,000",
      "color": Color(0xFF27AE60),
    },
    {
      "title": "Software Engineer",
      "location": "Medan, Indonesia",
      "salary": "\$500 - \$1,000",
      "color": Color(0xFF16A085),
    },
    {
      "title": "Software Engineer",
      "location": "Medan, Indonesia",
      "salary": "\$500 - \$1,000",
      "color": Color(0xFF9B59B6),
    },
    {
      "title": "Graphic Designer",
      "location": "Medan, Indonesia",
      "salary": "\$500 - \$1,000",
      "color": Color(0xFF27AE60),
    },
  ];

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF8E44AD);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1E6FF),
        elevation: 0,
        title: const Text(
          "Recent Job",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.more_vert, color: Colors.black87),
          ),
        ],
      ),

      body: Column(
        children: [
          Container(
            color: const Color(0xFFF1E6FF),
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search job here...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Daftar pekerjaan
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: jobs.length,
              itemBuilder: (context, index) {
                final job = jobs[index];
                return GestureDetector(
                  onTap: () {
                    // Navigasi ke halaman detail perusahaan
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const JobDetailPage(),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: job["color"].withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.work,
                            color: job["color"],
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                job["title"],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                job["location"],
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                job["salary"],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.bookmark_border,
                            color: Colors.grey, size: 22),
                      ],
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
