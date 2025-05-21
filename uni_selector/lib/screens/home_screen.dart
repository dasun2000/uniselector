import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UNIVISION'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            children: [
              SizedBox(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    const SizedBox(width: 4),
                    FeatureCard(
                      icon: Icons.search,
                      title: 'University\nSearch',
                      cardWidth: 90,
                    ),
                    const SizedBox(width: 10),
                    FeatureCard(
                      icon: Icons.school,
                      title: 'Degree\nFinder',
                      cardWidth: 90,
                    ),
                    const SizedBox(width: 10),
                    FeatureCard(
                      icon: Icons.assessment,
                      title: 'Z-Score\nAnalysis',
                      cardWidth: 90,
                    ),
                    const SizedBox(width: 10),
                    FeatureCard(
                      icon: Icons.work,
                      title: 'Career\nGuidance',
                      cardWidth: 90,
                    ),
                    const SizedBox(width: 4),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final double cardWidth;
  final bool isActive;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    this.cardWidth = 80,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: cardWidth,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: isActive ? Colors.blue : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 24,
                color: isActive ? Colors.white : Colors.blue,
              ),
              const SizedBox(height: 6),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: isActive ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}