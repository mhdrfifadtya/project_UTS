import 'package:apkgawee/viewes/company_detail.dart';
import 'package:apkgawee/viewes/elements.dart';
import 'package:apkgawee/viewes/find_job.dart';
import 'package:apkgawee/viewes/job.dart';
import 'package:apkgawee/viewes/messages.dart';
import 'package:apkgawee/viewes/notification.dart';
import 'package:apkgawee/viewes/profile.dart';
import 'package:apkgawee/viewes/recent.dart' ;
import 'package:apkgawee/viewes/setting.dart';
import 'package:apkgawee/viewes/welcome.dart';
import 'package:flutter/material.dart';



// Asumsi 'constants.dart' memiliki variabel ini. Saya membuat definisi dummy.
// Anda harus mengganti ini dengan definisi yang ada di file constants.dart Anda.
const double kDefaultPadding = 20.0;
// Mengatur warna ungu sebagai default primary color
const Color kPrimaryColor = Color.fromARGB(255, 175, 45, 189);
// Warna ungu yang lebih terang/soft
const Color kLightPurple = Color(0xFFE9E0F8);

// 1. DUMMY SCREENS UNTUK TUJUAN NAVIGASI
class DummyScreen extends StatelessWidget {
  final String title;
  final Color primaryColor;
  final bool isDarkMode;

  const DummyScreen({super.key, required this.title, required this.primaryColor, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    final Color textColor = isDarkMode ? Colors.white : Colors.black;
    final Color bgColor = isDarkMode ? const Color(0xFF121212) : Colors.white;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(title, style: const TextStyle(color: Colors.white)),
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Text(
          'This is the $title Screen! (Coming Soon)',
          style: TextStyle(fontSize: 24, color: textColor),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}


// Mengubah menjadi StatefulWidget untuk mengelola status mode tema dan warna
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  // Status: true jika mode gelap aktif, false jika mode terang
  bool _isDarkMode = false;

  // Status: Warna dasar utama yang dipilih (Default: Ungu dari kPrimaryColor/kLightPurple)
  Color _primaryColor = kPrimaryColor; // Menggunakan kPrimaryColor dari constants sebagai default
  // Latar belakang terang (soft) yang disesuaikan berdasarkan primary color
  Color _lightBackgroundColor = kLightPurple;

  // Daftar warna yang tersedia
  final List<Map<String, dynamic>> _colorOptions = [
    {'label': 'Red', 'color': const Color(0xFFFF0000)},
    {'label': 'Green', 'color': const Color(0xFF008000)},
    {'label': 'Blue', 'color': const Color(0xFF0000FF)},
    {'label': 'Pink', 'color': const Color(0xFFFFC0CB)},
    {'label': 'Yellow', 'color': const Color(0xFFFFFF00)},
    {'label': 'Orange', 'color': const Color(0xFFFFA500)},
    {'label': 'Purple', 'color': const Color(0xFF800080)},
    {'label': 'Deep Purple', 'color': const Color(0xFF673AB7)},
    {'label': 'Light Blue', 'color': const Color(0xFFADD8E6)},
    {'label': 'Teal', 'color': const Color(0xFF008080)},
    {'label': 'Lime', 'color': const Color(0xFF00FF00)},
    {'label': 'Deep Orange', 'color': const Color(0xFFFF5722)},
  ];

  // Fungsi untuk mengganti mode tema
  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  // Fungsi untuk mengubah warna dasar
  void _changePrimaryColor(Color newColor) {
    setState(() {
      _primaryColor = newColor;
      // Mengatur warna latar belakang terang menjadi warna yang lebih soft dari _primaryColor
      _lightBackgroundColor = newColor.withOpacity(0.15);
    });
    Navigator.of(context).pop(); // Tutup dialog setelah memilih
  }

  // Fungsi untuk menampilkan dialog pemilihan warna
  void _showColorPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Primary Color'),
          content: SizedBox(
            width: double.maxFinite,
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // 4 kolom
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.0,
              ),
              itemCount: _colorOptions.length,
              itemBuilder: (context, index) {
                final colorItem = _colorOptions[index];
                return GestureDetector(
                  onTap: () => _changePrimaryColor(colorItem['color'] as Color),
                  child: Column(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: colorItem['color'] as Color,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: _primaryColor == colorItem['color'] ? Colors
                                .black : Colors.transparent,
                            // Highlight warna yang sedang aktif
                            width: 3,
                          ),
                        ),
                        child: _primaryColor == colorItem['color']
                            ? const Icon(Icons.check, color: Colors.white)
                            : null,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        colorItem['label'] as String,
                        style: TextStyle(fontSize: 10, color: _isDarkMode
                            ? Colors.white70
                            : Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // Widget untuk membuat item menu di Drawer
  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required Color iconColor,
    required Color textColor,
    required VoidCallback onTap,
    Color? tileColor, // Untuk item 'Home' yang disorot
  }) {
    return ListTile(
      tileColor: tileColor,
      leading: Icon(icon, color: iconColor),
      title: Text(title, style: TextStyle(color: textColor)),
      onTap: onTap,
    );
  }

  // Fungsi navigasi yang lebih terpusat
  void _navigateToScreen(String title) {
    // Tutup Drawer terlebih dahulu
    Navigator.pop(context);

    if (title == 'Home') {
      // Tidak perlu pindah, karena sudah di Home
      return;
    }

    // LOGIKA LOGOUT: Pindah ke UserSelectionScreen (Halaman Pilihan Pengguna)
    // Menggunakan pushReplacement agar pengguna tidak bisa kembali ke HomeScreen
    if (title == 'Logout') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const WelcomePage(),
        ),
      );
      return;
    }


    // Pindah ke DummyScreen untuk menu lainnya (Recent Job, Find Job, dll.)
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            DummyScreen(
                title: title,
                primaryColor: _primaryColor,
                isDarkMode: _isDarkMode
            ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    // Tentukan warna tema berdasarkan status _isDarkMode dan warna pilihan
    final Color backgroundColor = _isDarkMode
        ? const Color(0xFF121212)
        : _lightBackgroundColor; // Menggunakan _lightBackgroundColor yang dinamis
    final Color primaryColor = _primaryColor; // Menggunakan warna dasar pilihan
    final Color textColor = _isDarkMode ? Colors.white : Colors.black87;
    final Color iconColor = _isDarkMode ? Colors.white : Colors.black87;
    final Color cardColor = _isDarkMode ? const Color(0xFF1E1E1E) : Colors
        .white;
    final Color drawerBgColor = cardColor; // Menggunakan cardColor untuk latar belakang drawer
    final Color selectedTileColor = primaryColor.withOpacity(
        0.15); // Warna sorotan untuk item Home

    // Menyesuaikan warna ikon di AppBar agar intuitif:
    final Color lightIconColor = _isDarkMode
        ? iconColor.withOpacity(0.5)
        : primaryColor;
    final Color darkIconColor = _isDarkMode ? primaryColor : iconColor
        .withOpacity(0.5);

    return Scaffold(
      // Menggunakan warna latar belakang yang dinamis
      backgroundColor: backgroundColor,
      // Tambahkan Drawer di Scaffold untuk menu hamburger
      drawer: Drawer(
        backgroundColor: drawerBgColor,
        child: Column( // Menggunakan Column untuk menempatkan header, list menu, dan footer
          children: <Widget>[
            // Header Drawer: Logo dan Nama Aplikasi
            Padding(
              padding: const EdgeInsets.only(
                  top: 40.0, bottom: 20.0, left: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container( // Ikon Koper/Logo
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        // PERBAIKAN: Mengganti Icons.work_bag_outlined yang mungkin bermasalah dengan Icons.work_outline
                        child: const Icon(
                            Icons.work_outline, color: Colors.white, size: 30),
                      ),
                      const SizedBox(width: 10),
                      Text('Gawee', style: TextStyle(color: textColor,
                          fontSize: 28,
                          fontWeight: FontWeight.bold)),
                    ],
                  ),
                  IconButton( // Tombol Tutup (X)
                    icon: Icon(Icons.close, color: textColor),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            // Daftar Menu
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  // Home (Disorot)
                  _buildDrawerItem(
                    icon: Icons.home,
                    title: 'Home',
                    iconColor: primaryColor,
                    textColor: primaryColor,
                    onTap: () => Navigator.pop(context),
                    // Tutup drawer saja
                    tileColor: selectedTileColor,
                  ),
                  // Menu yang akan pindah ke DummyScreen
                  _buildDrawerItem(
                    icon: Icons.access_time,
                    title: 'Recent Job',
                    iconColor: textColor.withOpacity(0.7),
                    textColor: textColor,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>const RecentJobPage(),
                      ),
                    ),
                  ),
                  _buildDrawerItem(
                    icon: Icons.search,
                    title: 'Find Job',
                    iconColor: textColor.withOpacity(0.7),
                    textColor: textColor,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>const JobSearchScreen(),
                      ),
                    ),
                  ),
                  _buildDrawerItem(
                    icon: Icons.notifications,
                    title: 'Notifications (2)',
                    iconColor: textColor.withOpacity(0.7),
                    textColor: textColor,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>const NotificationsPage(),
                      ),
                    ),
                  ),
                  _buildDrawerItem(
                    icon: Icons.person,
                    title: 'Profile',
                    iconColor: textColor.withOpacity(0.7),
                    textColor: textColor,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>const ProfilePage(),
                      ),
                    ),
                  ),
                  _buildDrawerItem(
                    icon: Icons.mail,
                    title: 'Message',
                    iconColor: textColor.withOpacity(0.7),
                    textColor: textColor,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>const MessagesPage(),
                      ),
                    ),
                  ),
                  _buildDrawerItem(
                    icon: Icons.grid_view,
                    title: 'Elements',
                    iconColor: textColor.withOpacity(0.7),
                    textColor: textColor,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>const ElementsPage(),
                        ),
                      ),
                  ),
                  _buildDrawerItem(
                    icon: Icons.settings,
                    title: 'Setting',
                    iconColor: textColor.withOpacity(0.7),
                    textColor: textColor,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>const ColorThemesPage(),
                      ),
                    ),
                  ),
                  // Tombol Logout: Berpindah ke UserSelectionScreen
                  _buildDrawerItem(
                    icon: Icons.logout,
                    title: 'Logout',
                    iconColor: primaryColor,
                    // Paling menonjol karena ini aksi kritis
                    textColor: primaryColor,
                    onTap: () => _navigateToScreen('Logout'),
                  ),
                ],
              ),
            ),

            // Footer Drawer: App Version
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Gawee Job Portal',
                      style: TextStyle(color: textColor.withOpacity(0.7))),
                  Text('App Version 1.3', style: TextStyle(
                      color: textColor.withOpacity(0.5), fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Builder( // Menggunakan Builder untuk mendapatkan context dari Scaffold dan membuka Drawer
            builder: (context) {
              return Row(
                children: [
                  // Ikon Menu Hamburger (Dapat diklik untuk membuka Drawer)
                  IconButton(
                    icon: Icon(Icons.menu, color: iconColor),
                    onPressed: () {
                      Scaffold.of(context).openDrawer(); // Aksi membuka Drawer
                    },
                  ),
                  const Spacer(),
                  // Ikon Pemilih Warna
                  IconButton(
                    icon: Icon(Icons.color_lens_outlined, color: primaryColor),
                    onPressed: () => _showColorPicker(context),
                  ),
                  // Ikon Mode Gelap/Terang
                  Row(
                    children: [
                      // Tombol Terang
                      IconButton(
                        icon: Icon(
                          Icons.wb_sunny_outlined,
                          color: lightIconColor,
                        ),
                        onPressed: _isDarkMode ? _toggleTheme : null,
                      ),
                      // Tombol Gelap
                      IconButton(
                        icon: Icon(
                          Icons.nightlight_round,
                          color: darkIconColor,
                        ),
                        onPressed: _isDarkMode ? null : _toggleTheme,
                      ),
                    ],
                  ),
                ],
              );
            }
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 10),

            // Bagian Header 'Hello Richard Brownlee'
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hello', style: TextStyle(
                        fontSize: 16, color: textColor.withOpacity(0.7))),
                    Text(
                      'Richard Brownlee',
                      style: TextStyle(fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: textColor),
                    ),
                  ],
                ),
                const Spacer(),
                CircleAvatar( // Warna avatar menggunakan primaryColor
                  radius: 30,
                  backgroundColor: primaryColor,
                  child: const Icon(
                      Icons.person, color: Colors.white, size: 40),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                // Menggunakan warna kartu yang dinamis
                color: cardColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(_isDarkMode ? 0.0 : 0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                style: TextStyle(color: textColor),
                decoration: InputDecoration(
                  hintText: 'Search job here...',
                  hintStyle: TextStyle(color: textColor.withOpacity(0.5)),
                  border: InputBorder.none,
                  suffixIcon: Icon(
                      Icons.search, color: textColor.withOpacity(0.7)),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Banner 'Recomended Jobs'
            Container(
              padding: const EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.8),
                // Menggunakan primaryColor
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Recomended Jobs',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'See our recommendations job for you based your skills',
                          style: TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                      Icons.laptop_chromebook, size: 50, color: Colors.white),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Statistik (Jobs Applied & Interviews)
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                      '45', 'Jobs Applied', cardColor, textColor, _isDarkMode,
                      primaryColor),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _buildStatCard(
                      '28', 'Interviews', cardColor, textColor, _isDarkMode,
                      primaryColor),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Kategori Pekerjaan
            Text(
              'Job Categories',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
            ),
            const SizedBox(height: 15),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryButton(
                      'Designer', const Color.fromARGB(255, 27, 66, 163)),
                  _buildCategoryButton('Manager', const Color(0xFF1E8449)),
                  _buildCategoryButton('Programmer', const Color(0xFFB8860B)),
                  _buildCategoryButton(
                      'UX/UI Designer', const Color.fromARGB(255, 6, 89, 9)),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Featured Jobs
            Text(
              'Featured Jobs',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
            ),
            const SizedBox(height: 15),
            _buildFeaturedJobsList(
                cardColor, textColor, _isDarkMode, primaryColor),
            const SizedBox(height: 30),

            // Recent Jobs List (Mirip dengan Featured Jobs, tapi vertikal)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Jobs List',
                  style: TextStyle(fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor),
                ),
                Text(
                  'More',
                  style: TextStyle(color: primaryColor,
                      fontWeight: FontWeight.bold), // Menggunakan primaryColor
                ),
              ],
            ),
            const SizedBox(height: 15),
            _buildRecentJobItem(
                'Junior Software Engineer',
                'Medan, Indonesia',
                '\$500 - \$1,000',
                const Color(0xFF7A42C8),
                cardColor,
                textColor,
                _isDarkMode,
                primaryColor),
            _buildRecentJobItem(
                'Software Engineer',
                'Medan, Indonesia',
                '\$500 - \$1,000',
                const Color(0xFF7A42C8).withOpacity(0.7),
                cardColor,
                textColor,
                _isDarkMode,
                primaryColor),
            _buildRecentJobItem(
                'Graphic Designer',
                'Medan, Indonesia',
                '\$500 - \$1,000',
                primaryColor,
                cardColor,
                textColor,
                _isDarkMode,
                primaryColor), // Menggunakan primaryColor
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Widget untuk Kartu Statistik (Diperbarui untuk menerima primaryColor)
  Widget _buildStatCard(String value, String label, Color cardColor,
      Color textColor, bool isDarkMode, Color primaryColor) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(isDarkMode ? 0.0 : 0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle( // Ubah dari const TextStyle menjadi TextStyle
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: primaryColor, // Menggunakan primaryColor
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(color: textColor.withOpacity(0.7)),
          ),
        ],
      ),
    );
  }

  // Widget untuk Tombol Kategori (Diperbarui untuk tidak lagi menggunakan kButtonBlue/Green/Brown)
  Widget _buildCategoryButton(String label, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.w600),
      ),
    );
  }

  // Widget untuk daftar Featured Jobs (Horizontal) (Diperbarui untuk menerima primaryColor)
  Widget _buildFeaturedJobsList(Color cardColor, Color textColor,
      bool isDarkMode, Color primaryColor) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildJobCard(
              'Cosax Studios',
              'Software Engineer',
              'Medan, Indonesia',
              '\$500 - \$1,000',
              primaryColor,
              cardColor,
              textColor,
              isDarkMode,
              primaryColor),
          _buildJobCard(
              'Cosax Studios',
              'Senior Project Manager',
              'Medan, Indonesia',
              '\$900 - \$1,500',
              primaryColor.withOpacity(0.8),
              cardColor,
              textColor,
              isDarkMode,
              primaryColor),
        ],
      ),
    );
  }

  // Widget untuk Kartu Pekerjaan (Featured Job) (Diperbarui untuk menerima primaryColor)
  Widget _buildJobCard(String company,
      String title,
      String location,
      String salary,
      Color iconBgColor,
      Color cardColor,
      Color textColor,
      bool isDarkMode,
      Color primaryColor,) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman detail pekerjaan
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CompanyDetailPage(),
          ),
        );
      },
      child: Container(
        width: 250,
        margin: const EdgeInsets.only(right: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(isDarkMode ? 0.0 : 0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: iconBgColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.code, color: iconBgColor, size: 24),
                ),
                const SizedBox(width: 10),
                Text(company,
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: textColor)),
                const Spacer(),
                Icon(Icons.bookmark_border,
                    color: textColor.withOpacity(0.7), size: 20),
              ],
            ),
            const SizedBox(height: 15),
            Text(title,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor)),
            const SizedBox(height: 5),
            Text(location, style: TextStyle(color: textColor.withOpacity(0.7))),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(salary,
                    style: TextStyle(
                        color: primaryColor, fontWeight: FontWeight.bold)),
                Icon(Icons.arrow_forward_ios,
                    color: textColor.withOpacity(0.7), size: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }


  // Widget untuk Item Pekerjaan Terbaru (Recent Jobs List) (Diperbarui untuk menerima primaryColor)
  Widget _buildRecentJobItem(String title,
      String location,
      String salary,
      Color iconBgColor,
      Color cardColor,
      Color textColor,
      bool isDarkMode,
      Color primaryColor,) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>const JobDetailPage(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(isDarkMode ? 0.0 : 0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: iconBgColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.business_center,
                  color: iconBgColor, size: 30),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: textColor)),
                  const SizedBox(height: 5),
                  Text(location,
                      style: TextStyle(color: textColor.withOpacity(0.7))),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(Icons.bookmark_border,
                    color: textColor.withOpacity(0.7), size: 20),
                const SizedBox(height: 5),
                Text(salary,
                    style: TextStyle(
                        color: primaryColor, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
