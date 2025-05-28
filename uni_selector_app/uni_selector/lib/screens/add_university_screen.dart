import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddUniversityScreen extends StatefulWidget {
  const AddUniversityScreen({super.key});

  @override
  State<AddUniversityScreen> createState() => _AddUniversityScreenState();
}

class _AddUniversityScreenState extends State<AddUniversityScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _image1Controller = TextEditingController();
  final _image2Controller = TextEditingController();
  final _image3Controller = TextEditingController();
  

  String _type = 'Government';

  void _submit() async {
    final name = _nameController.text.trim();

    final data = {
      'name': name,
      'searchName': name.toLowerCase(), // ✅ Added for case-insensitive search
      'location': _locationController.text.trim(),
      'description': _descriptionController.text.trim(),
      'type': _type,
      'imageUrls': [
        _image1Controller.text.trim(),
        _image2Controller.text.trim(),
        _image3Controller.text.trim(),
      ]
    };

    await FirebaseFirestore.instance.collection('universities').add(data);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('University Added')),
    );
    _formKey.currentState?.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add University')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(controller: _nameController, decoration: const InputDecoration(labelText: 'Name')),
              TextFormField(controller: _locationController, decoration: const InputDecoration(labelText: 'Location')),
              TextFormField(controller: _descriptionController, decoration: const InputDecoration(labelText: 'Description')),
              DropdownButtonFormField<String>(
                value: _type,
                decoration: const InputDecoration(labelText: 'Type'),
                items: const [
                  DropdownMenuItem(value: 'Government', child: Text('Government')),
                  DropdownMenuItem(value: 'Private', child: Text('Private')),
                ],
                onChanged: (value) => setState(() => _type = value!),
              ),
              TextFormField(controller: _image1Controller, decoration: const InputDecoration(labelText: 'Image 1 URL')),
              TextFormField(controller: _image2Controller, decoration: const InputDecoration(labelText: 'Image 2 URL')),
              TextFormField(controller: _image3Controller, decoration: const InputDecoration(labelText: 'Image 3 URL')),
              
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _submit, child: const Text('Add University')),
            ],
          ),
        ),
      ),
    );
  }
}
