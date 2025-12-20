import 'package:apkgawee/viewes/constraint.dart';
import 'package:flutter/material.dart';


class ElementsPage extends StatefulWidget {
  const ElementsPage({super.key});

  @override
  State<ElementsPage> createState() => _ElementsPageState();
}

class _ElementsPageState extends State<ElementsPage> {
  final List<String> components = [
    'Accordion',
    'Action Sheet',
    'Appbar',
    'Autocomplete',
    'Badge',
    'Buttons',
    'Calendar / Date Picker',
    'Cards',
    'Cards Expandable',
    'Checkbox',
  ];

  void _showComponentInfo(String name) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Kamu menekan komponen: $name'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: kPrimaryColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor.withOpacity(0.2),
        elevation: 0,
        title: const Text(
          'Framework7',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,

        // 🔹 GANTI DARI ICON MENU → PANAH KEMBALI
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // kembali ke halaman sebelumnya
          },
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Judul halaman
            const Text(
              'Framework7',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Kartu "About Framework7"
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: kPrimaryColor,
                    child: Icon(Icons.info_outline, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Text(
                      'About Framework7',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios,
                        size: 16, color: kPrimaryColor),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Tentang Framework7'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              'Components',
              style: TextStyle(
                fontSize: 18,
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Daftar komponen
            Container(
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: components.map((item) {
                  return Column(
                    children: [
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: kPrimaryColor,
                          child: Icon(Icons.widgets, color: Colors.white),
                        ),
                        title: Text(
                          item,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios,
                            size: 16, color: kPrimaryColor),
                        onTap: () => _showComponentInfo(item),
                      ),
                      if (item != components.last)
                        Divider(
                          color: Colors.white.withOpacity(0.5),
                          height: 0,
                        ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
