import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:lead_gen/constants/reg_exp.dart';
import '../controllers/lead_form_controller.dart';
import '../uiComponents/inputfield.dart';

class MailingAddressSection extends StatelessWidget {
  final LeadFormController controller = Get.find();

   MailingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return Obx(() => Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Theme(
                data: Theme.of(context).copyWith(
                  dividerColor:
                      Colors.white, // Remove the default divider/border
                ),
                child: ExpansionTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  title:const Text(
                    "Mailing Address",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  initiallyExpanded: controller.isMailingAddressExpanded.value,
                  onExpansionChanged: (value) =>
                      controller.isMailingAddressExpanded.value = value,
                  children: [
                    SizedBox(
                      height: isKeyboardVisible
                          ? 250
                          : null, // Adjust height when keyboard opens
                      child: Form(
                        key: controller.mailingAddressFormKey,
                        child: ListView(
                          shrinkWrap: true,
                          physics:
                             const ClampingScrollPhysics(), // Prevents unnecessary scrolling
                          padding:const EdgeInsets.all(16),
                          children: [
                            /// **Mailing Address**
                            InputField(
                              regExp: ValidationPatterns.mailingAddress,
                              textInputType: TextInputType.emailAddress,
                              controller: controller.mailingAddressController,
                              width: double.infinity,
                              hint: "Enter Mailing Address",
                              labelText: "Mailing Address",
                            ),
                           const SizedBox(height: 10),
                        
                            /// **Billing Address with Checkbox**
                            Row(
                              children: [
                                Expanded(
                                  child: InputField(
                                    regExp: ValidationPatterns.billingAddress,
                                    textInputType: TextInputType.streetAddress,
                                    controller:
                                        controller.billingAddressController,
                                    width: double.infinity,
                                    hint: "Enter Billing Address",
                                    labelText: "Billing Address",
                                  ),
                                ),
                             const   SizedBox(width: 10),
                                Column(
                                  children: [
                                    Obx(() => Checkbox(
                                          value: controller
                                              .isCopyMailingAddress.value,
                                          onChanged: (value) {
                                            controller.isCopyMailingAddress
                                                .value = value!;
                                            if (value) {
                                              controller.billingAddressController
                                                      .text =
                                                  controller
                                                      .mailingAddressController
                                                      .text;
                                            } else {
                                              controller.billingAddressController
                                                  .clear();
                                            }
                                          },
                                        )),
                                  const  Text(
                                      "Copy Mailing Address",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.blue),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                           const SizedBox(height: 10),
                        
                            /// **Google Location**
                            InputField(
                              regExp: ValidationPatterns.billingAddress,
                              controller: controller.googleLocationController,
                              width: double.infinity,
                              hint: "Enter Google Location",
                              labelText: "Google Location",
                            ),
                           const SizedBox(height: 10),
                        
                            /// **Zip Code**
                            InputField(
                              regExp: ValidationPatterns.zipCode,
                              textInputType: TextInputType.number,
                              controller: controller.zipCodeController,
                              width: double.infinity,
                              hint: "Enter Zip Code",
                              labelText: "Zip Code",
                              keyboardType: TextInputType.number,
                            ),
                           const SizedBox(height: 10),
                        
                            /// **Country**
                            InputField(
                              regExp: ValidationPatterns.country,
                              textInputType: TextInputType.text,
                              controller: controller.countryController,
                              width: double.infinity,
                              hint: "Enter Country",
                              labelText: "Country",
                            ),
                          const  SizedBox(height: 10),
                        
                            /// **State**
                            InputField(
                              regExp: ValidationPatterns.state,
                              textInputType: TextInputType.text,
                              controller: controller.stateController,
                              width: double.infinity,
                              hint: "Enter State",
                              labelText: "State",
                            ),
                          const  SizedBox(height: 10),
                        
                            /// **City**
                            InputField(
                              regExp: ValidationPatterns.city,
                              controller: controller.cityController,
                              width: double.infinity,
                              hint: "Enter City",
                              labelText: "City",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
