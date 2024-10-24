import 'package:flutter/material.dart';
import 'package:instanews/main.dart';

class ThankYouPage extends StatelessWidget {
  const ThankYouPage(
      {super.key,
      required List<String> imageUrls,
      required List<String> descriptions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // Ensures content doesn't get too close to notches
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment:
                CrossAxisAlignment.center, // Align center horizontally as well
            children: [
              const Text(
                'Thank you for your submission!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center, // Make sure text is centered
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MainPage()),
                  ); // Go back to the Home Page
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 24), // Add padding to the button
                  child: Text('Back to Home',
                      style: TextStyle(
                          fontSize:
                              16)), // Increase font size for better readability
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
