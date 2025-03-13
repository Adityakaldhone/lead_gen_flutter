import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/lead_form_controller.dart';
import 'package:lead_gen/sections/attachment_section.dart';
import 'package:lead_gen/sections/basic_info.dart';
import 'package:lead_gen/sections/identification_info.dart';
import 'package:lead_gen/sections/lead_info.dart';
import 'package:lead_gen/sections/mailing_address.dart';

class LeadFormBottomSheet extends StatefulWidget {
  final String? docId;

  const LeadFormBottomSheet({super.key, this.docId});

  @override
  // ignore: library_private_types_in_public_api
  _LeadFormBottomSheetState createState() => _LeadFormBottomSheetState();
}

class _LeadFormBottomSheetState extends State<LeadFormBottomSheet> {
  final LeadFormController controller = Get.find();
  File? _profileImage;

  /// **Open Image Picker**
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
        controller.selectedImage.value = _profileImage; // ✅ Update controller
      });
    }
  }

  /// **Show Options to Select Image**
  void _showImagePicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Wrap(
        children: [
          ListTile(
            leading:const Icon(Icons.camera_alt, color: Colors.deepPurple),
            title:const Text("Take a Photo"),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera);
            },
          ),
          ListTile(
            leading:const Icon(Icons.photo, color: Colors.deepPurple),
            title:const Text("Choose from Gallery"),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back();
                    controller.clearForm();
                  },
                  child: const Text("Close", style: TextStyle(fontSize: 18)),
                ),
                Text(
                  widget.docId == null ? "Add Lead" : "Edit Lead",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    if (widget.docId == null) {
                      controller.saveLead(context);
                    } else {
                      controller.updateLead(widget.docId!, context);
                    }
                  },
                  child: const Text("Save", style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
            const SizedBox(height: 30),
            // 🟡 Profile Picture Picker

          const  SizedBox(height: 20),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.orangeAccent,
                              backgroundImage: _profileImage != null
                                  ? FileImage(_profileImage!)
                                  : null,
                              child: _profileImage == null
                                  ?const Icon(Icons.camera_alt,
                                      color: Colors.white, size: 40)
                                  : null,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: _showImagePicker,
                                child: Container(
                                  padding:const EdgeInsets.all(6),
                                  decoration:const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black26, blurRadius: 2),
                                    ],
                                  ),
                                  child:const Icon(Icons.edit,
                                      color: Colors.deepPurple, size: 20),
                                ),
                              ),
                            ),
                          ],
                        ),
                        BasicInfoSection(),
                        LeadInfoSection(),
                        IdentificationInfoSection(),
                        MailingAddressSection(),
                        AttachmentSection(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
