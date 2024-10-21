import 'package:flutter/material.dart';
import 'dart:io'; // For working with File
import 'package:provider/provider.dart';
import 'submission_provider.dart';
import 'submission.dart';
import 'thank_you_page.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _imageUrl;

  List<String> imageUrls = [];
  List<String> descriptions = [];

  List<String> _tags = []; // List of selected tags
  bool _showDropdown = false;

  final List<String> _availableTags = [
    'Literature',
    '3D Art and Design',
    'Article Review',
    'Science Research',
  ];

  // Function to save the entered data
  void _saveData() {
    String title = _titleController.text;
    String description = _descriptionController.text;

    String imageUrl = _imageUrl ??
        'https://via.placeholder.com/150'; // Placeholder if no image is provided

    // Create a new Submission object
    Submission submission = Submission(
      title: title,
      description: description,
      imageUrl: imageUrl,
    );

    // Use Provider to update the list of submissions
    Provider.of<SubmissionProvider>(context, listen: false)
        .addSubmission(submission);

    // Navigate to the ThankYouPage
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ThankYouPage(
          imageUrls: imageUrls,
          descriptions: descriptions,
        ),
      ),
    );
  }

  // Function to add a tag to the list
  void _addTag(String tag) {
    if (!_tags.contains(tag)) {
      setState(() {
        _tags.add(tag);
        _showDropdown = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Dismiss keyboard on tap outside
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 54),
                const Text(
                  'Add Your Submission',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                _buildTextField(_titleController, 'Enter title', 40),
                const SizedBox(height: 12),
                _buildTextField(
                    _descriptionController, 'Enter description', 200),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _imageUrl =
                          'https://via.placeholder.com/300'; // Simulate image upload
                    });
                  },
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _imageUrl == null
                        ? const Center(
                            child: Text('Upload Image',
                                style: TextStyle(color: Colors.black54)))
                        : Image.network(_imageUrl!, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 16),
                _buildTagsSection(),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _saveData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300], // Background color
                    minimumSize: const Size(150, 50),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF7FA643),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Method to build the text fields
  Widget _buildTextField(
      TextEditingController controller, String hintText, double height) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        maxLines: height == 30 ? 1 : null,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    );
  }

  // Method to build the tags section
  Widget _buildTagsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _showDropdown = !_showDropdown;
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Text('Tags',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF7FA643), width: 2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.add,
                          size: 14, color: Color(0xFF7FA643)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Wrap(
                alignment: WrapAlignment.start,
                spacing: 8.0,
                children: _tags.map((tag) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(tag,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _tags.remove(tag);
                            });
                          },
                          child: const Icon(Icons.close,
                              size: 16, color: Colors.black54),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        if (_showDropdown)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: _availableTags.map((tag) {
                return ListTile(
                  title: Text(tag),
                  onTap: () {
                    _addTag(tag);
                  },
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
