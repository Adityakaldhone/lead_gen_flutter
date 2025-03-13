import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:lead_gen/models/lead.dart';
import 'package:lead_gen/screens/leadform_bottomsheet.dart';
import 'package:lead_gen/service/firebase_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

/// **Lead Model**
///

class LeadFormController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final FirestoreService _firestoreService = FirestoreService();
  //  final FirestoreService _firestoreService = FirestoreService();
  var selectedImage = Rx<File?>(null); // Store selected image

  /// **Save Lead to Firestore**
  void saveLead(BuildContext context) async {
    if (!validateForm()) return; // Stop execution if validation fails

    // Create a temporary map for lead data
    Map<String, dynamic> leadData = {
      "name": nameController.text,
      "billing_name": billingNameController.text,
      "mobile_number": mobileController.text,
      "email": emailController.text,
      "assignee": selectedAssignee.value,
      "date_of_birth": dobController.text,
      "landline_number": landlineController.text,
      "website": websiteController.text,
      "lead_priority": selectedLeadPriority.value,
      "lead_source": selectedLeadSource.value,
      "lead_stage": selectedLeadStages.value,
      "aadhar_number": aadharController.text,
      "pan_number": panController.text,
      "gst_number": gstController.text,
      "gst_state": selectedGstState.value,
      "mailing_address": mailingAddressController.text,
      "billing_address": billingAddressController.text,
      "google_location": googleLocationController.text,
      "zip_code": zipCodeController.text,
      "country": countryController.text,
      "state": stateController.text,
      "city": cityController.text,
      "attachments": uploadedFiles.toList(),
      "created_at": DateTime.now().toUtc().toIso8601String(),
    };

    try {
      // Add the lead to Firestore first to get a document ID
      DocumentReference docRef = await _db.collection("leads").add(leadData);
      String docId = docRef.id;

      // If an image is selected, upload it and update the lead with the URL
      if (selectedImage.value != null) {
        String? imageUrl =
            await _firestoreService.uploadImage(selectedImage.value!, docId);
        if (imageUrl != null) {
          await _firestoreService.updateLead(docId, {"photo": imageUrl});
          leadData["photo"] = imageUrl; // Update local data
        }
      }

      Get.snackbar(
        "Success",
        "Lead saved successfully!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      clearForm(); // Clear form fields
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop(); // Close BottomSheet
      Get.back(); // Close BottomSheet
    } catch (error) {
      Get.snackbar(
        "Error",
        "Failed to save lead: $error",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  /// **Update Lead**
  void updateLead(String docId, BuildContext context) async {
    if (!validateForm()) return;

    Map<String, dynamic> updatedData = {
      "name": nameController.text,
      "billing_name": billingNameController.text,
      "mobile_number": mobileController.text,
      "email": emailController.text,
      "date_of_birth": dobController.text,
      "landline_number": landlineController.text,
      "website": websiteController.text,
      "lead_priority": selectedLeadPriority.value,
      "lead_source": selectedLeadSource.value,
      "lead_stage": selectedLeadStages.value,
      "aadhar_number": aadharController.text,
      "pan_number": panController.text,
      "gst_number": gstController.text,
      "gst_state": selectedGstState.value,
      "mailing_address": mailingAddressController.text,
      "billing_address": billingAddressController.text,
      "google_location": googleLocationController.text,
      "zip_code": zipCodeController.text,
      "country": countryController.text,
      "state": stateController.text,
      "city": cityController.text,
      "attachments": uploadedFiles.toList(),
      "updated_at": DateTime.now().toUtc().toIso8601String(),
    };

    try {
      // If a new image is selected, upload it and update the URL
      if (selectedImage.value != null) {
        String? imageUrl =
            await _firestoreService.uploadImage(selectedImage.value!, docId);
        if (imageUrl != null) {
          log(imageUrl);
          updatedData["photo"] = imageUrl;
        }
      }

      await _firestoreService.updateLead(docId, updatedData);

      Get.snackbar(
        "Success",
        "Lead updated successfully!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      clearForm();
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop(); // Close BottomSheet
      Get.back();
    } catch (error) {
      Get.snackbar(
        "Error",
        "Failed to update lead: $error",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // **Expansion states**
  var isBasicInfoExpanded = false.obs;
  var isLeadInfoExpanded = false.obs;
  var isIdentificationInfoExpanded = false.obs;
  var isMailingAddressExpanded = false.obs;
  var isAttachmentExpanded = false.obs;

  /// **List of Leads**
  var leads = <Lead>[].obs;

  // **Text Editing Controllers**
  var nameController = TextEditingController();
  var billingNameController = TextEditingController();
  var mobileController = TextEditingController();
  var emailController = TextEditingController();
  var dobController = TextEditingController();
  var landlineController = TextEditingController();
  var websiteController = TextEditingController();
  var aadharController = TextEditingController();
  var panController = TextEditingController();
  var gstController = TextEditingController();
  var gstStateController = TextEditingController();

  // **Mailing Address Controllers**
  var mailingAddressController = TextEditingController();
  var billingAddressController = TextEditingController();
  var googleLocationController = TextEditingController();
  var zipCodeController = TextEditingController();
  var countryController = TextEditingController();
  var stateController = TextEditingController();
  var cityController = TextEditingController();

  // **Attachment (File Upload)**
  var uploadedFiles = <String>[].obs;

  // **Dropdown Selections**
  var selectedTitle = "Mr".obs;
  var selectedMobileExt = "+1".obs;
  var selectedAssignee = "".obs;
  var selectedGstState = "".obs;
  var selectedLeadPriority = "".obs;
  var selectedLeadSource = "".obs;
  var selectedLeadStages = "".obs;

  // **Dropdown Lists**
  var mobileExtensions = ["+1", "+91", "+44"].obs;
  var assigneeList = ["User 1", "User 2", "User 3"].obs;
  var gstStatesList = ["State 1", "State 2", "State 3"].obs;
  var leadPriorityList = ["High", "Medium", "Low"].obs;
  var leadSourceList = ["Website", "Referral", "Cold Call"].obs;
  var leadStagesList = ["Prospect", "Negotiation", "Closed"].obs;

  // **Copy Mailing Address Checkbox**
  var isCopyMailingAddress = false.obs;

  // **Function to Copy Mailing Address to Billing Address**
  void copyMailingAddress(bool value) {
    isCopyMailingAddress.value = value;
    if (value) {
      billingAddressController.text = mailingAddressController.text;
    } else {
      billingAddressController.clear();
    }
  }

  // **Function to Add Attachments**
  Future<void> addAttachment() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null && result.files.isNotEmpty) {
        uploadedFiles.add(result.files.single.name);
      }
    } catch (e) {
     
      Get.snackbar("Error", "Failed to pick file");
    }
  }

  // **Function to Remove Attachment**
  void removeAttachment(int index) {
    uploadedFiles.removeAt(index);
  }

  ///  **View Lead Details (Firestore Fetch)**
  ///  **View Lead Details (Shows All Fields)**
  void viewLeadDetails(String leadId) async {
    try {
      DocumentSnapshot doc = await _db.collection("leads").doc(leadId).get();

      if (doc.exists) {
        var leadData = doc.data() as Map<String, dynamic>;
        log("Lead Details: $leadData");

        Get.dialog(
          AlertDialog(
            title:const Text("Lead Details"),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// **Basic Info**
                  Text("📛 Name: ${leadData['name'] ?? 'N/A'}"),
                  Text("📧 Email: ${leadData['email'] ?? 'N/A'}"),
                  Text("📞 Mobile: ${leadData['mobile_number'] ?? 'N/A'}"),
                  Text("☎️ Landline: ${leadData['landline_number'] ?? 'N/A'}"),
                  Text("🌍 Website: ${leadData['website'] ?? 'N/A'}"),
                  Text("🎂 DOB: ${leadData['date_of_birth'] ?? 'N/A'}"),

                const  SizedBox(height: 10),

                  /// **Lead Info**
                  Text(
                      "🔥 Lead Priority: ${leadData['lead_priority'] ?? 'N/A'}"),
                  Text("🔗 Lead Source: ${leadData['lead_source'] ?? 'N/A'}"),
                  Text("📈 Lead Stage: ${leadData['lead_stage'] ?? 'N/A'}"),

                const  SizedBox(height: 10),

                  /// **Business Info**
                  Text("🏢 Billing Name: ${leadData['billing_name'] ?? 'N/A'}"),
                  Text("🆔 Aadhar: ${leadData['aadhar_number'] ?? 'N/A'}"),
                  Text("💳 PAN: ${leadData['pan_number'] ?? 'N/A'}"),
                  Text("🧾 GST Number: ${leadData['gst_number'] ?? 'N/A'}"),
                  Text("🏛️ GST State: ${leadData['gst_state'] ?? 'N/A'}"),

                const  SizedBox(height: 10),

                  /// **Addresses**
                  Text(
                      "📍 Mailing Address: ${leadData['mailing_address'] ?? 'N/A'}"),
                  Text(
                      "🏠 Billing Address: ${leadData['billing_address'] ?? 'N/A'}"),
                  Text(
                      "📍 Google Location: ${leadData['google_location'] ?? 'N/A'}"),
                  Text("📦 Zip Code: ${leadData['zip_code'] ?? 'N/A'}"),
                  Text("🌎 Country: ${leadData['country'] ?? 'N/A'}"),
                  Text("🏙️ State: ${leadData['state'] ?? 'N/A'}"),
                  Text("🏘️ City: ${leadData['city'] ?? 'N/A'}"),

                const  SizedBox(height: 10),

                  /// **Attachments**
                const  Text("📂 Attachments:"),
                  if (leadData['attachments'] != null &&
                      (leadData['attachments'] as List).isNotEmpty)
                    ...List.generate(
                      (leadData['attachments'] as List).length,
                      (index) => Text("- ${leadData['attachments'][index]}"),
                    )
                  else
                  const  Text("No attachments uploaded"),

                 const SizedBox(height: 10),

                  /// **Last Updated Timestamp**
                  Text(
                      "🕒 Last Updated: ${_formatDate(leadData['updated_at'] ?? '')}"),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child:const Text("Close"),
              ),
            ],
          ),
        );
      } else {
        Get.snackbar("Error", "Lead not found",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (e) {
      log("Error fetching lead details: $e");
      Get.snackbar("Error", "Failed to load lead details",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

// 📅 **Helper function to format date safely**
  String _formatDate(String dateString) {
    try {
      DateTime parsedDate = DateTime.parse(dateString);
      return DateFormat("dd MMM yyyy")
          .format(parsedDate); // Output: "05 July 2024"
    } catch (e) {
      log("Invalid date format: $dateString");
      return "";
    }
  }

  /// 🔄 **Undo Last Action (Placeholder for future undo functionality)**
  void undoLastAction(String leadId) {
    log("Undo last action for Lead ID: $leadId");

    // Get.snackbar(
    //   "Undo Successful",
    //   "Last action undone for lead.",
    //   snackPosition: SnackPosition.TOP,
    //   backgroundColor: Colors.green,
    //   colorText: Colors.white,
    // );
  }

  /// ✅ **Mark Lead as Done (Uses `updateLead`)**
  Future<void> markAsDone(String leadId) async {
    try {
      // await updateLead(leadId, {"lead_stages": "Completed"});
      await _firestoreService.updateLead(leadId, {"lead_stage": "Closed"});
      log("Lead marked as done: $leadId");

      Get.snackbar(
        "Success",
        "Lead marked as completed!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      log("Error marking lead as done: $e");
      Get.snackbar(
        "Error",
        "Failed to update lead status.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  /// **Send Email**
  void sendEmail(String email, String docId) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(
        emailUri,
        mode: LaunchMode.externalApplication,
      );

      // 🆕 Save the email update date to Firestore
      try {
        String formattedDate =
            DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());

        await _firestoreService.updateLead(
            docId, {"email_update_date": formattedDate}); // ✅ Fix applied

        log("Email update date saved: $formattedDate");
      } catch (e) {
        log("Error updating email date: $e");
      }
    } else {
      Get.snackbar(
        "Error",
        "Could not open email client",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  /// **Call Lead**
  void callLead(String phone) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phone,
    );
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      Get.snackbar("Error", "Could not make the call",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  /// **Schedule Follow-up**
  void scheduleFollowUp(int index) {
    Get.snackbar(
        "Scheduled", "Follow-up scheduled for lead: ${leads[index].name}",
        backgroundColor: Colors.blue, colorText: Colors.white);
  }

  /// **Delete Lead**
  void deleteLead(String docId, int index) async {
    try {
      log("Deleting lead with docId: $docId");

      await _firestoreService.deleteLead(docId);

      // Remove from UI list
      leads.removeAt(index);

      Get.snackbar(
        "Deleted",
        "Lead removed successfully",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      log("Lead deleted successfully");
    } catch (e) {
      log("Error deleting lead: $e");

      // Get.snackbar(
      //   "Error",
      //   "Failed to delete lead",
      //   snackPosition: SnackPosition.TOP,
      //   backgroundColor: Colors.red,
      //   colorText: Colors.white,
      // );
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchLeads(); // Load leads from Firestore when the app starts
  }

  /// **Fetch Leads from Firestore**
  void fetchLeads() {
    _firestoreService.getLeads().listen((querySnapshot) {
      leads.value = querySnapshot.docs.map((doc) {
        log("Fetching lead - Firestore Doc ID: ${doc.id}"); // Debugging
        log("Lead Data: ${doc.data()}"); // Log Firestore data for debugging

        return Lead.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
      update(); // Force UI to refresh
      log("leaddata: ${leads.first.docId}");
    });
  }

  /// **Edit Lead (Pre-fill form & open Bottom Sheet)**
  void editLead(String docId, BuildContext context) {
    log("Editing lead with docId: $docId");

    if (docId.isEmpty) {
      log("Error: docId is empty");
      Get.snackbar(
        "Error",
        "Lead ID is missing!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    var lead = leads.firstWhere(
      (lead) => lead.docId == docId,
      orElse: () {
        log("Lead not found for docId: $docId");
        return Lead();
      },
    );

    log("Lead found: ${lead.name}, ID: ${lead.docId}"); // Debugging output

    // Fill form with existing lead data
    nameController.text = lead.name ?? "";
    billingNameController.text = lead.billingName ?? "";
    mobileController.text = lead.mobileNumber ?? "";
    emailController.text = lead.email ?? "";
    dobController.text = lead.dateOfBirth ?? "";
    landlineController.text = lead.landlineNumber ?? "";
    websiteController.text = lead.website ?? "";
    aadharController.text = lead.aadharNumber ?? "";
    panController.text = lead.panNumber ?? "";
    gstController.text = lead.gstNumber ?? "";
    gstStateController.text = lead.gstState ?? "";
    mailingAddressController.text = lead.mailingAddress ?? "";
    billingAddressController.text = lead.billingAddress ?? "";
    googleLocationController.text = lead.googleLocation ?? "";
    zipCodeController.text = lead.zipCode ?? "";
    countryController.text = lead.country ?? "";
    stateController.text = lead.state ?? "";
    cityController.text = lead.city ?? "";

    // Dropdown selections
    selectedLeadPriority.value = lead.leadPriority ?? "";
    selectedLeadSource.value = lead.leadSource ?? "";
    selectedLeadStages.value = lead.leadStage ?? "";
    selectedAssignee.value = lead.assignee ?? "";
    selectedGstState.value = lead.gstState ?? "";

    // Attachments
    uploadedFiles.assignAll(lead.attachments ?? []);

    log("Form updated with lead data.");

    // Ensure UI refreshes
    update();

    // Open Bottom Sheet for Editing
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => LeadFormBottomSheet(docId: docId),
    );
  }

  /// **Clear Form After Submission**
  void clearForm() {
    nameController.clear();
    emailController.clear();
    billingNameController.clear();
    billingAddressController.clear();
    mobileController.clear();

    dobController.clear();
    landlineController.clear();
    websiteController.clear();
    aadharController.clear();
    panController.clear();
    gstController.clear();
    gstStateController.clear();
    mailingAddressController.clear();
    googleLocationController.clear();
    zipCodeController.clear();
    countryController.clear();
    stateController.clear();
    cityController.clear();
    selectedTitle.value = "Mr";
    selectedMobileExt.value = "+1";
    selectedAssignee.value = "";
    selectedGstState.value = "";
    selectedLeadPriority.value = "";
    selectedLeadSource.value = "";
    selectedLeadStages.value = "";
    isCopyMailingAddress.value = false;
    uploadedFiles.clear();
  }

  // **Function to Validate All Fields Before Saving**
  bool validateForm() {
    // **Perform Field Validations**
    if (nameController.text.isEmpty) {
      Get.snackbar("Validation Error", "Name cannot be empty!",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return false;
    }

    if (billingNameController.text.isEmpty) {
      Get.snackbar("Validation Error", "Billing Name cannot be empty!",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return false;
    }

    if (mobileController.text.isEmpty) {
      Get.snackbar("Validation Error", "Mobile Number is required!",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return false;
    }

    if (!GetUtils.isEmail(emailController.text)) {
      Get.snackbar("Validation Error", "Enter a valid Email address!",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return false;
    }

    if (dobController.text.isEmpty) {
      Get.snackbar("Validation Error", "Date of Birth is required!",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return false;
    }

    if (landlineController.text.isEmpty) {
      Get.snackbar("Validation Error", "Landline Number is required!",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return false;
    }

    if (aadharController.text.isEmpty) {
      Get.snackbar("Validation Error", "Aadhar Number is required!",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return false;
    }

    if (panController.text.isEmpty) {
      Get.snackbar("Validation Error", "PAN Number is required!",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return false;
    }

    if (gstController.text.isEmpty) {
      Get.snackbar("Validation Error", "GST Number is required!",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return false;
    }

    if (mailingAddressController.text.isEmpty) {
      Get.snackbar("Validation Error", "Mailing Address is required!",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return false;
    }

    if (uploadedFiles.isEmpty) {
      Get.snackbar("Validation Error", "At least one attachment is required!",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return false;
    }

    // **Validation Passed**
    Get.snackbar("Success", "Lead Form Successfully Submitted!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white);

    return true;
  }

  GlobalKey<FormState> basicFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> leadInfoFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> identificationFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> mailingAddressFormKey = GlobalKey<FormState>();
}
