import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lead_gen/models/lead.dart';
import '../controllers/lead_form_controller.dart';

class LeadCard extends StatelessWidget {
  final Lead lead;
  final int index;
  final LeadFormController controller = Get.find();

  LeadCard({super.key, required this.lead, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// **Header Row (Profile, Name, Role)**
            Row(
              children: [
                // 🟢 Profile Picture or Initials
                CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.blueAccent,
                  backgroundImage: lead.photo != null && lead.photo!.isNotEmpty
                      ? NetworkImage(lead.photo!) as ImageProvider
                      : null,
                  child: (lead.photo == null || lead.photo!.isEmpty)
                      ? Text(
                          lead.name != null && lead.name!.length >= 2
                              ? lead.name!.substring(0, 2).toUpperCase()
                              : "N/A",
                          style:const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        )
                      : null,
                ),
              const  SizedBox(width: 10),
                Expanded(
                  child: Text(
                    lead.name ?? "",
                    style:const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              const  Text(
                  "Individual",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          const  SizedBox(height: 8),

            /// **Email**
            Row(
              children: [
              const  Icon(Icons.email, size: 18, color: Colors.grey),
              const  SizedBox(width: 5),
                Expanded(
                  child: Text(
                    lead.email ?? "No Email",
                    style:const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ),
              ],
            ),
          const  SizedBox(height: 5),

            /// **Phone**
            Row(
              children: [
               const Icon(Icons.phone, size: 18, color: Colors.grey),
               const SizedBox(width: 5),
                Text(
                  lead.mobileNumber ?? "No Phone",
                  style:const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ],
            ),
          const  SizedBox(height: 5),

            /// **Status (e.g., Sent Email on date)**
            Row(
              children: [
               const Icon(Icons.sync, size: 18, color: Colors.grey),
              const  SizedBox(width: 5),
                Text(
  _formatDate(lead.emailUpdateDate ?? ""), // ✅ Automatically handles invalid cases
  style:const TextStyle(fontSize: 12, color: Colors.grey),
),

              ],
            ),
           const SizedBox(height: 10),

            /// **Lead Priority and Source Tags**
           const Row(
              children: [
                Chip(
                  label: Text(
                    "New Lead",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  backgroundColor: Colors.redAccent,
                ),
                SizedBox(width: 5),
                Chip(
                  label: Text(
                    "LinkedIn",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  backgroundColor: Colors.blueAccent,
                ),
                Spacer(),
                CircleAvatar(
                  backgroundColor: Colors.pinkAccent,
                  radius: 18,
                  child: Text(
                    "KM", // Assign user's initials dynamically
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),

            /// **Divider before actions**
            Divider(thickness: 1.2, color: Colors.grey[300]),
          const  SizedBox(height: 5),

            /// **Action Icons Row (7 Icons Total)**
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// ✏️ **Edit**
                IconButton(
                  icon:const Icon(Icons.edit, color: Colors.grey, size: 20),
                  onPressed: () {
                    if (lead.docId != null && lead.docId!.isNotEmpty) {
                      log("Editing Lead - docId: ${lead.docId}");
                      controller.editLead(lead.docId!, context);
                    }
                  },
                ),

                /// 📄 **View Details**
                IconButton(
                  icon:const Icon(Icons.insert_drive_file_outlined, color: Colors.grey, size: 20),
                  onPressed: () {
                    log("Viewing Lead Details - ID: ${lead.docId}");
                    controller.viewLeadDetails(lead.docId!);
                  },
                ),

                /// 📧 **Send Email**
                IconButton(
                  icon:const Icon(Icons.email, color: Colors.grey, size: 20),
                  onPressed: () {
                    if (lead.docId != null && lead.docId!.isNotEmpty) {
                      log("Sending email to: ${lead.email}");
                      controller.sendEmail(lead.email!, lead.docId!);
                    }
                  },
                ),

                /// 🔄 **Undo Action**
                IconButton(
                  icon:const Icon(Icons.undo, color: Colors.grey, size: 20),
                  onPressed: () {
                    log("Undo last action for Lead ID: ${lead.docId}");
                    controller.undoLastAction(lead.docId!);
                  },
                ),

                /// ✅ **Mark as Done**
                IconButton(
                  icon:const Icon(Icons.check_circle_outline, color: Colors.grey, size: 20),
                  onPressed: () {
                    log("Marking Lead as Done: ${lead.docId}");
                    controller.markAsDone(lead.docId!);
                  },
                ),

                /// 📅 **Schedule Meeting**
                IconButton(
                  icon:const Icon(Icons.calendar_today, color: Colors.grey, size: 20),
                  onPressed: () {
                    controller.scheduleFollowUp(index);
                  },
                ),

                /// 🗑️ **Delete**
                IconButton(
                  icon:const Icon(Icons.delete, color: Colors.grey, size: 20),
                  onPressed: () {
                    if (lead.docId != null && lead.docId!.isNotEmpty) {
                      log("Deleting Lead - docId: ${lead.docId}");
                      controller.deleteLead(lead.docId!, index);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// 📅 **Helper function to format date safely**
String _formatDate(String dateString) {
  try {
    if (dateString.isEmpty) return "No Email Sent"; // ✅ Handle empty string case
    DateTime parsedDate = DateTime.parse(dateString);
    return " Email Sent on ${DateFormat("dd MMM yyyy").format(parsedDate)}"; // ✅ Format as "05 July 2024"
  } catch (e) {
    log("Invalid date format: $dateString");
    return "No Email Sent"; // ✅ Return this instead of "Invalid Date"
  }
}

