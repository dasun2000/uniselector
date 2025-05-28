import 'package:flutter/material.dart';

class ZScoreScreen extends StatelessWidget {
  const ZScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Z-Score Analysis'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter Your Z-Score',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'e.g., 2.56',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            const Text(
              'Select District',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                hintText: 'select',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              items: const [
                
  DropdownMenuItem(value: 'Ampara', child: Text('Ampara')),
  DropdownMenuItem(value: 'Anuradhapura', child: Text('Anuradhapura')),
  DropdownMenuItem(value: 'Badulla', child: Text('Badulla')),
  DropdownMenuItem(value: 'Batticaloa', child: Text('Batticaloa')),
  DropdownMenuItem(value: 'Colombo', child: Text('Colombo')),
  DropdownMenuItem(value: 'Galle', child: Text('Galle')),
  DropdownMenuItem(value: 'Gampaha', child: Text('Gampaha')),
  DropdownMenuItem(value: 'Hambantota', child: Text('Hambantota')),
  DropdownMenuItem(value: 'Jaffna', child: Text('Jaffna')),
  DropdownMenuItem(value: 'Kalutara', child: Text('Kalutara')),
  DropdownMenuItem(value: 'Kandy', child: Text('Kandy')),
  DropdownMenuItem(value: 'Kegalle', child: Text('Kegalle')),
  DropdownMenuItem(value: 'Kilinochchi', child: Text('Kilinochchi')),
  DropdownMenuItem(value: 'Kurunegala', child: Text('Kurunegala')),
  DropdownMenuItem(value: 'Mannar', child: Text('Mannar')),
  DropdownMenuItem(value: 'Matale', child: Text('Matale')),
  DropdownMenuItem(value: 'Matara', child: Text('Matara')),
  DropdownMenuItem(value: 'Monaragala', child: Text('Monaragala')),
  DropdownMenuItem(value: 'Mullaitivu', child: Text('Mullaitivu')),
  DropdownMenuItem(value: 'Nuwara Eliya', child: Text('Nuwara Eliya')),
  DropdownMenuItem(value: 'Polonnaruwa', child: Text('Polonnaruwa')),
  DropdownMenuItem(value: 'Puttalam', child: Text('Puttalam')),
  DropdownMenuItem(value: 'Ratnapura', child: Text('Ratnapura')),
  DropdownMenuItem(value: 'Trincomalee', child: Text('Trincomalee')),
  DropdownMenuItem(value: 'Vavuniya', child: Text('Vavuniya')),

              ],
              onChanged: (value) {},
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Find Eligible Universities'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}