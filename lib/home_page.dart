import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // For launching URLs in a browser

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController _pageController =
      PageController(); // Controller for PageView
  List<String> _imageUrls = []; // List of image URLs
  String _selectedItem = 'Literature'; // Track the selected top bar item
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _loadImages(); // Load the initial set of images
  }

  // Function to load 10 images at a time
  void _loadImages() {
    List<String> newImages = [
      // Add 10 image URLs here for demonstration
      'https://media.cnn.com/api/v1/images/stellar/prod/ap24294169788999-copy.jpg?c=16x9&q=h_653,w_1160,c_fill/f_webp',
      'https://picsum.photos/300/200?image=2',
      'https://picsum.photos/300/200?image=3',
      'https://picsum.photos/300/200?image=4',
      'https://picsum.photos/300/200?image=5',
      'https://picsum.photos/300/200?image=6',
      'https://picsum.photos/300/200?image=7',
      'https://picsum.photos/300/200?image=8',
      'https://picsum.photos/300/200?image=9',
      'https://picsum.photos/300/200?image=10',
    ];

    // Append the new images to the current list
    setState(() {
      _imageUrls.addAll(newImages);
    });
  }

  // Fetch more images once the user reaches the 10th page
  void _onPageChanged(int index) {
    _currentPage = index;
    if (_currentPage == _imageUrls.length - 1) {
      _loadImages(); // Load the next set of 10 images when the user reaches the last image
    }
  }

  // Function to show a dialog when swiping right
  Future<void> _showLeaveDialog() async {
    bool shouldLeave = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Leave the App?'),
          content: const Text('Do you want to open a webpage?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Stay in the app
              },
              child: const Text('Stay'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Leave the app
              },
              child: const Text('Leave'),
            ),
          ],
        );
      },
    );

    if (shouldLeave) {
      const url = 'https://www.cnn.com/2024/10/20/americas/cuba-blackout-third-day-failed-restore-intl/index.html'; // Example URL
      if (await canLaunch(url)) {
        await launch(url); // Open the URL in an external browser
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            // Swipe right detected
            _showLeaveDialog();
          }
        },
        child: Column(
          children: [
            // Horizontal scrolling top bar
            Padding(
              padding:
                  const EdgeInsets.only(top: 65.0), // Only top padding here
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
            // PageView for swipe-up containers
            Expanded(
              child: PageView.builder(
                scrollDirection: Axis.vertical, // Enable vertical scrolling
                controller: _pageController,
                onPageChanged:
                    _onPageChanged, // Detect when the user changes page
                itemBuilder: (context, index) {
                  // If no more images are available, display a loading indicator
                  if (index >= _imageUrls.length) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return _buildPage(index); // Build each page
                },
                itemCount:
                    _imageUrls.length + 1, // Add 1 for the loading indicator
              ),
            ),
          ],
        ),
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
        padding: const EdgeInsets.symmetric(
            horizontal: 7.0), // Horizontal padding between items
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

  // Function to build each page for PageView
  Widget _buildPage(int index) {
    return Column(
      children: [
        // First Container (showing an image)
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 30, 16, 0),
          child: Container(
            width: double.infinity, // Make it take up full width
            height: 300, // Specify height for the first container
            decoration: BoxDecoration(
              color: Colors.grey[300], // Grey color for the box
              borderRadius: BorderRadius.circular(16.0), // Rounded corners
            ),
            child: _imageUrls[index].isNotEmpty
                ? Image.network(
                    _imageUrls[index],
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      );
                    },
                  )
                : const Center(child: Text('No image available')),
          ),
        ),
        const SizedBox(height: 16), // Add some space between the containers
        // Second Container
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
            child: Container(
              width: double.infinity, // Make it take up full width
              decoration: BoxDecoration(
                color: Colors.grey[300], // Grey color for the second container
                borderRadius: BorderRadius.circular(16.0), // Rounded corners
              ),
              child: const Center(
                child: Text(
                  'Container 2',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
