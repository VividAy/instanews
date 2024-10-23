import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // For launching URLs in a browser
import 'profile_page.dart';
import 'data.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  dataStorage datastore = dataStorage();
  List<String> _imageUrls = [];
  List<String> _titles = [];
  List<String> _descriptions = [];
  final PageController _pageController =
      PageController(); // Controller for PageView
  String _selectedItem = 'Literature'; // Track the selected top bar item
  int _currentPage = 0;
  List<bool> _likeStates = []; // Track like states for each post
  List<int> _likeCounts = []; // Track the number of likes for each post

  @override
  void initState() {
    super.initState();
    _loadImagesTitlesAndDescriptions(); // Load the initial set of images, titles, and descriptions
  }

  // Function to load 10 images, titles, and their descriptions at a time
  void _loadImagesTitlesAndDescriptions() {
    List<String> newImages = [];
    List<String> newTitles = [];
    List<String> newDescriptions = [];
    List<bool> newLikeStates = [];
    List<int> newLikeCounts = [];

    for (int i = 0; i < 10; i++) {
      newImages.add(datastore.getData(i).i);
      newTitles.add(datastore.getData(i).title);
      newDescriptions.add(datastore.getData(i).des);
      newLikeStates.add(false); // Initialize all new items as not liked
      newLikeCounts
          .add(0); // Initialize the like count as zero for each new item
    }

    // Append the new images, titles, descriptions, like states, and counts to the current lists
    setState(() {
      _imageUrls.addAll(newImages);
      _titles.addAll(newTitles);
      _descriptions.addAll(newDescriptions);
      _likeStates.addAll(newLikeStates);
      _likeCounts.addAll(newLikeCounts);
    });
  }

  // Fetch more images, titles, and descriptions once the user reaches the 10th page
  void _onPageChanged(int index) {
    _currentPage = index;
    if (_currentPage == _imageUrls.length - 1) {
      _loadImagesTitlesAndDescriptions(); // Load the next set of 10 images, titles, and descriptions when the user reaches the last image
    }
  }

  // Function to show a dialog when swiping right
  Future<void> _showLeaveDialog() async {
    bool shouldLeave = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Leave the App?'),
          content: const Text('Do you want to enter the te?'),
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
      const url =
          'https://www.cnn.com/2024/10/20/americas/cuba-blackout-third-day-failed-restore-intl/index.html'; // Example URL
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
          if (details.primaryVelocity! < 0) {
            // Swipe right detected
            _showLeaveDialog();
          }
        },
        child: Column(
          children: [
            // Horizontal scrolling top bar
            Padding(
              padding: const EdgeInsets.only(top: 65.0),
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
                scrollDirection: Axis.vertical,
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemBuilder: (context, index) {
                  if (index >= _imageUrls.length) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return _buildPage(index);
                },
                itemCount: _imageUrls.length + 1,
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

  // Function to build each page for PageView
  Widget _buildPage(int index) {
    return Column(
      children: [
        // First Container (showing an image)
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 30, 16, 0),
          child: Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: _imageUrls[index].isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.network(
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
                    ),
                  )
                : const Center(child: Text('No image available')),
          ),
        ),
        const SizedBox(height: 16),
        // Second Container (showing the title, description, profile, likes, and comments)
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _titles[index],
                          style: const TextStyle(
                            fontSize: 24.0, // Increased font size for the title
                            color: Color(0xFF7FA643), // Consistent with top bar
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _descriptions[index],
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Profile picture (bottom left)
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfilePage(),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                          'https://picsum.photos/200',
                        ),
                      ),
                    ),
                  ),
                  // Heart icon (bottom right)
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            _likeStates[index]
                                ? Icons.favorite
                                : Icons.favorite_border,
                          ),
                          color: _likeStates[index] ? Colors.red : Colors.grey,
                          onPressed: () {
                            setState(() {
                              _likeStates[index] = !_likeStates[index];
                              if (_likeStates[index]) {
                                _likeCounts[index]++;
                              } else {
                                _likeCounts[index]--;
                              }
                            });
                          },
                        ),
                        Text('${_likeCounts[index]}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
