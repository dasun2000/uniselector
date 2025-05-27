import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'degree_results_screen.dart';

class DegreeScreen extends StatefulWidget {
  const DegreeScreen({super.key});

  @override
  State<DegreeScreen> createState() => _DegreeScreenState();
}

class _DegreeScreenState extends State<DegreeScreen> {
  String? _selectedField;

  final List<String> _fields = [
    'Engineering',
    'Medicine',
    'Business',
    'IT',
    'Arts',
    'Science'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Degree Finder',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Find Your Perfect Degree',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Select your field to discover degree programs',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 32),

                // Search Box
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search for a degree...',
                        prefixIcon:
                            const Icon(Icons.search, color: Colors.blue),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Field of Study
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.school, color: Colors.blue),
                            SizedBox(width: 8),
                            Text(
                              'Field of Study',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: _fields.map((field) {
                            return FilterChip(
                              label: Text(field),
                              selected: _selectedField == field,
                              onSelected: (selected) {
                                setState(() {
                                  _selectedField = selected ? field : null;
                                });
                              },
                              selectedColor: Colors.blue[100],
                              checkmarkColor: Colors.blue,
                              labelStyle: TextStyle(
                                color: _selectedField == field
                                    ? Colors.blue
                                    : Colors.black,
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Find Degrees Button
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: _selectedField != null
                        ? LinearGradient(colors: [
                            Colors.blue.shade600,
                            Colors.blue.shade400
                          ])
                        : LinearGradient(colors: [
                            Colors.grey.shade400,
                            Colors.grey.shade300
                          ]),
                  ),
                  child: ElevatedButton(
                    onPressed: _selectedField != null
                        ? () async {
                            try {
                              final snapshot = await FirebaseFirestore.instance
                                  .collection('degree')
                                  .where('degreeType', isEqualTo: _selectedField)
                                  .get();

                              if (snapshot.docs.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('No degrees found for this field'),
                                  ),
                                );
                                return;
                              }

                              final results = snapshot.docs
                                  .map((doc) => doc.data())
                                  .toList();

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DegreeResultsScreen(results: results),
                                ),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Error: ${e.toString()}'),
                                ),
                              );
                            }
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Find Degree Programs',
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
      ),
    );
  }
}