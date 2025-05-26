import 'package:flutter/material.dart';

class CareersScreen extends StatefulWidget {
  const CareersScreen({super.key});

  @override
  State<CareersScreen> createState() => _CareersScreenState();
}

class _CareersScreenState extends State<CareersScreen> {
  String? _selectedField;
  final List<String> _studyFields = [
    'Engineering',
    'Medicine',
    'Business',
    'Information Technology',
    'Arts & Humanities',
    'Science',
    'Law',
    'Education'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Career Path Finder',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade50,
              Colors.white,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Header
              const Text(
                'Discover Your Career Path',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Select your study field to explore potential careers',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 40),

              // Study Field Selection Card
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.school, color: Colors.blue),
                          SizedBox(width: 8),
                          Text(
                            'Your Study Field',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey[50],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            value: _selectedField,
                            hint: const Text('Select your field'),
                            items: _studyFields.map((String field) {
                              return DropdownMenuItem<String>(
                                value: field,
                                child: Text(
                                  field,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedField = newValue;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Find Careers Button
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: _selectedField != null
                      ? LinearGradient(
                          colors: [Colors.blue.shade600, Colors.blue.shade400])
                      : LinearGradient(
                          colors: [Colors.grey.shade400, Colors.grey.shade300]),
                ),
                child: ElevatedButton(
                  onPressed: _selectedField == null
                      ? null
                      : () {
                          _showCareerOptions(context);
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text(
                    'Find Career Options',
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
        ),
      ),
    );
  }

  void _showCareerOptions(BuildContext context) {
    final Map<String, List<Map<String, String>>> careerData = {
      'Engineering': [
        {'title': 'Software Engineer', 'salary': 'Avg: \$95,000', 'growth': '25% faster than average'},
        {'title': 'Mechanical Engineer', 'salary': 'Avg: \$88,000', 'growth': '4% growth'},
        {'title': 'Civil Engineer', 'salary': 'Avg: \$87,000', 'growth': '8% growth'},
      ],
      'Medicine': [
        {'title': 'Surgeon', 'salary': 'Avg: \$208,000', 'growth': '7% growth'},
        {'title': 'Physician', 'salary': 'Avg: \$200,000', 'growth': '13% growth'},
        {'title': 'Dentist', 'salary': 'Avg: \$160,000', 'growth': '8% growth'},
      ],
      // Add other fields similarly
    };

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CareerResultsScreen(
          field: _selectedField!,
          careers: careerData[_selectedField] ?? [],
        ),
      ),
    );
  }
}

class CareerResultsScreen extends StatelessWidget {
  final String field;
  final List<Map<String, String>> careers;

  const CareerResultsScreen({
    super.key,
    required this.field,
    required this.careers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Careers in $field'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Top Career Paths',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade800,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: careers.length,
                itemBuilder: (context, index) {
                  final career = careers[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            career['title']!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade50,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  career['growth']!,
                                  style: TextStyle(
                                    color: Colors.green.shade800,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                career['salary']!,
                                style: TextStyle(
                                  color: Colors.blue.shade700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Align(
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.arrow_forward_ios, size: 16),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}