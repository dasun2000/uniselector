import 'package:flutter/material.dart';

class UniversityDetailScreen extends StatelessWidget {
  final Map<String, dynamic> university;

  const UniversityDetailScreen({
    Key? key,
    required this.university,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageUrls = university['imageUrls'] as List<dynamic>?;

    return Scaffold(
      appBar: AppBar(
        title: Text(university['name'] ?? 'University Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Image (first one)
            if (imageUrls != null && imageUrls.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageUrls[0],
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 80),
                ),
              ),

            const SizedBox(height: 25),

            // University Name
            Text(
              university['name'] ?? 'No Name Available',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            // Location and Type Row
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.blue[700]),
                const SizedBox(width: 5),
                Text(
                  university['location'] ?? 'Location not specified',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                const Spacer(),
                Icon(Icons.account_balance, color: Colors.blue[700]),
                const SizedBox(width: 5),
                Text(
                  university['type'] ?? 'Type not specified',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),

            const Divider(height: 30, thickness: 1),

            // Description Section
            const Text(
              'About',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              university['description'] ?? 'No description available',
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),

            const Divider(height: 30, thickness: 1),

            // Additional Images (2nd and 3rd)
            if (imageUrls != null && imageUrls.length > 1)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  imageUrls.length - 1,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        imageUrls[index + 1],
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image, size: 80),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
