import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lead_gen/controllers/navigation.dart';


class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController navController = Get.put(NavigationController());

    return Obx(() => BottomAppBar(
          color: Colors.white,
          shadowColor: Colors.grey,
          // shape: CircularNotchedRectangle(), // Notch for FAB
          // notchMargin: 8.0, // Space between FAB and BottomAppBar
          child: Container(
            height: 75, // Increased height for bottom navigation bar
            padding:const EdgeInsets.symmetric(
                horizontal: 10), // Added padding for better spacing
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Increased Icon Size
                IconButton(
                  icon:const Icon(Icons.home, size: 32), // Increased icon size
                  onPressed: () => navController.changeTabIndex(0),
                  color: navController.selectedIndex.value == 0
                      ? Colors.deepPurple
                      : Colors.grey,
                ),
                IconButton(
                  icon:const Icon(Icons.campaign, size: 32), // Increased icon size
                  onPressed: () => navController.changeTabIndex(1),
                  color: navController.selectedIndex.value == 1
                      ? Colors.deepPurple
                      : Colors.grey,
                ),

               const SizedBox(width: 60), // Increased space for Floating Button

                IconButton(
                  icon:const Icon(Icons.notifications,
                      size: 32), // Increased icon size
                  onPressed: () => navController.changeTabIndex(3),
                  color: navController.selectedIndex.value == 3
                      ? Colors.deepPurple
                      : Colors.grey,
                ),
                IconButton(
                  icon:const Icon(Icons.grid_view, size: 32), // Increased icon size
                  onPressed: () => navController.changeTabIndex(4),
                  color: navController.selectedIndex.value == 4
                      ? Colors.deepPurple
                      : Colors.grey,
                ),
              ],
            ),
          ),
        ));
  }
}
