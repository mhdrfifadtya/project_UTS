import 'package:flutter/material.dart';
import 'package:apkgawee/services/job_service.dart';
import 'package:apkgawee/services/auth_service.dart';
import 'package:apkgawee/models/job_model.dart';

// Import halaman lain (Pastikan path sesuai project Anda)
import 'welcome.dart';
import 'company_detail.dart';
import 'job.dart';
import 'recent.dart';
import 'find_job.dart';
import 'messages.dart';
import 'notification.dart';
import 'profile.dart';
import 'elements.dart';
import 'setting.dart';

// ================= CONSTANT =================
const double kDefaultPadding = 20.0;
const Color kPrimaryColor = Color.fromARGB(255, 175, 45, 189);
const Color kLightPurple = Color(0xFFE9E0F8);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // --- STATE UI ---
  bool _isDarkMode = false;
  
  // --- STATE API ---
  bool loadingJobs = true;
  List<Job> jobs = [];

  // Variabel warna manual untuk mempercantik UI (karena API tidak mengirim warna)
  final List<Color> _jobColors = const [
    Color(0xFF8E44AD), // Ungu
    Color(0xFF27AE60), // Hijau
    Color(0xFFE67E22), // Orange
    Color(0xFF2980B9), // Biru
  ];

  @override
  void initState() {
    super.initState();
    _loadJobs();
  }

  Future<void> _loadJobs() async {
    try {
      final result = await JobService.fetchJobs();
      if (mounted) {
        setState(() {
          jobs = result;
          loadingJobs = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => loadingJobs = false);
      }
      debugPrint("Error fetching jobs: $e");
    }
  }

  Future<void> _logout() async {
    await AuthService.logout();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const WelcomePage()),
    );
  }

  void _go(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  // Helper untuk mendapatkan warna berdasarkan index
  Color _getJobColor(int index) {
    return _jobColors[index % _jobColors.length];
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = _isDarkMode ? const Color(0xFF121212) : kLightPurple;
    final cardColor = _isDarkMode ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = _isDarkMode ? Colors.white : Colors.black87;
    final primaryColor = kPrimaryColor;

    return Scaffold(
      backgroundColor: bgColor,

      // ================= DRAWER =================
      drawer: Drawer(
        backgroundColor: cardColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: primaryColor),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.work_outline, color: Colors.white, size: 40),
                  SizedBox(height: 10),
                  Text(
                    'Gawee Job Portal',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            _drawerItem(Icons.home, 'Home', () => Navigator.pop(context), textColor),
            _drawerItem(Icons.access_time, 'Recent Job', () => _go(const RecentJobPage()), textColor),
            _drawerItem(Icons.search, 'Find Job', () => _go(const JobSearchScreen()), textColor),
            _drawerItem(Icons.notifications, 'Notifications', () => _go(const NotificationsPage()), textColor),
            _drawerItem(Icons.person, 'Profile', () => _go(const ProfilePage()), textColor),
            _drawerItem(Icons.mail, 'Messages', () => _go(const MessagesPage()), textColor),
            _drawerItem(Icons.grid_view, 'Elements', () => _go(const ElementsPage()), textColor),
            _drawerItem(Icons.settings, 'Setting', () => _go(const ColorThemesPage()), textColor),
            const Divider(),
            _drawerItem(Icons.logout, 'Logout', _logout, primaryColor),
          ],
        ),
      ),

      // ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
        actions: [
          IconButton(
            icon: Icon(
              _isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
              color: textColor,
            ),
            onPressed: () => setState(() => _isDarkMode = !_isDarkMode),
          ),
        ],
      ),

      // ================= BODY =================
      body: loadingJobs
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),

                  // HEADER
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hello',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: textColor.withOpacity(0.7))),
                          Text(
                            'Richard Brownlee',
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: textColor),
                          ),
                        ],
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () => _go(const ProfilePage()),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: primaryColor,
                          child: const Icon(Icons.person,
                              color: Colors.white, size: 40),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // SEARCH BAR
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(_isDarkMode ? 0 : 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      style: TextStyle(color: textColor),
                      decoration: InputDecoration(
                        hintText: 'Search job here...',
                        hintStyle: TextStyle(color: textColor.withOpacity(0.5)),
                        border: InputBorder.none,
                        suffixIcon: Icon(Icons.search,
                            color: textColor.withOpacity(0.7)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // BANNER
                  Container(
                    padding: const EdgeInsets.all(kDefaultPadding),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(15),
                      image: const DecorationImage(
                        image: NetworkImage("https://img.freepik.com/free-vector/gradient-dynamic-purple-lines-background_23-2148995757.jpg"), // Optional background pattern
                        fit: BoxFit.cover,
                        opacity: 0.2,
                      )
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Recommended Jobs',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'See recommendations based on your skills',
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: const Icon(Icons.star, size: 30, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // STATISTIK
                  Row(
                    children: [
                      Expanded(child: _buildStatCard('45', 'Jobs Applied', cardColor, textColor, primaryColor)),
                      const SizedBox(width: 15),
                      Expanded(child: _buildStatCard('28', 'Interviews', cardColor, textColor, primaryColor)),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // KATEGORI
                  Text(
                    'Job Categories',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textColor),
                  ),
                  const SizedBox(height: 15),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildCategoryButton('Designer', const Color(0xFF1B42A3)),
                        _buildCategoryButton('Manager', const Color(0xFF1E8449)),
                        _buildCategoryButton('Programmer', const Color(0xFFB8860B)),
                        _buildCategoryButton('UX/UI', const Color(0xFF8E44AD)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // FEATURED JOBS (Horizontal List)
                  Text(
                    'Featured Jobs',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textColor),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 210, 
                    child: jobs.isEmpty 
                    ? _buildEmptyState(textColor)
                    : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: jobs.length,
                      itemBuilder: (context, index) {
                        final job = jobs[index];
                        final color = _getJobColor(index);
                        return _buildFeaturedJobCard(job, cardColor, textColor, primaryColor, color);
                      },
                    ),
                  ),
                  const SizedBox(height: 30),

                  // RECENT JOBS (Vertical List)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent Jobs List',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textColor),
                      ),
                      Text(
                        'See all',
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  
                  jobs.isEmpty 
                  ? _buildEmptyState(textColor)
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: jobs.length,
                      itemBuilder: (context, index) {
                        final job = jobs[index];
                        final color = _getJobColor(index);
                        return _buildRecentJobItem(job, cardColor, textColor, primaryColor, color);
                      },
                    ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }

  // ================= WIDGET HELPER =================

  Widget _buildEmptyState(Color textColor) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text("No jobs available right now", style: TextStyle(color: textColor.withOpacity(0.5))),
      ),
    );
  }

  Widget _drawerItem(
      IconData icon, String title, VoidCallback onTap, Color color) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(color: color)),
      onTap: onTap,
    );
  }

  Widget _buildStatCard(String value, String label, Color bg, Color txt, Color prim) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: prim),
          ),
          const SizedBox(height: 5),
          Text(label, style: TextStyle(color: txt.withOpacity(0.6), fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(String label, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
    );
  }

  // --- KARTU FEATURED JOB YANG DIPERBAIKI ---
  Widget _buildFeaturedJobCard(
      Job job, Color bg, Color txt, Color prim, Color iconBg) {
    return GestureDetector(
      onTap: () => _go(const CompanyDetailPage()),
      child: Container(
        width: 260, // Lebar fixed agar rapi
        margin: const EdgeInsets.only(right: 15, bottom: 10), // Margin bottom untuk bayangan
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Bagian Atas: Icon dan Perusahaan
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: iconBg.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.business, color: iconBg, size: 26),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.company, 
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: txt),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis, // Mencegah teks kepanjangan
                      ),
                      const SizedBox(height: 2),
                      Text(
                        job.location,
                        style: TextStyle(color: txt.withOpacity(0.5), fontSize: 12),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            // Bagian Tengah: Judul Job
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                job.title,
                style: TextStyle(
                    fontSize: 17, fontWeight: FontWeight.bold, color: txt),
                maxLines: 2, // Batasi 2 baris agar layout tidak rusak
                overflow: TextOverflow.ellipsis,
              ),
            ),
            
            // Bagian Bawah: Gaji
            Row(
              children: [
                Expanded(
                  child: Text(
                    job.salary,
                    style: TextStyle(color: prim, fontWeight: FontWeight.w700, fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(Icons.arrow_forward_rounded, size: 20, color: Colors.grey)
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --- ITEM RECENT JOB YANG DIPERBAIKI ---
  Widget _buildRecentJobItem(
      Job job, Color bg, Color txt, Color prim, Color iconBg) {
    return GestureDetector(
      onTap: () => _go(const JobDetailPage()),
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: iconBg.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.work, color: iconBg, size: 24),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job.title,
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold, color: txt),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 14, color: txt.withOpacity(0.5)),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          "${job.company} • ${job.location}",
                          style: TextStyle(color: txt.withOpacity(0.5), fontSize: 13),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Tombol View kecil agar rapi
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: prim.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text("View", style: TextStyle(color: prim, fontWeight: FontWeight.bold, fontSize: 12)),
            )
          ],
        ),
      ),
    );
  }
}