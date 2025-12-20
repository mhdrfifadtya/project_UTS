import 'package:apkgawee/viewes/constraint.dart';
import 'package:apkgawee/viewes/login.dart';
import 'package:flutter/material.dart';


class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightPurple,
      appBar: AppBar(
        backgroundColor: kLightPurple,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 10),

            // Teks Utama
            const Text(
              'Create a New Account',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Please fill out the form below to register.',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 40),

            // Field Input Full Name
            const _CustomInputField(hintText: 'Full Name', icon: Icons.person_outline),
            const SizedBox(height: 15),

            // Field Input Email
            const _CustomInputField(hintText: 'Email Address', icon: Icons.email_outlined),
            const SizedBox(height: 15),

            // Field Input User Name
            const _CustomInputField(hintText: 'User Name', icon: Icons.account_circle_outlined),
            const SizedBox(height: 15),

            // Field Input Password
            const _CustomInputField(hintText: 'Password', icon: Icons.lock_outline, isPassword: true),
            const SizedBox(height: 25),

            // Tombol REGISTER
            ElevatedButton(
              onPressed: () {
                // Simulasi registrasi sukses, navigasi kembali ke login
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen(userType: 'Job Seeker')),
                );
                // Tambahkan pop-up atau snackbar sukses
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Registration Successful! Please log in.')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'REGISTER',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Sudah punya akun
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account? ',
                  style: TextStyle(color: Colors.black54),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // Kembali ke halaman Login
                  },
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// Widget Pembantu untuk Input Field yang Didesain
class _CustomInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool isPassword;

  const _CustomInputField({
    required this.hintText,
    required this.icon,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon, color: kPrimaryColor.withOpacity(0.7)),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      ),
    );
  }
}