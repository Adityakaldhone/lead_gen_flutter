// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lead_gen/controllers/lead_form_controller.dart';
// import 'package:lead_gen/screens/homescreen.dart';

// void main() {
//    WidgetsFlutterBinding.ensureInitialized(); // Ensures Flutter is fully initialized
//   runApp(const MainApp());
// }

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Get.put(LeadFormController()); // Initializes controller at the start
//     return  GetMaterialApp(
//       home:HomeScreen(),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase
import 'package:lead_gen/controllers/lead_form_controller.dart';
import 'package:lead_gen/screens/homescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures Flutter is fully initialized

  // Initialize Firebase
  await Firebase.initializeApp();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LeadFormController()); // Initializes controller at the start
    return GetMaterialApp(
      debugShowCheckedModeBanner: false, // Removes debug banner
      title: 'LeadGen',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple, // Set primary theme color
      ),
      home: HomeScreen(),
    );
  }
}
