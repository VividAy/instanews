import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Initially set isFollowing to false
  bool isFollowing = false;

  @override
  void initState() {
    super.initState();
    _loadFollowingState(); // Load the following state when the page is initialized
  }

  // Load the saved following state from SharedPreferences
  Future<void> _loadFollowingState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isFollowing = prefs.getBool('isFollowing') ??
          false; // Default to false if no value found
    });
  }

  // Save the following state to SharedPreferences
  Future<void> _saveFollowingState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isFollowing', isFollowing);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Section
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 70.0, 16.0, 0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Profile Image (Circular)
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey[300],
                    ),
                    const SizedBox(height: 16),
                    // User Name
                    const Text(
                      'Yuvraj Chaudhary',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Description
                    const Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    const SizedBox(height: 16),
                    // Following Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            // Toggle the following state
                            setState(() {
                              isFollowing = !isFollowing;
                              _saveFollowingState(); // Save the state when changed
                            });
                          },
                          label: Text(
                            isFollowing ? 'Following' : 'Follow',
                            style: const TextStyle(color: Colors.black),
                          ),
                          icon: Icon(
                            isFollowing
                                ? Icons.check
                                : Icons.add, // Change icon
                            color: Colors.black,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isFollowing
                                ? const Color(0xFF7FA643)
                                : Colors.grey, // Change color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            minimumSize: const Size(200, 50), // Set size
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Grid View Section (Placeholder)
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 12, // Number of items in the grid
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300], // Grey placeholder color
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
