import 'package:flutter/material.dart';
import 'package:apkgawee/viewes/constraint.dart';
import 'package:apkgawee/viewes/home.dart'
    hide kPrimaryColor, kLightPurple, kDefaultPadding;
import 'package:apkgawee/viewes/registrasi.dart';
import 'package:apkgawee/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  final String userType;

  const LoginScreen({super.key, required this.userType});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const String _jobSeeker = 'JOB SEEKER';
  static const String _company = 'COMPANY';

  String _currentType = _jobSeeker;
  bool _loading = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _companyIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentType =
        widget.userType.toUpperCase().contains('COMPANY')
            ? _company
            : _jobSeeker;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _companyIdController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() => _loading = true);

    final success = await AuthService.login(
      email: _emailController.text,
      password: _passwordController.text,
      role: _currentType == _company ? 'company' : 'job_seeker',
    );

    setState(() => _loading = false);

    if (!mounted) return;

    if (success) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
        (_) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email atau password salah')),
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
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 30),

            // LOGO
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.business_center_outlined, size: 35),
                SizedBox(width: 8),
                Text(
                  'Gawee',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // USER TYPE TAB
            Row(
              children: [
                Expanded(child: _buildTypeTab(_jobSeeker)),
                Expanded(child: _buildTypeTab(_company)),
              ],
            ),

            const SizedBox(height: 25),

            if (_currentType == _company)
              _buildInput(_companyIdController, 'Company ID'),

            _buildInput(_emailController, 'Email'),
            _buildInput(_passwordController, 'Password', obscure: true),

            const SizedBox(height: 25),

            // LOGIN BUTTON
            ElevatedButton(
              onPressed: _loading ? null : _login,
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: _loading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
            ),

            const SizedBox(height: 30),

            // REGISTER
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RegistrationScreen(),
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: kPrimaryColor),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text(
                'CREATE ACCOUNT',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInput(
    TextEditingController controller,
    String hint, {
    bool obscure = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildTypeTab(String type) {
    final bool selected = _currentType == type;
    return GestureDetector(
      onTap: () => setState(() => _currentType = type),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: selected ? kPrimaryColor : Colors.transparent,
              width: 3,
            ),
          ),
        ),
        child: Text(
          type,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            color: selected ? kPrimaryColor : Colors.black54,
          ),
        ),
      ),
    );
  }
}
