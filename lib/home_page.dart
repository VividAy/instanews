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
  List<String> _descriptions = []; // List of image descriptions
  String _selectedItem = 'Literature'; // Track the selected top bar item
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _loadImagesAndDescriptions(); // Load the initial set of images and descriptions
  }

  // Function to load 10 images and their descriptions at a time
  void _loadImagesAndDescriptions() {
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

    List<String> newDescriptions = [
      'This image captures a stunning sunset over a mountain range, where the sky is painted with vibrant orange and pink hues. The shadows of the peaks create a dramatic contrast, making the scene look like a masterpiece of nature. It evokes a sense of tranquility and awe, perfect for those who appreciate nature’s beauty.',
      'A serene lake mirrors the surrounding forest and sky in this tranquil scene. The water’s surface is so still that the trees and clouds create a near-perfect reflection, blending reality with illusion. This peaceful setting invites viewers to pause, reflect, and enjoy the natural beauty away from the hustle and bustle of daily life.',
      'The image showcases a bustling cityscape during nighttime, with streets reflecting the vibrant lights of the skyscrapers. Neon signs and glowing windows illuminate the scene, giving a sense of the city’s energy and life. This visual captures the fast-paced rhythm of urban life, highlighting the contrast between the bright lights and the dark sky.',
      'A field of colorful wildflowers stretches as far as the eye can see, each bloom adding a vibrant touch to the landscape. The variety of red, yellow, and purple flowers sways gently with the breeze under a clear sky. It’s a scene that embodies the joy and renewal of spring, inviting viewers to immerse themselves in the beauty of nature.',
      'A lone tree stands defiantly against a dark and stormy sky, its branches swaying in the wind. The dramatic clouds gather ominously above, hinting at a powerful storm brewing. This image captures the resilience of nature amidst adversity, reminding viewers of the strength and perseverance required to weather life’s challenges.',
      'A snow-covered mountain peak rises majestically against a backdrop of golden morning light. The first rays of dawn touch the summit, creating a stunning contrast between the white snow and the warm, golden hues. It’s a breathtaking scene that symbolizes new beginnings and the beauty that lies in remote, untouched places.',
      'The beach is bathed in the soft glow of dusk, with gentle waves rolling onto the sandy shore. The horizon blends seamlessly with the colors of the setting sun, creating a peaceful and calming atmosphere. This scene is perfect for those who love the ocean, offering a serene escape from the demands of daily life.',
      'A thick fog blankets a dense forest, creating an air of mystery and intrigue. The trees fade into the mist, giving the impression that the forest stretches infinitely. This image evokes a sense of wonder and curiosity, as if inviting viewers to step into an unexplored world where anything might be possible.',
      'The night sky comes alive with a stunning display of stars over a quiet desert landscape. The Milky Way arcs across the sky, its glow highlighting the vastness of the universe. The serene and desolate desert below contrasts with the brilliance above, making this scene a reminder of our place in the cosmos.',
      'A quaint village nestled in rolling hills is adorned with vibrant autumn colors. The golden and red leaves create a warm and inviting atmosphere, with cottages dotting the landscape. This scene captures the charm of rural life in autumn, where nature and community come together to create a picturesque and comforting setting.',
    ];

    // Append the new images and descriptions to the current lists
    setState(() {
      _imageUrls.addAll(newImages);
      _descriptions.addAll(newDescriptions);
    });
  }

  // Fetch more images and descriptions once the user reaches the 10th page
  void _onPageChanged(int index) {
    _currentPage = index;
    if (_currentPage == _imageUrls.length - 1) {
      _loadImagesAndDescriptions(); // Load the next set of 10 images and descriptions when the user reaches the last image
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
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(
                        16.0), // Rounded edges for the image
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
        const SizedBox(height: 16), // Add some space between the containers
        // Second Container (showing the description)
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0), // Uniform left and right padding
            child: Container(
              width: double.infinity, // Make it take up full width
              decoration: BoxDecoration(
                color: Colors.grey[300], // Grey color for the second container
                borderRadius: BorderRadius.circular(16.0), // Rounded corners
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(
                      16.0), // Uniform padding inside the description container
                  child: Text(
                    _descriptions[index],
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
