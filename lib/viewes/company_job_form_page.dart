import 'package:flutter/material.dart';
import '../models/job_model.dart';
import '../services/job_service.dart';

class CompanyJobFormPage extends StatefulWidget {
  final Job? job;

  const CompanyJobFormPage({super.key, this.job});

  @override
  State<CompanyJobFormPage> createState() => _CompanyJobFormPageState();
}

class _CompanyJobFormPageState extends State<CompanyJobFormPage> {
  final titleCtrl = TextEditingController();
  final locationCtrl = TextEditingController();
  final minCtrl = TextEditingController();
  final maxCtrl = TextEditingController();

  bool loading = false;

  @override
  void initState() {
    super.initState();
    if (widget.job != null) {
      titleCtrl.text = widget.job!.title;
      locationCtrl.text = widget.job!.location;
    }
  }

  Future<void> save() async {
    setState(() => loading = true);

    final body = {
      'title': titleCtrl.text,
      'location': locationCtrl.text,
      'salary_min': minCtrl.text,
      'salary_max': maxCtrl.text,
    };

    if (widget.job == null) {
      await JobService.createJob(body);
    } else {
      await JobService.updateJob(widget.job!.id, body);
    }

    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.job == null ? 'Add Job' : 'Edit Job'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: titleCtrl, decoration: const InputDecoration(labelText: 'Title')),
            TextField(controller: locationCtrl, decoration: const InputDecoration(labelText: 'Location')),
            TextField(controller: minCtrl, decoration: const InputDecoration(labelText: 'Salary Min')),
            TextField(controller: maxCtrl, decoration: const InputDecoration(labelText: 'Salary Max')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: loading ? null : save,
              child: loading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('SAVE'),
            ),
          ],
        ),
      ),
    );
  }
}
