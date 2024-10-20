// lib/profile_page.dart
import 'package:flutter/material.dart';
import 'dart:ui';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
              padding: const EdgeInsets.all(16.0),
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
                      // backgroundImage: NetworkImage(
                      //   'https://your-image-url.com', // Replace with actual image URL
                      // ),
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
                          onPressed: () {},
                          label: const Text(
                            'Following',
                            style: TextStyle(
                                color: Colors.black), // Set text color to black
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFF7FA643), // Green color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            minimumSize: const Size(
                                200, 50), // Set minimum width and height
                          ),
                        ),
                        const SizedBox(width: 5),
                        // Add Icon
                        ElevatedButton(
                          onPressed: () {},
                          child: const Icon(
                            Icons.add,
                            color: Color(0xFF7FA643),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: const EdgeInsets.all(10),
                            backgroundColor: Colors.grey[300],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Grid View Section (Placeholder)
            Padding(
              padding: const EdgeInsets.all(16.0),
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
