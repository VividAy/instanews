import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _selectedItem = 'Literature'; // Track the selected top bar item

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Horizontal scrolling top bar
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildTopBarItem('3D Art and Design'),
                  _buildTopBarItem('Literature'),
                  _buildTopBarItem('Article Review'),
                  _buildTopBarItem('Science Research'),
                ],
              ),
            ),
          ),
          // Grey box with rounded corners
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16), // Add some padding
              child: Container(
                width: double.infinity, // Make it take up full width
                decoration: BoxDecoration(
                  color: Colors.grey[300], // Grey color for the box
                  borderRadius: BorderRadius.circular(16.0), // Rounded corners
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to build each top bar item
  Widget _buildTopBarItem(String label) {
    bool isSelected = _selectedItem == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedItem = label; // Update selected item
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7.0),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.0,
            color: isSelected ? Color(0xFF7FA643) : Colors.grey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
