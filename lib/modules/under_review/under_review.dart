import 'package:flutter/material.dart';

class UnderReviewPage extends StatelessWidget {
  const UnderReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon in Circle
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
              padding: const EdgeInsets.all(20),
              child: const Icon(
                Icons.access_time, // Clock icon
                size: 60,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            // Main Text
            const Text(
              'Under Review!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 50),
            // Progress Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Step 1: Completed
                Column(
                  children: const [
                    Icon(Icons.check_circle, color: Colors.green, size: 28),
                    SizedBox(height: 5),
                    Text('Step 1', style: TextStyle(color: Colors.white)),
                  ],
                ),
                Container(
                  width: 60,
                  height: 2,
                  color: Colors.white,
                ),
                // Step 2: In Progress
                Column(
                  children: const [
                    Icon(Icons.access_time, color: Colors.blue, size: 28),
                    SizedBox(height: 5),
                    Text('Step 2', style: TextStyle(color: Colors.white)),
                  ],
                ),
                Container(
                  width: 60,
                  height: 2,
                  color: Colors.white,
                ),
                // Step 3: Upcoming
                Column(
                  children: const [
                    Icon(Icons.circle_outlined,
                        color: Colors.grey, size: 28),
                    SizedBox(height: 5),
                    Text('Step 3', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Footer Text
            const Text(
              'Your Application Is\nUnder Review!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
