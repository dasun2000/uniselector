import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddDegreeScreen extends StatefulWidget {
  const AddDegreeScreen({super.key});

  @override
  State<AddDegreeScreen> createState() => _AddDegreeScreenState();
}

class _AddDegreeScreenState extends State<AddDegreeScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _degreeController = TextEditingController();
  final TextEditingController _degreeTypeController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _streamController = TextEditingController();
  final TextEditingController _zscoreController = TextEditingController();

  bool _isLoading = false;

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseFirestore.instance.collection('degree').add({
        'degree': _degreeController.text.trim(),
        'degreeType': _degreeTypeController.text.trim(),
        'district': _districtController.text.trim(),
        'stream': _streamController.text.trim(),
        'zscore': double.parse(_zscoreController.text.trim()),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Degree added successfully')),
      );

      _formKey.currentState!.reset();
      _degreeController.clear();
      _degreeTypeController.clear();
      _districtController.clear();
      _streamController.clear();
      _zscoreController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _degreeController.dispose();
    _degreeTypeController.dispose();
    _districtController.dispose();
    _streamController.dispose();
    _zscoreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Degree")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(_degreeController, "Degree", "Enter degree name"),
              const SizedBox(height: 12),
              _buildTextField(_degreeTypeController, "Degree Type", "Enter degree type"),
              const SizedBox(height: 12),
              _buildTextField(_districtController, "District", "Enter district"),
              const SizedBox(height: 12),
              _buildTextField(_streamController, "Stream", "Enter stream"),
              const SizedBox(height: 12),
              _buildTextField(_zscoreController, "Z-Score", "Enter z-score",
                  keyboardType: TextInputType.number),
              const SizedBox(height: 24),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('Add Degree'),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, String hint,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return '$label is required';
        }
        if (label == 'Z-Score') {
          final z = double.tryParse(value.trim());
          if (z == null) return 'Enter a valid number';
        }
        return null;
      },
    );
  }
}
