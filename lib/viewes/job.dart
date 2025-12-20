import 'package:flutter/material.dart';

class JobDetailPage extends StatefulWidget {
  const JobDetailPage({super.key});

  @override
  State<JobDetailPage> createState() => _JobDetailPageState();
}

class _JobDetailPageState extends State<JobDetailPage> {
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenPadding = screenWidth * 0.05;

    return Scaffold(
      backgroundColor: const Color(0xFFF5EEFC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: screenPadding, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: const Color(0xFFEDE3FA),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.business, color: Colors.deepPurple, size: 32),
                  const SizedBox(width: 8),
                  const Text(
                    'Cosax Studios',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  const Icon(Icons.more_vert, color: Colors.black54),
                ],
              ),
              const SizedBox(height: 20),

              // JOB TYPE BUTTONS
              Row(
                children: [
                  _buildJobTypeButton('FULLTIME'),
                  const SizedBox(width: 10),
                  _buildJobTypeButton('CONTRACT'),
                ],
              ),
              const SizedBox(height: 20),

              // JOB TITLE & LOCATION
              const Text(
                'Software Engineer',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 4),
              const Text(
                'Medan, Indonesia',
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 20),

              // SALARY RANGE
              Row(
                children: const [
                  Text(
                    '\$500 - \$1,000',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Salary range (monthly)',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              const Divider(height: 30, color: Colors.grey),

              // TAB SECTION
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildTab('Job Description', 0),
                  const SizedBox(width: 30),
                  _buildTab('Our Gallery', 1),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                height: 2,
                width: selectedTabIndex == 0 ? 160 : 110,
                color: Colors.deepPurple,
              ),
              const SizedBox(height: 20),

              // JOB DESCRIPTION
              const Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                style: TextStyle(color: Colors.black87, height: 1.5),
              ),
              const SizedBox(height: 20),

              // REQUIREMENTS
              const Text(
                "Requirements",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in.",
                style: TextStyle(color: Colors.black87, height: 1.5),
              ),
              const SizedBox(height: 10),

              _buildRequirement("Sed ut perspiciatis unde omnis"),
              _buildRequirement("Doloremque laudantium"),
              _buildRequirement("Ipsa quae ab illo inventore"),
              _buildRequirement("Architecto beatae vitae dicta"),
              _buildRequirement("Sunt explicabo"),

              const SizedBox(height: 30),

              // APPLY BUTTON
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.deepPurple.shade200),
                      ),
                      child: const Icon(Icons.bookmark_border,
                          color: Colors.deepPurple),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 3,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        "APPLY JOB",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(String title, int index) {
    final isSelected = selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTabIndex = index;
        });
      },
      child: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.deepPurple : Colors.grey,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildJobTypeButton(String title) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.deepPurple,
        side: const BorderSide(color: Colors.deepPurple),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      onPressed: () {},
      child: Text(title),
    );
  }

  Widget _buildRequirement(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.deepPurple, size: 20),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
