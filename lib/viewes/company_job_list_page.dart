import 'package:flutter/material.dart';
import '../services/job_service.dart';
import '../models/job_model.dart';
import 'company_job_form_page.dart';

class CompanyJobListPage extends StatefulWidget {
  const CompanyJobListPage({super.key});

  @override
  State<CompanyJobListPage> createState() => _CompanyJobListPageState();
}

class _CompanyJobListPageState extends State<CompanyJobListPage> {
  bool loading = true;
  List<Job> jobs = [];

  @override
  void initState() {
    super.initState();
    loadJobs();
  }

  Future<void> loadJobs() async {
    setState(() => loading = true);
    jobs = await JobService.fetchCompanyJobs();
    setState(() => loading = false);
  }

  Future<void> deleteJob(int id) async {
    await JobService.deleteJob(id);
    loadJobs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Jobs')),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const CompanyJobFormPage(),
            ),
          );
          loadJobs();
        },
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: jobs.length,
              itemBuilder: (_, i) {
                final job = jobs[i];
                return ListTile(
                  title: Text(job.title),
                  subtitle: Text(job.location),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  CompanyJobFormPage(job: job),
                            ),
                          );
                          loadJobs();
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => deleteJob(job.id),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
