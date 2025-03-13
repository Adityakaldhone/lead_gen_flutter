import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/lead_form_controller.dart';


class LeadInfoSection extends StatelessWidget {
  final LeadFormController controller = Get.find();

   LeadInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Card(
          color: Colors.white,
          elevation: 1,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.white, // Remove the default divider/border
            ),
            child: ExpansionTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              title:const Text(
                "Lead Information",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              initiallyExpanded: controller.isLeadInfoExpanded.value,
              onExpansionChanged: (value) =>
                  controller.isLeadInfoExpanded.value = value,
              collapsedBackgroundColor: Colors.white,
              backgroundColor: Colors.white,
              children: [
                Padding(
                  padding:const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align labels to the start
                    children: [
                      /// **Lead Priority Dropdown with Hint Text**
                      Padding(
                        padding:const EdgeInsets.only(
                            bottom: 4.0), // Space between hint and dropdown
                        child: Text(
                          "Lead Priority",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]),
                        ),
                      ),
                      Obx(() => DropdownButtonFormField<String>(
                            value:
                                controller.selectedLeadPriority.value.isNotEmpty
                                    ? controller.selectedLeadPriority.value
                                    : null,
                            hint:const Text("Select Lead Priority"),
                            items: controller.leadPriorityList
                                .map((e) =>
                                    DropdownMenuItem(value: e, child: Text(e)))
                                .toList(),
                            onChanged: (value) =>
                                controller.selectedLeadPriority.value = value!,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          )),
                     const SizedBox(height: 10),

                      /// **Lead Source Dropdown with Hint Text**
                      Padding(
                        padding:const EdgeInsets.only(bottom: 4.0),
                        child: Text(
                          "Lead Source",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]),
                        ),
                      ),
                      Obx(() => DropdownButtonFormField<String>(
                            value:
                                controller.selectedLeadSource.value.isNotEmpty
                                    ? controller.selectedLeadSource.value
                                    : null,
                            hint:const Text("Select Lead Source"),
                            items: controller.leadSourceList
                                .map((e) =>
                                    DropdownMenuItem(value: e, child: Text(e)))
                                .toList(),
                            onChanged: (value) =>
                                controller.selectedLeadSource.value = value!,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          )),
                    const  SizedBox(height: 10),

                      /// **Lead Stages Dropdown with Hint Text**
                      Padding(
                        padding:const EdgeInsets.only(bottom: 4.0),
                        child: Text(
                          "Lead Stages",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]),
                        ),
                      ),
                      Obx(() => DropdownButtonFormField<String>(
                            value:
                                controller.selectedLeadStages.value.isNotEmpty
                                    ? controller.selectedLeadStages.value
                                    : null,
                            hint:const Text("Select Lead Stages"),
                            items: controller.leadStagesList
                                .map((e) =>
                                    DropdownMenuItem(value: e, child: Text(e)))
                                .toList(),
                            onChanged: (value) =>
                                controller.selectedLeadStages.value = value!,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
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
