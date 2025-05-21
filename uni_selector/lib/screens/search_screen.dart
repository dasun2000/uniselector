import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextField(
          decoration: InputDecoration(
            hintText: 'Search universities...',
            border: InputBorder.none,
          ),
        ),
      ),
      body: const Center(
        child: Text(
          'Search Results',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}