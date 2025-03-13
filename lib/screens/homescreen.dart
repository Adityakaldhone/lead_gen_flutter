import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lead_gen/controllers/lead_form_controller.dart';
import 'package:lead_gen/controllers/navigation.dart';
import 'package:lead_gen/screens/coming_soon.dart';
import 'package:lead_gen/screens/leadform_bottomsheet.dart';
import 'package:lead_gen/screens/navbar.dart';
import 'package:lead_gen/uiComponents/leadListview.dart';

class HomeScreen extends StatelessWidget {
  final NavigationController navController = Get.put(NavigationController());

   HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevents Bottom Overflow Error
      body: Obx(() {
        // Wrap only the part that changes dynamically
        switch (navController.selectedIndex.value) {
          case 0:
            return LeadListView(); // Only LeadListView needs to be inside Obx()
          case 1:
            return const ComingSoonScreen();
          case 2:
            return const ComingSoonScreen();
          case 3:
            return const ComingSoonScreen();
          case 4:
            return const ComingSoonScreen();
          default:
            return const ComingSoonScreen();
        }
      }),

     floatingActionButton: FloatingActionButton(
  onPressed: () {
    if (!Get.isRegistered<LeadFormController>()) {
      Get.put(LeadFormController());
    }
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows full height and scrolling
      shape:const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) =>const LeadFormBottomSheet(),
    );
  },
  backgroundColor: Colors.deepPurple,
  shape:const CircleBorder(),
  child:const Icon(Icons.add, color: Colors.white, size: 36),
),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar:const BottomNavBar(),
    );
  }
}
