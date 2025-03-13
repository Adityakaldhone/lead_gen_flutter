import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple, // Background color
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 🟣 App Logo or Icon
             const Icon(
                Icons.hourglass_empty,
                size: 100,
                color: Colors.white,
              ),
             const SizedBox(height: 20),

              // 🔥 "Coming Soon" Text with Styling
             const Text(
                "Coming Soon...",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
             const SizedBox(height: 10),

              // 📢 Short Description
            const  Text(
                "We're working hard to bring something amazing for you. Stay tuned!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
             const SizedBox(height: 30),

              // ⏳ Optional Countdown Timer (Static Example)
            const  Text(
                "Launching in: 10 Days",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            const  SizedBox(height: 40),

              // 🚀 Action Button (e.g., Go Back or Notify Me)
              ElevatedButton(
                onPressed: () {
                  Get.back(); // Navigates back
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Button color
                  padding:const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child:const Text(
                  "Notify Me",
                  style: TextStyle(color: Colors.deepPurple, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
