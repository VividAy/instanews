import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _selectedItem = 'Literature'; // Track the selected top bar item
  int _selectedIndex = 0; // Track the selected index for bottom nav

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex =
          index; // Update the selected index when an item is clicked
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Horizontal scrolling top bar
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Container(
              // height: 50.0, // Fixed height for the top bar
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
          ),
          // Grey box with rounded corners
          Expanded(
            // Proper use of Expanded to fill the remaining space
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex, // Highlight selected icon
        selectedItemColor: Colors.red, // Red color for selected item
        unselectedItemColor: Colors.grey, // Grey color for unselected items
        onTap: _onItemTapped, // Update index on tap
        showSelectedLabels: false,
        showUnselectedLabels: false,
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
            color: isSelected ? Colors.red : Colors.grey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
