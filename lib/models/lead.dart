import 'dart:developer';

class Lead {
  String? docId; // Firestore document ID (for updates)
  String? name;
  String? photo;
  String? emailUpdateDate;
  String? billingName;
  String? mobileNumber;
  String? email;
  String? assignee;
  String? dateOfBirth;
  String? landlineNumber;
  String? website;
  String? leadPriority;
  String? leadSource;
  String? leadStage;
  String? aadharNumber;
  String? panNumber;
  String? gstNumber;
  String? gstState;
  String? mailingAddress;
  String? billingAddress;
  String? googleLocation;
  String? zipCode;
  String? country;
  String? state;
  String? city;
  List<String>? attachments;
  String? createdAt;
  String? updatedAt;

  Lead({
    this.docId,
    this.name,
    this.billingName,
    this.mobileNumber,
    this.email,
    this.assignee,
    this.dateOfBirth,
    this.landlineNumber,
    this.website,
    this.leadPriority,
    this.leadSource,
    this.leadStage,
    this.aadharNumber,
    this.panNumber,
    this.gstNumber,
    this.gstState,
    this.mailingAddress,
    this.billingAddress,
    this.googleLocation,
    this.zipCode,
    this.country,
    this.state,
    this.city,
    this.attachments,
    this.createdAt,
    this.updatedAt,
    this.emailUpdateDate,
    this.photo,
  });

  /// **Convert Firestore Document to `Lead` Model**
  factory Lead.fromFirestore(Map<String, dynamic> data, String docId) {
    log("Assigning docId: $docId to lead: ${data['name']}"); // Debugging

    return Lead(
      docId: docId, // Ensure docId is explicitly assigned
      name: data['name'] as String? ?? "",
      photo: data['photo'] as String? ?? "",
      billingName: data['billing_name'] as String? ?? "",
      emailUpdateDate: data['email_update_date'] as String? ?? "",
      mobileNumber: data['mobile_number'] as String? ?? "",
      email: data['email'] as String? ?? "",
      assignee: data['assignee'] as String? ?? "",
      dateOfBirth: data['date_of_birth'] as String? ?? "",
      landlineNumber: data['landline_number'] as String? ?? "",
      website: data['website'] as String? ?? "",
      leadPriority: data['lead_priority'] as String? ?? "",
      leadSource: data['lead_source'] as String? ?? "",
      leadStage: data['lead_stage'] as String? ?? "",
      aadharNumber: data['aadhar_number'] as String? ?? "",
      panNumber: data['pan_number'] as String? ?? "",
      gstNumber: data['gst_number'] as String? ?? "",
      gstState: data['gst_state'] as String? ?? "",
      mailingAddress: data['mailing_address'] as String? ?? "",
      billingAddress: data['billing_address'] as String? ?? "",
      googleLocation: data['google_location'] as String? ?? "",
      zipCode: data['zip_code'] as String? ?? "",
      country: data['country'] as String? ?? "",
      state: data['state'] as String? ?? "",
      city: data['city'] as String? ?? "",
      attachments: (data['attachments'] as List<dynamic>?)
              ?.map((item) => item.toString())
              .toList() ??
          [],
      createdAt: data['created_at'] as String? ?? "",
      updatedAt: data['updated_at'] as String? ?? "",
    );
  }

  /// **Convert `Lead` Model to Firestore Document**
  Map<String, dynamic> toFirestore() {
    return {
      "photo": photo ?? "",
      "email_update_date": emailUpdateDate ?? "",
      "name": name ?? "",
      "billing_name": billingName ?? "",
      "mobile_number": mobileNumber ?? "",
      "email": email ?? "",
      "assignee": assignee ?? "",
      "date_of_birth": dateOfBirth ?? "",
      "landline_number": landlineNumber ?? "",
      "website": website ?? "",
      "lead_priority": leadPriority ?? "",
      "lead_source": leadSource ?? "",
      "lead_stage": leadStage ?? "",
      "aadhar_number": aadharNumber ?? "",
      "pan_number": panNumber ?? "",
      "gst_number": gstNumber ?? "",
      "gst_state": gstState ?? "",
      "mailing_address": mailingAddress ?? "",
      "billing_address": billingAddress ?? "",
      "google_location": googleLocation ?? "",
      "zip_code": zipCode ?? "",
      "country": country ?? "",
      "state": state ?? "",
      "city": city ?? "",
      "attachments": attachments ?? [],
      "created_at": createdAt ?? DateTime.now().toUtc().toIso8601String(),
      "updated_at": updatedAt ?? DateTime.now().toUtc().toIso8601String(),
    };
  }
}
