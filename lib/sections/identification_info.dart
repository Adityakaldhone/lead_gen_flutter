import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lead_gen/constants/reg_exp.dart';
import 'package:lead_gen/controllers/lead_form_controller.dart';
import 'package:lead_gen/uiComponents/inputfield.dart';

class IdentificationInfoSection extends StatelessWidget {
  final LeadFormController controller = Get.find();

   IdentificationInfoSection({super.key});

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
              title:const Text("Identification Information",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              initiallyExpanded: controller.isIdentificationInfoExpanded.value,
              onExpansionChanged: (value) =>
                  controller.isIdentificationInfoExpanded.value = value,
              children: [
                Padding(
                  padding:const EdgeInsets.all(16),
                  child: Form(
                    key: controller.identificationFormKey,
                    child: Column(
                      children: [
                        /// **Aadhaar Number**
                        InputField(
                          regExp: ValidationPatterns.aadharNumber,
                          textInputType: TextInputType.name,
                          controller: controller.aadharController,
                          width: double.infinity,
                          hint: "Enter Aadhaar Number",
                          labelText: "Aadhaar Number",
                        ),
                      const  SizedBox(height: 10),
                    
                        /// **PAN Number**
                        InputField(
                          regExp: ValidationPatterns.panNumber,
                          textInputType: TextInputType.emailAddress,
                          controller: controller.panController,
                          width: double.infinity,
                          hint: "Enter PAN Number",
                          labelText: "PAN Number",
                        ),
                       const SizedBox(height: 10),
                    
                        /// **GST Number**
                        InputField(
                          regExp: ValidationPatterns.gstNumber,
                          textInputType: TextInputType.text,
                          // textInputType: TextInputType,
                          controller: controller.gstController,
                          width: double.infinity,
                          hint: "Enter GST Number",
                          labelText: "GST Number",
                        ),
                      const  SizedBox(height: 10),
                    
                        /// **GST State Dropdown**
                        Obx(() => Column(
                              children: [
                              const  Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "GST State",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                DropdownButtonFormField<String>(
                                  value: controller
                                          .selectedGstState.value.isNotEmpty
                                      ? controller.selectedGstState.value
                                      : null, // Set to null if empty to avoid errors
                                  hint:const Text(
                                      "GST State"), // Add a hint for better UI
                                  items: controller.gstStatesList
                                      .map((e) => DropdownMenuItem(
                                          value: e, child: Text(e)))
                                      .toList(),
                                  onChanged: (value) =>
                                      controller.selectedGstState.value = value!,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
