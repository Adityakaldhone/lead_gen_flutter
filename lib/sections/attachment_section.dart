import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/lead_form_controller.dart';

class AttachmentSection extends StatelessWidget {
  final LeadFormController controller = Get.find();

   AttachmentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Card(
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.white, // Remove the default divider/border
            ),
            child: ExpansionTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              title:const Text("Attachment",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              initiallyExpanded: controller.isAttachmentExpanded.value,
              onExpansionChanged: (value) =>
                  controller.isAttachmentExpanded.value = value,
              children: [
                Padding(
                  padding:const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      /// **Add Attachment Button**
                      GestureDetector(
                        onTap: () => controller.addAttachment(),
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey[200],
                          ),
                          child:const Icon(Icons.add, size: 30, color: Colors.grey),
                        ),
                      ),
                    const  SizedBox(height: 10),

                      /// **List of Uploaded Files**
                      Obx(() => Column(
                            children: controller.uploadedFiles.map((file) {
                              int index =
                                  controller.uploadedFiles.indexOf(file);
                              return Card(
                                elevation: 2,
                                margin:const EdgeInsets.symmetric(vertical: 5),
                                child: ListTile(
                                  title: Text(file,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis),
                                  trailing: IconButton(
                                    icon:const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () =>
                                        controller.removeAttachment(index),
                                  ),
                                ),
                              );
                            }).toList(),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
