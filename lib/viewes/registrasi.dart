import 'package:flutter/material.dart';
import 'package:apkgawee/viewes/constraint.dart';
import 'package:apkgawee/viewes/login.dart';
import 'package:apkgawee/services/auth_service.dart';

class RegistrationScreen extends StatefulWidget {
  final String role; // job_seeker / company

  const RegistrationScreen({
    super.key,
    required this.role,
  });

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final passwordC = TextEditingController();

  bool loading = false;

  Future<void> register() async {
    setState(() => loading = true);

    final success = await AuthService.register(
      name: nameC.text,
      email: emailC.text,
      password: passwordC.text,
      role: widget.role, // ✅ role dikirim
    );

    setState(() => loading = false);

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration successful, please login')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => LoginScreen(
            userType:
                widget.role == 'company' ? 'COMPANY' : 'JOB SEEKER',
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration failed')),
      );
    }
  }

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
          children: [
            const SizedBox(height: 10),

            Text(
              widget.role == 'company'
                  ? 'Create Company Account'
                  : 'Create Job Seeker Account',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),
            const Text(
              'Please fill out the form below to register.',
              style: TextStyle(color: Colors.black54),
            ),

            const SizedBox(height: 40),

            _CustomInputField(
              hintText: 'Full Name',
              icon: Icons.person_outline,
              controller: nameC,
            ),
            const SizedBox(height: 15),

            _CustomInputField(
              hintText: 'Email Address',
              icon: Icons.email_outlined,
              controller: emailC,
            ),
            const SizedBox(height: 15),

            _CustomInputField(
              hintText: 'Password',
              icon: Icons.lock_outline,
              isPassword: true,
              controller: passwordC,
            ),
            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: loading ? null : register,
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: loading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      'REGISTER',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),

            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account? ',
                  style: TextStyle(color: Colors.black54),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
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
          ],
        ),
      ),
    );
  }
}

class _CustomInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool isPassword;
  final TextEditingController controller;

  const _CustomInputField({
    required this.hintText,
    required this.icon,
    required this.controller,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
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
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      ),
    );
  }
}
