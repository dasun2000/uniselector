import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'home_screen.dart';
import 'degrees_screen.dart';
import 'careers_screen.dart';
import 'search_screen.dart' show SearchScreen;
import 'university_detail_screen.dart' show UniversityDetailScreen;
import 'admin_login_screen.dart'; // <-- Import your AdminLoginScreen here

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  late Future<List<DocumentSnapshot>> _universitiesFuture;

  @override
  void initState() {
    super.initState();
    _universitiesFuture = _fetchUniversities();
  }

  Future<List<DocumentSnapshot>> _fetchUniversities() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('universities')
          .limit(10)
          .get();
      return querySnapshot.docs;
    } catch (e) {
      print('Error fetching universities: $e');
      return [];
    }
  }

  Widget _buildHeaderTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 60, bottom: 20),
      child: Column(
        children: [
          GestureDetector(
            onLongPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AdminLoginScreen(),
                ),
              );
            },
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                ).createShader(bounds);
              },
              child: const Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Explore Top Universities in Sri Lanka',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageCarousel() {
    final List<String> imageUrls = [
      'https://t3.ftcdn.net/jpg/03/67/97/90/360_F_367979072_UdBgmIp2RuFgLsbruOMBVmruR6jCDqfX.jpg',
      'https://media.istockphoto.com/id/1390975349/photo/multiracial-group-of-happy-students-talking-and-having-fun-after-the-lecture-at-campus.jpg?s=612x612&w=0&k=20&c=JGoKREcZNuwpqlc-CUGKR6Y9I0kJp5ycIc_idW6SXIs=',
      'https://cdn.vysokeskoly.cz/czech-universities/uploads/2020/08/czech_University_Students.jpg',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 180,
          autoPlay: true,
          enlargeCenterPage: true,
          viewportFraction: 0.85,
          autoPlayInterval: const Duration(seconds: 3),
        ),
        items: imageUrls.map((url) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              url,
              fit: BoxFit.cover,
              width: double.infinity,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey[300],
                child: const Icon(Icons.image, size: 40),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildUniversityPreview() {
    return FutureBuilder<List<DocumentSnapshot>>(
      future: _universitiesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 150,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
          return const SizedBox(); // empty if no data
        }

        final universities = snapshot.data!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Featured Universities',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: universities.length,
                itemBuilder: (context, index) {
                  final university =
                      universities[index].data() as Map<String, dynamic>;

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => UniversityDetailScreen(
                            university: university,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 140,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 6,
                            offset: const Offset(2, 4),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12)),
                            child: university['imageUrls'] != null &&
                                    (university['imageUrls'] as List)
                                        .isNotEmpty
                                ? Image.network(
                                    university['imageUrls'][0],
                                    height: 100,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    height: 100,
                                    color: Colors.grey[200],
                                    child: const Icon(Icons.school, size: 40),
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              university['name'] ?? 'University',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          if (_currentIndex == 0) _buildHeaderTitle(),
          Expanded(child: _screens[_currentIndex]),
          if (_currentIndex == 0) ...[
            _buildImageCarousel(),
            _buildUniversityPreview(),
          ],
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Degrees',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Careers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
      ),
    );
  }

  final List<Widget> _screens = [
    const HomeScreen(),
    const DegreeScreen(),
    const CareersScreen(),
    const SearchScreen(),
  ];
}
