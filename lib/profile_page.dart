import 'package:flutter/material.dart';
import 'data.dart'; // Assuming dataStorage is defined here

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<String> _links = []; // List to hold image URLs
  dataStorage str = dataStorage(); // Assuming this is your data source

  @override
  void initState() {
    super.initState();
    _loadImageLinks(); // Load image links when the page initializes
  }

  // Function to load image links
  // Function to load image links
Future<void> _loadImageLinks() async {
  List<String> newLinks = [];
  await str.fetchData(); // Ensure data is fetched before accessing it
  int lim = await str.getNumPkgs() - 1;

  // Loop through the data and add image links to the list
  for (; lim >= 0; lim--) {
    var data = await str.getData(lim); // Assuming getData is async
    newLinks.add(data.i); // Assuming .i gives the image URL
  }

  setState(() {
    _links = newLinks; // Update the state with the loaded image links
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey[300],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Yuvraj Chaudhary',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Displaying image links in GridView
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                shrinkWrap:
                    true, // Ensures the GridView doesn't take infinite height
                physics:
                    const NeverScrollableScrollPhysics(), // Disable scrolling inside GridView
                itemCount: _links.length, // Number of images
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 3 boxes per row
                  crossAxisSpacing: 10.0, // Spacing between boxes horizontally
                  mainAxisSpacing: 10.0, // Spacing between boxes vertically
                ),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        _links[index], // Load the image from _links list
                        fit: BoxFit.cover,
                      ),
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
