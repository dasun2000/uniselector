import 'package:flutter/material.dart';

class DegreeResultsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> results;

  const DegreeResultsScreen({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Degree Results'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: results.isEmpty
          ? const Center(
              child: Text(
                'No degrees found matching your criteria',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final degree = results[index];
                return Card(
                  margin: const EdgeInsets.all(12),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          degree['degree'] ?? 'Unknown Degree',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildInfoRow('Type:', degree['degreeType']),
                        _buildInfoRow('District:', degree['district']),
                        _buildInfoRow('Stream:', degree['stream']),
                        _buildInfoRow('Z-Score:',
                            degree['zscore']?.toStringAsFixed(2) ?? 'N/A'),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.blueGrey,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value ?? 'Not specified',
              style: const TextStyle(
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}