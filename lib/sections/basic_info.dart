import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lead_gen/constants/reg_exp.dart';
import '../controllers/lead_form_controller.dart';
import '../uiComponents/inputfield.dart';

class BasicInfoSection extends StatelessWidget {
  final LeadFormController controller = Get.find();

   BasicInfoSection({super.key});

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
              title:const Text("Basic Information",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              initiallyExpanded: controller.isBasicInfoExpanded.value,
              onExpansionChanged: (value) =>
                  controller.isBasicInfoExpanded.value = value,
              children: [
                Padding(
                  padding:const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      /// **Title & Name**
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: DropdownButtonFormField<String>(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              value: controller.selectedTitle.value,
                              items: ["Mr", "Mrs", "Miss"]
                                  .map((e) => DropdownMenuItem(
                                      value: e, child: Text(e)))
                                  .toList(),
                              onChanged: (value) =>
                                  controller.selectedTitle.value = value!,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                labelText: "Title",
                              ),
                            ),
                          ),
                       const   SizedBox(width: 10),
                          Expanded(
                            flex: 5,
                            child: InputField(
                              controller: controller.nameController,
                              width: double.infinity,
                              hint: "Enter Name",
                              labelText: "Name *",
                              textInputType: TextInputType.name,
                              regExp: ValidationPatterns.name,
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? "Name is required"
                                      : null,
                            ),
                          ),
                        ],
                      ),
                    const  SizedBox(height: 10),

                      /// **Billing Name**
                      InputField(
                        textInputType: TextInputType.name,
                        regExp: ValidationPatterns.billingName,
                        controller: controller.billingNameController,
                        width: double.infinity,
                        hint: "Enter Billing Name",
                        labelText: "Billing Name",
                      ),
                    const  SizedBox(height: 10),

                      /// **Mobile Number & Extension**
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Obx(() => DropdownButtonFormField<String>(
                                  value: controller.selectedMobileExt.value,
                                  items: controller.mobileExtensions
                                      .map((e) => DropdownMenuItem(
                                          value: e, child: Text(e)))
                                      .toList(),
                                  onChanged: (value) => controller
                                      .selectedMobileExt.value = value!,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    labelText: "Ext.",
                                  ),
                                )),
                          ),
                        const  SizedBox(width: 10),
                          Expanded(
                            flex: 5,
                            child: InputField(
                              regExp: ValidationPatterns.mobileNumber,
                              textInputType: TextInputType.number,
                              controller: controller.mobileController,
                              width: double.infinity,
                              hint: "Enter Mobile Number",
                              labelText: "Mobile Number",
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                        ],
                      ),
                    const  SizedBox(height: 10),

                      /// **Email**
                      InputField(
                        regExp: ValidationPatterns.email,
                        textInputType: TextInputType.emailAddress,
                        controller: controller.emailController,
                        width: double.infinity,
                        hint: "Enter Email",
                        labelText: "Email",
                        keyboardType: TextInputType.emailAddress,
                      ),
                    const  SizedBox(height: 10),

                      /// **Assignee Dropdown**
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         const Text(
                            "Assignee",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          Obx(() => DropdownButtonFormField<String>(
                                value:
                                    controller.selectedAssignee.value.isNotEmpty
                                        ? controller.selectedAssignee.value
                                        : null,
                                hint:const Text("Select Assignee"),
                                items: controller.assigneeList
                                    .map((e) => DropdownMenuItem(
                                        value: e, child: Text(e)))
                                    .toList(),
                                onChanged: (value) =>
                                    controller.selectedAssignee.value = value!,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                              )),
                        ],
                      ),
                     const SizedBox(height: 10),

                      /// **Date of Birth**
                      InputField(
                        // regExp: ValidationPatterns.dateOfBirth,
                        controller: controller.dobController,
                        width: double.infinity,
                        hint: "Select Date of Birth",
                        labelText: "Date of Birth",
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime.now(),
                          );
                          if (pickedDate != null) {
                            controller.dobController.text =
                                pickedDate.toString().split(" ")[0];
                          }
                        },
                      ),
                    const  SizedBox(height: 10),

                      /// **Landline Number**
                      InputField(
                        // regExp: ValidationPatterns.landlineNumber,
                        textInputType: TextInputType.phone,
                        controller: controller.landlineController,
                        width: double.infinity,
                        hint: "Enter Landline Number",
                        labelText: "Land Line Number",
                        keyboardType: TextInputType.phone,
                      ),
                    const  SizedBox(height: 10),

                      /// **Website (Optional)**
                      InputField(
                        textInputType: TextInputType.text,
                        controller: controller.websiteController,
                        width: double.infinity,
                        hint: "Enter Website",
                        labelText: "Website (optional)",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
