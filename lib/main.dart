import 'package:flutter/material.dart';
import 'package:apkgawee/viewes/welcome.dart';
import 'package:apkgawee/viewes/home.dart';
import 'package:apkgawee/services/auth_guard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gawee',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder<bool>(
        future: AuthGuard.isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          // Jika sudah login → langsung Home
          if (snapshot.data == true) {
            return HomeScreen();
          }

          // Jika belum login → Welcome
          return const WelcomePage();
        },
      ),
    );
  }
}
