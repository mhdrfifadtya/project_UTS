import 'package:apkgawee/viewes/constraint.dart';
import 'package:flutter/material.dart';

// Custom Colors
const Color appPrimaryColor = Color(0xFF884DF4); // Ungu
const Color appBackgroundColor = Color(0xFFF7F4FA); // Latar Belakang

// Enum untuk mengontrol tampilan mode resume
enum ResumeMode { none, upload, create }

class UploadResumeScreen extends StatefulWidget {
  const UploadResumeScreen({super.key});

  @override
  State<UploadResumeScreen> createState() => _UploadResumeScreenState();
}

class _UploadResumeScreenState extends State<UploadResumeScreen> {
  // State untuk mengelola input form
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  // State utama: Mengontrol mode tampilan (none = tampilan awal, upload/create = tampilan form)
  ResumeMode _resumeMode = ResumeMode.none;

  @override
  void dispose() {
    _emailController.dispose();
    _jobTitleController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  // Widget Pembantu untuk icon di tengah
  Widget _buildIconCircle({
    required IconData icon,
    required String label,
    required String description,
    double iconSize = 40,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade300, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Icon(icon, size: iconSize, color: appPrimaryColor),
        ),
        const SizedBox(height: 20),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ],
    );
  }

  // Widget Pembantu untuk bagian Upload Your Resume
  Widget _buildUploadSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Column(
        children: [
          _buildIconCircle(
            icon: Icons.upload_file,
            label: 'Upload your resume',
            description: 'Upload your resume and you\'ll be able to apply to jobs in just one click!',
          ),
          const SizedBox(height: 20),
          // Tombol Upload
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Mengubah mode menjadi upload untuk menampilkan form isian
                setState(() {
                  _resumeMode = ResumeMode.upload;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                'Upload',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          const Divider(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // Widget Pembantu untuk bagian Create Resume
  Widget _buildCreateSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Column(
        children: [
          _buildIconCircle(
            icon: Icons.edit_note,
            label: 'Crete your resume',
            description: 'Don\'t have a resume? Create one in no time with our easy-to-use Resume-builder tool',
          ),
          const SizedBox(height: 20),
          // Tombol Create
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Sekarang tombol ini juga mengarahkan ke form isian dengan mode 'create'
                setState(() {
                  _resumeMode = ResumeMode.create;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                'Create',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget Pembantu untuk input form
  Widget _buildFormInput({
    required TextEditingController controller,
    required String label,
    required String hint,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              children: const [
                TextSpan(
                  text: ' *',
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget Pembantu untuk tampilan form isian detail (Resume Form)
  Widget _buildResumeForm() {
    // Teks header form disesuaikan berdasarkan mode yang dipilih
    final String formTitle = _resumeMode == ResumeMode.upload ?
    'Upload your resume' : 'Create your resume';
    final String formDescription = _resumeMode == ResumeMode.upload ?
    'Adding your resume allows you to apply very quickly to many jobs from any device' :
    'Fill in the details below to generate a new resume for job applications.';

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Icon dan Text Header disesuaikan
          _buildIconCircle(
            icon: Icons.edit_document,
            label: formTitle,
            description: formDescription,
            iconSize: 50,
          ),
          const SizedBox(height: 30),

          // Input Email
          _buildFormInput(
            controller: _emailController,
            label: 'Email',
            hint: 'Type in your email',
          ),

          // Input Job Title
          _buildFormInput(
            controller: _jobTitleController,
            label: 'Your job title or qualification',
            hint: 'Your job title or qualification',
          ),

          // Input Location
          _buildFormInput(
            controller: _locationController,
            label: 'Your location',
            hint: 'Town, county or country',
          ),

          const SizedBox(height: 30),

          // Tombol Create
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Aksi menyimpan data resume
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                'Create',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Tombol Cancel
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Mengubah state kembali ke tampilan awal (Post Your Resumes)
                setState(() {
                  _resumeMode = ResumeMode.none;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor.withOpacity(0.1),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: const BorderSide(color: appPrimaryColor),
                ),
                elevation: 0,
              ),
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: appPrimaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    // Mengecek apakah kita berada di tampilan form
    final bool isFormView = _resumeMode != ResumeMode.none;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (isFormView) {
              // Jika di form, kembali ke halaman 'Post Your Resumes'
              setState(() {
                _resumeMode = ResumeMode.none;
              });
            } else {
              // Jika di halaman awal, keluar dari screen
              Navigator.pop(context);
            }
          },
        ),
        // Judul AppBar disesuaikan
        title: Text(isFormView ? 'Resume' : 'Post Your Resumes'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Menampilkan form atau tampilan awal berdasarkan state
            if (isFormView)
              _buildResumeForm()
            else
              Column(
                children: [
                  _buildUploadSection(),
                  _buildCreateSection(),
                ],
              ),
          ],
        ),
      ),
    );
  }
}