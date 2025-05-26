import 'package:flutter/material.dart';
import 'package:uni_selector/main.dart';
import 'add_university_screen.dart';
import 'delete_university_screen.dart';
import 'home_screen.dart'; 

class AdminPanelScreen extends StatelessWidget {
const AdminPanelScreen({super.key});

void _goToHome(BuildContext context) {
Navigator.pushAndRemoveUntil(
context,
MaterialPageRoute(builder: (context) => const HomeScreen()),
(route) => false, // remove all previous routes
);
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text('Admin Panel'),
actions: [
IconButton(
icon: const Icon(Icons.logout),
tooltip: 'Logout',
onPressed: () => _goToHome(context),
),
],
),
body: Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
ElevatedButton(
child: const Text('Add/Update University'),
onPressed: () {
Navigator.push(
context,
MaterialPageRoute(builder: (context) => const AddUniversityScreen()),
);
},
),
const SizedBox(height: 16),
ElevatedButton(
child: const Text('Delete University'),
onPressed: () {
Navigator.push(
context,
MaterialPageRoute(builder: (context) => const DeleteUniversityScreen()),
);
},
),
const SizedBox(height: 16),
ElevatedButton(
child: const Text('Log out'),
onPressed: () {
Navigator.push(
context,
MaterialPageRoute(builder: (context) => const MyApp()),
);
},
),
],
),
),
);
}
}