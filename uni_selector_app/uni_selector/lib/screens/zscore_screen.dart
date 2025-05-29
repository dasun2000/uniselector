import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ZScoreScreen extends StatefulWidget {
  const ZScoreScreen({super.key});

  @override
  State<ZScoreScreen> createState() => _ZScoreScreenState();
}

class _ZScoreScreenState extends State<ZScoreScreen> {
  final TextEditingController _zScoreController = TextEditingController();
  String? _selectedDistrict;
  String? _selectedStream;
  List<DocumentSnapshot> _results = [];
  bool _loading = false;
  String? _errorMessage;
  bool _usingLocalFilter = false;

  Future<void> _findDegrees() async {
    setState(() {
      _results = [];
      _errorMessage = null;
      _loading = true;
      _usingLocalFilter = false;
    });

    final enteredZScore = double.tryParse(_zScoreController.text);
    if (enteredZScore == null || _selectedDistrict == null || _selectedStream == null) {
      setState(() {
        _loading = false;
        _errorMessage = 'Please enter all required fields';
      });
      return;
    }

    try {
      
      final querySnapshot = await FirebaseFirestore.instance
          .collection('degree')
          .where('district', isEqualTo: _selectedDistrict)
          .where('stream', isEqualTo: _selectedStream)
          .where('zscore', isLessThanOrEqualTo: enteredZScore)
          .orderBy('zscore', descending: true)
          .get();

      setState(() {
        _results = querySnapshot.docs;
      });
    } catch (e) {
      debugPrint('Optimized query failed, falling back to local filter: $e');
      
      
      try {
        setState(() {
          _usingLocalFilter = true;
        });
        
        final querySnapshot = await FirebaseFirestore.instance
            .collection('degree')
            .where('district', isEqualTo: _selectedDistrict)
            .where('stream', isEqualTo: _selectedStream)
            .get();

        final filteredResults = querySnapshot.docs.where((doc) {
          final data = doc.data() as Map<String, dynamic>;
          final zscore = data['zscore'] as num?;
          return zscore != null && zscore.toDouble() <= enteredZScore;
        }).toList();

        setState(() {
          _results = filteredResults;
        });
      } catch (e) {
        debugPrint('Error fetching degrees: $e');
        setState(() {
          _errorMessage = 'Failed to fetch degrees. Please try again later.';
        });
      }
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  final List<String> _districts = [
    'Ampara', 'Anuradhapura', 'Badulla', 'Batticaloa', 'Colombo',
    'Galle', 'Gampaha', 'Hambantota', 'Jaffna', 'Kalutara', 'Kandy',
    'Kegalle', 'Kilinochchi', 'Kurunegala', 'Mannar', 'Matale',
    'Matara', 'Monaragala', 'Mullaitivu', 'Nuwara Eliya', 'Polonnaruwa',
    'Puttalam', 'Ratnapura', 'Trincomalee', 'Vavuniya'
  ];

  final List<String> _streams = [
    'Physical Science',
    'Biological Science',
    'Commerce',
    'Arts',
    'Technology',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Z-Score Analysis'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Enter Your Z-Score',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _zScoreController,
              decoration: InputDecoration(
                hintText: 'e.g., 2.56',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 16),
            const Text(
              'Select District',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedDistrict,
              decoration: InputDecoration(
                hintText: 'Select district',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              items: _districts
                  .map((district) => DropdownMenuItem(
                        value: district,
                        child: Text(district),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedDistrict = value;
                });
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Select Stream',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedStream,
              decoration: InputDecoration(
                hintText: 'Select stream',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              items: _streams
                  .map((stream) => DropdownMenuItem(
                        value: stream,
                        child: Text(stream),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedStream = value;
                });
              },
            ),
            const SizedBox(height: 24),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            if (_usingLocalFilter)
              const Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Text(
                  'Using local filtering (index may still be building)',
                  style: TextStyle(color: Colors.orange),
                ),
              ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _loading ? null : _findDegrees,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Find Eligible Degrees'),
              ),
            ),
            const SizedBox(height: 24),
            if (_results.isNotEmpty) ...[
              const Text(
                'Eligible Degrees:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ..._results.map((doc) {
                final data = doc.data() as Map<String, dynamic>;
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    title: Text(
                      data['degree']?.toString() ?? 'Unknown Degree',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Type: ${data['degreeType']?.toString() ?? '-'}'),
                        Text('Stream: ${data['stream']?.toString() ?? '-'}'),
                        Text('District: ${data['district']?.toString() ?? '-'}'),
                        Text('Z-Score: ${data['zscore']?.toStringAsFixed(4) ?? '-'}'),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ] else if (!_loading && _errorMessage == null)
              const Text(
                'No degrees found for the given inputs.',
                style: TextStyle(color: Colors.grey),
              ),
          ],
        ),
      ),
    );
  }
}