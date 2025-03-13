// ignore: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lead_gen/controllers/lead_form_controller.dart';
import 'package:lead_gen/models/lead.dart';
import 'package:lead_gen/uiComponents/lead_card.dart';

class LeadListView extends StatelessWidget {
  final LeadFormController controller = Get.find();

   LeadListView({super.key}); // Get lead controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 2,
        shadowColor: Colors.grey.shade100,
        title:const Text(
          "Lead",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: Padding(
          padding:const EdgeInsets.all(12),
          child: CircleAvatar(
            backgroundColor: Colors.orange.shade300,
          ),
        ),
        actions: [
          IconButton(
            icon:const Icon(
              Icons.settings,
              color: Colors.grey,
              size: 35,
            ),
            onPressed: () {
              // Handle settings action
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("leads").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Show loading
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No leads added yet."));
          }

          var leads = snapshot.data!.docs.map((doc) {
            var data = doc.data() as Map<String, dynamic>;
            return Lead(
              docId: doc.id,
              emailUpdateDate: data["email_update_date"] ?? "no data found",
              name: data["name"] ?? "No Name",
              email: data["email"] ?? "No Email",
              mobileNumber: data["mobile_number"] ?? "No Phone",
              leadPriority: data["lead_priority"] ?? "Low",
              leadSource: data["lead_source"] ?? "Unknown",
              leadStage: data["lead_stages"] ?? "Prospect",
              attachments: data["attachments"] != null
                  ? List<String>.from(data["attachments"])
                  : [],
            );
          }).toList();

          return ListView.builder(
            itemCount: leads.length,
            itemBuilder: (context, index) {
              return LeadCard(lead: leads[index], index: index);
            },
          );
        },
      ),
    );
  }
}
