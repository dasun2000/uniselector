import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteUniversityScreen extends StatefulWidget {
  const DeleteUniversityScreen({super.key});

  @override
  State<DeleteUniversityScreen> createState() => _DeleteUniversityScreenState();
}

class _DeleteUniversityScreenState extends State<DeleteUniversityScreen> {
  final TextEditingController _searchController = TextEditingController();
  DocumentSnapshot? _searchResult;
  String _statusMessage = '';

  Future<void> _searchUniversity() async {
    final name = _searchController.text.trim();
    if (name.isEmpty) {
      setState(() {
        _searchResult = null;
        _statusMessage = 'Please enter a university name.';
      });
      return;
    }

    final query = await FirebaseFirestore.instance
        .collection('universities')
        .where('name', isEqualTo: name)
        .get();

    if (query.docs.isNotEmpty) {
      setState(() {
        _searchResult = query.docs.first;
        _statusMessage = '';
      });
    } else {
      setState(() {
        _searchResult = null;
        _statusMessage = 'No university found with that name.';
      });
    }
  }

  Future<void> _deleteUniversity() async {
    if (_searchResult == null) return;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this university?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Delete')),
        ],
      ),
    );

    if (confirm == true) {
      await FirebaseFirestore.instance
          .collection('universities')
          .doc(_searchResult!.id)
          .delete();
      setState(() {
        _searchResult = null;
        _statusMessage = 'University deleted successfully.';
        _searchController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Delete University')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search University by Name',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _searchUniversity(),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _searchUniversity,
              child: const Text('Search'),
            ),
            const SizedBox(height: 20),
            if (_statusMessage.isNotEmpty)
              Text(
                _statusMessage,
                style: TextStyle(
                  color: _statusMessage.contains('deleted') ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (_searchResult != null) ...[
              Card(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  title: Text(_searchResult!['name']),
                  subtitle: Text(_searchResult!['location']),
                ),
              ),
              ElevatedButton.icon(
                onPressed: _deleteUniversity,
                icon: const Icon(Icons.delete),
                label: const Text('Delete University'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              )
            ]
          ],
        ),
      ),
    );
  }
}
