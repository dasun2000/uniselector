import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddCareerScreen extends StatefulWidget {
  const AddCareerScreen({super.key});

  @override
  State<AddCareerScreen> createState() => _AddCareerScreenState();
}

class _AddCareerScreenState extends State<AddCareerScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _careerController = TextEditingController();

  bool _isSubmitting = false;

  Future<void> _submitCareer() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      await FirebaseFirestore.instance.collection('career').add({
        'type': _typeController.text.trim(),
        'career': _careerController.text.trim(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Career added successfully')),
      );

      _formKey.currentState!.reset();
      _typeController.clear();
      _careerController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }

    setState(() => _isSubmitting = false);
  }

  @override
  void dispose() {
    _typeController.dispose();
    _careerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Career')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(_typeController, 'Field of Study (Type)', 'e.g., Engineering, IT'),
              const SizedBox(height: 16),
              _buildTextField(_careerController, 'Career', 'e.g., Software Engineer'),
              const SizedBox(height: 24),
              _isSubmitting
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _submitCareer,
                      child: const Text('Add Career'),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, String hint) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return '$label is required';
        }
        return null;
      },
    );
  }
}
