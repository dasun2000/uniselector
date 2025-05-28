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
  final _degreeController = TextEditingController();
  final _fieldController = TextEditingController();
  final _careerPathsController = TextEditingController();
  final _zscore2023Controller = TextEditingController();
  final _zscore2022Controller = TextEditingController();

  String _type = 'Government';

  void _submit() async {
    final data = {
      'name': _nameController.text,
      'location': _locationController.text,
      'description': _descriptionController.text,
      'type': _type,
      'imageUrls': [
        _image1Controller.text,
        _image2Controller.text,
        _image3Controller.text,
      ],
      'degrees': [
        {
          'name': _degreeController.text,
          'field': _fieldController.text,
          'careerPaths': _careerPathsController.text.split(','),
          'zScores': {
            '2023': double.tryParse(_zscore2023Controller.text),
            '2022': double.tryParse(_zscore2022Controller.text),
          }
        }
      ]
    };

    await FirebaseFirestore.instance.collection('universities').add(data);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('University Added')));
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
              TextFormField(controller: _degreeController, decoration: const InputDecoration(labelText: 'Degree Name')),
              TextFormField(controller: _fieldController, decoration: const InputDecoration(labelText: 'Field')),
              TextFormField(controller: _careerPathsController, decoration: const InputDecoration(labelText: 'Career Paths (comma separated)')),
              TextFormField(controller: _zscore2023Controller, decoration: const InputDecoration(labelText: 'Z-Score 2023')),
              TextFormField(controller: _zscore2022Controller, decoration: const InputDecoration(labelText: 'Z-Score 2022')),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _submit, child: const Text('Add University')),
            ],
          ),
        ),
      ),
    );
  }
}
