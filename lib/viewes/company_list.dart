import 'package:flutter/material.dart';

const Color appPrimaryColor = Color(0xFF884DF4);

class CompanyListScreen extends StatefulWidget {
  const CompanyListScreen({super.key});

  @override
  State<CompanyListScreen> createState() => _CompanyListScreenState();
}

class _CompanyListScreenState extends State<CompanyListScreen> {
  final TextEditingController _companySearchController = TextEditingController();

  @override
  void dispose() {
    _companySearchController.dispose();
    super.dispose();
  }

  Widget _buildCompanyListHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
      child: TextField(
        controller: _companySearchController,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          hintText: 'Type Company Name',
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildCompanyCard({
    required String name,
    required String location,
    required int jobs,
    required Color logoBackground,
  }) {
    Widget logoWidget;
    if (name == 'Microsoft') {
      logoWidget = Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.zero,
          mainAxisSpacing: 1.0,
          crossAxisSpacing: 1.0,
          children: const [
            ColoredBox(color: Colors.red),
            ColoredBox(color: Colors.green),
            ColoredBox(color: Colors.blue),
            ColoredBox(color: Colors.yellow),
          ],
        ),
      );
    } else if (name == 'Twitter') {
      logoWidget = Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.blue.shade400,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(Icons.send, color: Colors.white),
      );
    } else {
      logoWidget = Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: logoBackground,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            name[0],
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      );
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            logoWidget,
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: appPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    location,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$jobs Jobs',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
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
          onPressed: () {
            Navigator.pop(context); // Kembali ke Find Job Screen
          },
        ),
        title: const Text('Company List'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: ListView(
        children: [
          // Header pencarian Company
          _buildCompanyListHeader(),

          // Daftar Perusahaan
          _buildCompanyCard(
            name: 'Google', location: 'California, United States', jobs: 10, logoBackground: Colors.red,
          ),
          _buildCompanyCard(
            name: 'Microsoft', location: 'Redmond, Washington, USA', jobs: 9, logoBackground: Colors.blue,
          ),
          _buildCompanyCard(
            name: 'Twitter', location: 'San Francisco, United States', jobs: 4, logoBackground: Colors.blue.shade400,
          ),
          _buildCompanyCard(
            name: 'Tencent', location: 'Shenzhen, china', jobs: 4, logoBackground: Colors.purple.shade300,
          ),
          _buildCompanyCard(
            name: 'Google', location: 'California, United States', jobs: 10, logoBackground: Colors.red,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}