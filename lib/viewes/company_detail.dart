import 'package:apkgawee/viewes/job.dart';
import 'package:flutter/material.dart';

class CompanyDetailPage extends StatefulWidget {
  const CompanyDetailPage({super.key});

  @override
  State<CompanyDetailPage> createState() => _CompanyDetailPageState();
}

class _CompanyDetailPageState extends State<CompanyDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF8E44AD);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            // HEADER
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 230,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://images.unsplash.com/photo-1519389950473-47ba0277781c",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _iconButton(Icons.arrow_back, () {
                          Navigator.pop(context);
                        }),
                        const Text(
                          "Software Engineer",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        _iconButton(Icons.more_vert, () {}),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: -40,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 6,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child:
                      const Icon(Icons.work, color: Colors.white, size: 40),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),

            // INFO
            const Text(
              "Software Engineer",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text("Medan, Indonesia",
                style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const JobDetailPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 3,
                  shadowColor: Colors.grey.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("21 Available Jobs",
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.w600)),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward_ios,
                        size: 16, color: primaryColor),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // TABS
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  TabBar(
                    controller: tabController,
                    labelColor: primaryColor,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: primaryColor,
                    labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                    tabs: const [
                      Tab(text: "ABOUT US"),
                      Tab(text: "RATINGS"),
                      Tab(text: "REVIEW"),
                    ],
                  ),
                  SizedBox(
                    height: 500,
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        _aboutUsTab(),
                        _ratingsTab(),
                        _reviewTab(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _iconButton(IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }

  // ABOUT US
  Widget _aboutUsTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            style: TextStyle(fontSize: 14, height: 1.5),
          ),
          SizedBox(height: 16),
          Text("Requirements",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 8),
          Text(
            "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
            style: TextStyle(fontSize: 14, height: 1.5),
          ),
          SizedBox(height: 8),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.circle, size: 10, color: Color(0xFF8E44AD)),
            title: Text("Sed ut perspiciatis unde omnis",
                style: TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }

  // RATINGS TAB
  Widget _ratingsTab() {
    const primaryColor = Color(0xFF8E44AD);
    const barColor = Colors.orange;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Ratings Bars",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black87)),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("4.0",
                    style:
                    TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    children: [
                      _ratingBar("5", 0.9),
                      _ratingBar("4", 0.75),
                      _ratingBar("3", 0.5),
                      _ratingBar("2", 0.3),
                      _ratingBar("1", 0.15),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: const [
                Icon(Icons.star, color: barColor, size: 20),
                Icon(Icons.star, color: barColor, size: 20),
                Icon(Icons.star, color: barColor, size: 20),
                Icon(Icons.star, color: barColor, size: 20),
                Icon(Icons.star_border, color: barColor, size: 20),
                SizedBox(width: 8),
                Text("78,320", style: TextStyle(color: Colors.black54)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _ratingBar(String label, double percent) {
    return Row(
      children: [
        Text(label),
        const SizedBox(width: 8),
        Expanded(
          child: LinearProgressIndicator(
            value: percent,
            color: Colors.orange,
            backgroundColor: Colors.orange.withOpacity(0.2),
            borderRadius: BorderRadius.circular(4),
            minHeight: 6,
          ),
        ),
      ],
    );
  }

  // REVIEW TAB
  Widget _reviewTab() {
    const barColor = Colors.orange;

    final List<Map<String, dynamic>> reviews = [
      {
        "name": "James Logan",
        "date": "27 August 2020",
        "comment":
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla sagittis tellus ut...",
        "rating": 4,
        "image": "https://randomuser.me/api/portraits/men/32.jpg",
      },
      {
        "name": "Leo Tucker",
        "date": "15 June 2020",
        "comment":
        "Phasellus vel felis tellus. Mauris rutrum ligula nec dapibus feugiat. In vel dui...",
        "rating": 4,
        "image": "https://randomuser.me/api/portraits/men/41.jpg",
      },
      {
        "name": "Oscar Weston",
        "date": "07 June 2020",
        "comment":
        "Mauris rutrum ligula nec dapibus feugiat. In vel dui laoreet, commodo augue id...",
        "rating": 5,
        "image": "https://randomuser.me/api/portraits/women/55.jpg",
      },
      {
        "name": "Yellow Submarine",
        "date": "27 May 2020",
        "comment":
        "Nulla sagittis tellus ut turpis condimentum, ut dignissim lacus...",
        "rating": 4,
        "image": "https://randomuser.me/api/portraits/women/22.jpg",
      },
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: reviews.length,
      separatorBuilder: (_, __) =>
          Divider(color: Colors.grey[300], thickness: 1, height: 20),
      itemBuilder: (context, index) {
        final r = reviews[index];
        final rating = (r["rating"] is int)
            ? r["rating"] as int
            : int.tryParse(r["rating"].toString()) ?? 0;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: r["image"] != null
                  ? NetworkImage(r["image"].toString())
                  : null,
              radius: 25,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    r["name"]?.toString() ?? "",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    r["date"]?.toString() ?? "",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: List.generate(
                      5,
                          (i) => Icon(
                        i < rating ? Icons.star : Icons.star_border,
                        color: barColor,
                        size: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    r["comment"]?.toString() ?? "",
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
