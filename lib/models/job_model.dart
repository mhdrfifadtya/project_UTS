class Job {
  final int id;
  final String title;
  final String location;
  final String company;
  final String salary;

  Job({
    required this.id,
    required this.title,
    required this.location,
    required this.company,
    required this.salary,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    final user = json['user'];

    return Job(
      id: json['id'] ?? 0,
      title: json['title'] ?? '-',
      location: json['location'] ?? '-',
      company: user != null ? user['name'] ?? '-' : 'Unknown Company',
      salary: _formatSalary(
        json['salary_min'],
        json['salary_max'],
      ),
    );
  }

  static String _formatSalary(dynamic min, dynamic max) {
    if (min == null && max == null) {
      return 'Negotiable';
    }
    return 'Rp ${min ?? '-'} - Rp ${max ?? '-'}';
  }
}
