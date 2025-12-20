import 'package:apkgawee/viewes/constraint.dart';
import 'package:flutter/material.dart';


class ColorThemesPage extends StatefulWidget {
  const ColorThemesPage({super.key});

  @override
  State<ColorThemesPage> createState() => _ColorThemesPageState();
}

class _ColorThemesPageState extends State<ColorThemesPage> {
  bool isLightTheme = true;
  Color activeColor = Colors.deepPurple;
  int selectedIndex = 0;

  final List<Map<String, dynamic>> colorThemes = [
    {"name": "Red", "color": Colors.red},
    {"name": "Green", "color": Colors.green},
    {"name": "Blue", "color": Colors.blue},
    {"name": "Pink", "color": Colors.pink},
    {"name": "Yellow", "color": Colors.yellow[700]},
    {"name": "Orange", "color": Colors.orange},
    {"name": "Purple", "color": Colors.purple},
    {"name": "Deeppurple", "color": Colors.deepPurple},
    {"name": "Lightblue", "color": Colors.lightBlue},
  ];

  @override
  Widget build(BuildContext context) {
    final bgColor = isLightTheme ? Colors.grey[50] : Colors.black;
    final cardColor = isLightTheme ? Colors.grey[200] : Colors.grey[850];
    final textColor = isLightTheme ? Colors.black : Colors.white;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          "Color Themes",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text("Link", style: TextStyle(color: textColor)),
            ),
          )
        ],
      ),

      // 🔽 Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: activeColor,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.mail), label: "Inbox"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: "Calendar"),
          BottomNavigationBarItem(icon: Icon(Icons.upload), label: "Upload"),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: DefaultTextStyle(
          style: TextStyle(color: textColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Layout Themes",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Framework7 comes with 2 main layout themes: Light (default) and Dark:",
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () => setState(() => isLightTheme = true),
                          child: themeBox(
                              isSelected: isLightTheme,
                              color: Colors.white,
                              checkColor: activeColor),
                        ),
                        GestureDetector(
                          onTap: () => setState(() => isLightTheme = false),
                          child: themeBox(
                              isSelected: !isLightTheme,
                              color: Colors.black,
                              checkColor: activeColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Default Color Themes",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Framework7 comes with 12 color themes set.",
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 12),
                    // 🔽 GridView dengan ukuran proporsional seperti UI
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // 3 kolom
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 2.8, // proporsi kotak lebih lebar
                      ),
                      itemCount: colorThemes.length,
                      itemBuilder: (context, index) {
                        final theme = colorThemes[index];
                        final color = theme['color'] as Color?;
                        final name = theme['name'] as String;
                        final isSelected = activeColor == color;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              activeColor = color!;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget themeBox({
    required bool isSelected,
    required Color color,
    required Color checkColor,
  }) {
    return Container(
      width: 90,
      height: 55,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        border: isSelected ? Border.all(color: checkColor, width: 2) : null,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(2, 2))
        ],
      ),
      child: isSelected
          ? Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Icon(Icons.check_box, color: checkColor, size: 16),
        ),
      )
          : null,
    );
  }
}
