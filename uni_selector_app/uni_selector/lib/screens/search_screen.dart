import 'package:flutter/material.dart';


class University {
  final String name;
  final String type; 
  final String location;
  final String description;
  final List<String> images;
  final String? establishedYear;
  final String? website;
  final List<String>? faculties;

  University({
    required this.name,
    required this.type,
    required this.location,
    required this.description,
    required this.images,
    this.establishedYear,
    this.website,
    this.faculties,
  });
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  University? _selectedUniversity;
  bool _isSearching = false;

  
  final List<University> _universities = [
    University(
      name: 'University of Colombo',
      type: 'Government',
      location: 'Colombo, Sri Lanka',
      establishedYear: '1921',
      website: 'https://cmb.ac.lk/',
      description: 'The University of Colombo is a public research university located primarily in Colombo, Sri Lanka. It is the oldest institution of modern higher education in Sri Lanka.',
      images: [
        'https://www.studyinsrilanka.org/wp-content/uploads/2015/01/UoC_nameboard.jpg',
        'https://bmkltsly13vb.compat.objectstorage.ap-mumbai-1.oraclecloud.com/cdn.ft.lk/assets/uploads/image_2430015340.jpg',
      ],
      faculties: [
        'Faculty of Arts',
        'Faculty of Science',
        'Faculty of Medicine',
        'Faculty of Law',
        'Faculty of Management and Finance',
      ],
    ),
    University(
      name: 'University of Peradeniya',
      type: 'Government',
      location: 'Peradeniya, Sri Lanka',
      establishedYear: '1942',
      website: 'https://www.pdn.ac.lk/',
      description: 'The University of Peradeniya is a public university in Sri Lanka, funded by the University Grants Commission. It is the largest university in Sri Lanka by area.',
      images: [
        'https://rasakatha.lk/wp-content/uploads/2024/04/WhatsApp-Image-2024-04-18-at-2.54.14-PM-1.jpeg',
        'https://island.lk/wp-content/uploads/2024/07/Peradeniya.jpg',
        'https://www.attractionsinsrilanka.com/wp-content/uploads/2019/07/University-of-Peradeniya.jpg',
      ],
      faculties: [
        'Faculty of Arts',
        'Faculty of Science',
        'Faculty of Medicine',
        'Faculty of Engineering',
        'Faculty of Agriculture',
      ],
    ),
    University(
      name: 'University of Moratuwa',
      type: 'Government',
      location: 'Moratuwa, Sri Lanka',
      establishedYear: '1972',
      website: 'https://uom.lk/',
      description: 'The University of Moratuwa is a public university in Sri Lanka. It is most renowned for its engineering degrees, especially in the fields of civil, mechanical, electrical and computer engineering.',
      images: [
        'https://www.yesman.lk/assets/img/institutes/uom_cover-1557562542.jpg',
        'https://uom.lk/sites/default/files/Faculty/Business/slideshow/1.jpg',
        'https://adaderanaenglish.s3.amazonaws.com/1595500106-Medical-faculty-to-be-established-at-Moratuwa-University-L.jpg',
      ],
      faculties: [
        'Faculty of Architecture',
        'Faculty of Engineering',
        'Faculty of Information Technology',
      ],
    ),
    University(
      name: 'SLIIT University',
      type: 'Private',
      location: 'Malabe, Sri Lanka',
      establishedYear: '1999',
      website: 'https://www.sliit.lk/',
      description: 'SLIIT is the largest degree awarding institute in Sri Lanka recognized by the University Grants Commission under the Universities Act. It offers degrees in IT, Business, Engineering and more.',
      images: [
        'https://static.sliit.lk/wp-content/uploads/2018/03/slit-a.2.jpg',
        'https://static.sliit.lk/wp-content/uploads/2022/06/25130337/The-Inauguration-Ceremony-for-the-new-batch-of-University-of-Queensland-Programmes-at-SLIIT-7.jpg',
        'https://static.sliit.lk/wp-content/uploads/2023/07/07114655/Jaffna-Welcomes-SLIIT-Northern-Unis-State-of-the-Art-Campus-A-New-Chapter-in-Higher-Education-1.jpg',
      ],
      faculties: [
        'Faculty of Computing',
        'Faculty of Business',
        'Faculty of Engineering',
        'Faculty of Humanities & Sciences',
      ],
    ),
    University(
      name: 'NSBM Green University',
      type: 'Private',
      location: 'Pitipana, Homagama, Sri Lanka',
      establishedYear: '2016',
      website: 'https://www.nsbm.ac.lk/',
      description: 'NSBM Green University is Sri Lankas first green university and the first government-owned private university. It offers degrees in Management, Computing, Engineering and more.',
      images: [
        'https://educationdesign.com/wp-content/uploads/2023/07/Thumb.jpg',
        'https://static.brandfinance.com/wp-content/uploads/2023/09/NSBM-A4-1600x1200.jpg',
        'https://upload.wikimedia.org/wikipedia/commons/4/4d/NSBM_Green_University_Sri_Lanka.jpg',
      ],
      faculties: [
        'Faculty of Business',
        'Faculty of Computing',
        'Faculty of Engineering',
        'Faculty of Sciences',
      ],
    ),
    University(
      name: 'University of Kelaniya',
      type: 'Government',
      location: 'Kelaniya, Sri Lanka',
      establishedYear: '1959',
      website: 'https://www.kln.ac.lk/',
      description: 'The University of Kelaniya is a public university in Sri Lanka. It has a strong reputation for humanities, social sciences and medicine.',
      images: [
        'https://units.kln.ac.lk/qac/images/2021/11/08/8b8703b3-0d6387aa-kelaniya-uni-_850x460_acf_cropped.jpg',
        'https://cdce.kln.ac.lk/images/2022/11/02/fom_ot_edit.png',
        'https://fcms.kln.ac.lk/edu/mcom/images/2023/09/18/slide-c6s.jpg',
      ],
      faculties: [
        'Faculty of Humanities',
        'Faculty of Science',
        'Faculty of Medicine',
        'Faculty of Commerce and Management Studies',
      ],
    ),
    University(
      name: 'Informatics Institute of Technology (IIT)',
      type: 'Private',
      location: 'Colombo, Sri Lanka',
      establishedYear: '1990',
      website: 'https://www.iit.ac.lk/',
      description: 'IIT is a leading higher education institute in Sri Lanka offering British degrees in IT, Business and Engineering in collaboration with top UK universities.',
      images: [
        'https://www.iit.ac.lk/wp-content/uploads/2022/08/hostory.jpg',
        'https://www.iit.ac.lk/wp-content/uploads/2022/08/ezgif.com-gif-maker-69.jpg',
        'https://bmkltsly13vb.compat.objectstorage.ap-mumbai-1.oraclecloud.com/cdn.ft.lk/assets/uploads/image_47b54eeb39.jpg',
      ],
      faculties: [
        'School of Computing',
        'School of Business',
        'School of Engineering',
      ],
    ),
  ];

  void _searchUniversity() {
    setState(() {
      _isSearching = true;
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      final searchQuery = _searchController.text.toLowerCase().trim();
      
      if (searchQuery.isEmpty) {
        setState(() {
          _selectedUniversity = null;
          _isSearching = false;
        });
        return;
      }

      final university = _universities.firstWhere(
        (uni) => uni.name.toLowerCase().contains(searchQuery),
        orElse: () => University(
          name: 'University Not Found',
          type: 'N/A',
          location: 'N/A',
          description: 'Sorry, we couldn\'t find a university matching your search. Please try a different name.',
          images: [],
        ),
      );

      setState(() {
        _selectedUniversity = university;
        _isSearching = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sri Lankan Universities',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade50,
              Colors.white,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search Sri Lankan universities...',
                      prefixIcon: const Icon(Icons.search, color: Colors.blue),
                      border: InputBorder.none,
                      suffixIcon: _isSearching
                          ? const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                            )
                          : null,
                    ),
                    onSubmitted: (_) => _searchUniversity(),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Type university name and press Enter to search',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              
              if (_selectedUniversity != null) ...[
                _buildUniversityDetails(_selectedUniversity!),
              ] else ...[
                
                const Text(
                  'Sri Lankan University Stats',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        title: 'Government Universities',
                        value: '15',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildStatCard(
                        title: 'Private Universities',
                        value: '10+',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                
                const Text(
                  'Popular Universities',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 120,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildUniversityChip('Colombo'),
                      _buildUniversityChip('Peradeniya'),
                      _buildUniversityChip('Moratuwa'),
                      _buildUniversityChip('Kelaniya'),
                      _buildUniversityChip('SLIIT'),
                      _buildUniversityChip('NSBM'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                
                const SizedBox(height: 12),
                
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUniversityDetails(University university) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'University Details',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _selectedUniversity = null;
                      _searchController.clear();
                    });
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      university.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.business, color: Colors.grey[600], size: 18),
                        const SizedBox(width: 8),
                        Text(
                          'Type: ${university.type}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.grey[600], size: 18),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            university.location,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (university.establishedYear != null) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.calendar_today, color: Colors.grey[600], size: 18),
                          const SizedBox(width: 8),
                          Text(
                            'Established: ${university.establishedYear}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                    if (university.website != null) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.language, color: Colors.grey[600], size: 18),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              // TODO: Launch website URL
                            },
                            child: Text(
                              'Website: ${university.website}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue[700],
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 16),
                    Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      university.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        height: 1.5,
                      ),
                    ),
                    if (university.faculties != null && university.faculties!.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Text(
                        'Faculties',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: university.faculties!.map((faculty) {
                          return Chip(
                            label: Text(faculty),
                            backgroundColor: Colors.blue[50],
                            labelStyle: TextStyle(
                              color: Colors.blue[800],
                              fontSize: 14,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            
            
            if (university.images.isNotEmpty) ...[
              const SizedBox(height: 20),
              Text(
                'University Images',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: university.images.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 300,
                      margin: const EdgeInsets.only(right: 16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          university.images[index],
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[200],
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.error, size: 40, color: Colors.red),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Failed to load image',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
            
            const SizedBox(height: 20),
            
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UniversityDetailScreen(
                        university: university,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'View Full Details',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    String? growth,
    String? secondaryValue,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (secondaryValue != null) ...[
              const SizedBox(height: 4),
              Text(
                secondaryValue,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
            if (growth != null) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  growth,
                  style: TextStyle(
                    color: Colors.green[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTypeFilter(String label) {
    return FilterChip(
      label: Text(label),
      selected: false,
      onSelected: (bool value) {
        setState(() {
          if (value) {
            _selectedUniversity = _universities.firstWhere(
              (uni) => uni.type == label,
              orElse: () => University(
                name: 'No $label universities found',
                type: 'N/A',
                location: 'N/A',
                description: 'No $label universities available in the database.',
                images: [],
              ),
            );
          } else {
            _selectedUniversity = null;
          }
        });
      },
      selectedColor: Colors.blue[100],
      checkmarkColor: Colors.blue,
      labelStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _buildUniversityChip(String name) {
    return GestureDetector(
      onTap: () {
        _searchController.text = name;
        _searchUniversity();
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.blue[200]!),
        ),
        child: Text(
          name,
          style: TextStyle(
            color: Colors.blue[800],
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class UniversityDetailScreen extends StatelessWidget {
  final University university;

  const UniversityDetailScreen({
    super.key,
    required this.university,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(university.name),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade600, Colors.blue.shade800],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      university.name,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.business, color: Colors.white70, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Type: ${university.type}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.white70, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            university.location,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (university.establishedYear != null) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, color: Colors.white70, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'Established: ${university.establishedYear}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                    if (university.website != null) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.language, color: Colors.white70, size: 20),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              // TODO: Launch website URL
                            },
                            child: Text(
                              'Website: ${university.website}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.description, color: Colors.blue[600], size: 24),
                        const SizedBox(width: 8),
                        const Text(
                          'About University',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      university.description,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            
            if (university.faculties != null && university.faculties!.isNotEmpty) ...[
              const SizedBox(height: 20),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.school, color: Colors.purple[600], size: 24),
                          const SizedBox(width: 8),
                          const Text(
                            'Faculties & Departments',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: university.faculties!.map<Widget>((faculty) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              '• $faculty',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            
            const SizedBox(height: 20),
            
            
            if (university.images.isNotEmpty) ...[
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.photo_library, color: Colors.green[600], size: 24),
                          const SizedBox(width: 8),
                          const Text(
                            'University Gallery',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 220,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: university.images.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 300,
                              margin: const EdgeInsets.only(right: 16),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  university.images[index],
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress.expectedTotalBytes != null
                                            ? loadingProgress.cumulativeBytesLoaded /
                                                loadingProgress.expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey[200],
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.error, size: 40, color: Colors.red),
                                          const SizedBox(height: 8),
                                          Text(
                                            'Failed to load image',
                                            style: TextStyle(color: Colors.grey[600]),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}