class ValidationPatterns {
  // Name
  static final RegExp name = RegExp(r'^[A-Za-z\s]+(\.[A-Za-z\s]+)?$');

  // Billing Name
  static final RegExp billingName = RegExp(r'^[A-Za-z\s]+(\.[A-Za-z\s]+)?$');

  // Mobile Number
  static final RegExp mobileNumber = RegExp(r'^(?:\+91)?[6-9][0-9]{9}$');

  // Email
  static final RegExp email = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  // Date of Birth
  static final RegExp dateOfBirth = RegExp(r'^\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01])$');

  // Landline Number
  static final RegExp landlineNumber = RegExp(r'^[0-9]{2,4}-[0-9]{6,8}$');

  // Website
  // static final RegExp website = RegExp(r'^(https?:\/\/)?(www\.)?[a-zA-Z0-9-]+\.[a-zA-Z]{2,}(\/[a-zA-Z0-9-._~:/?#[\]@!$&\'()*+,;=]*)?$');

  // Lead Priority
  static final RegExp leadPriority = RegExp(r'^(High|Medium|Low)$');

  // Lead Source
  static final RegExp leadSource = RegExp(r'^(LinkedIn|Website|Referral|Other)$');

  // Lead Stages
  static final RegExp leadStages = RegExp(r'^(New Lead|Contacted|Converted|Lost)$');

  // Aadhar Number
  static final RegExp aadharNumber = RegExp(r'^[2-9][0-9]{3}\s?[0-9]{4}\s?[0-9]{4}$');

  // PAN Number
  static final RegExp panNumber = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$');

  // GST Number
  static final RegExp gstNumber = RegExp(r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}[A-Z]{1}[0-9A-Z]{1}$');

  // GST State
  static final RegExp gstState = RegExp(r'^(Maharashtra|Karnataka|Tamil Nadu|...)$'); // Replace ... with your list

  // Mailing Address
  static final RegExp mailingAddress = RegExp(r'^[A-Za-z0-9\s,.-]+$');

  // Billing Address
  static final RegExp billingAddress = RegExp(r'^[A-Za-z0-9\s,.-]+$');

  // Google Location
  static final RegExp googleLocation = RegExp(r'^https:\/\/(www\.)?maps\.google\.com\/.*$');

  // Zip Code
  static final RegExp zipCode = RegExp(r'^[1-9][0-9]{5}$');

  // Country
  static final RegExp country = RegExp(r'^[A-Za-z\s]+$');

  // State
  static final RegExp state = RegExp(r'^[A-Za-z\s]+$');

  // City
  static final RegExp city = RegExp(r'^[A-Za-z\s]+$');

  // Attachments
  static final RegExp attachments = RegExp(r'^[A-Za-z0-9-_\s]+\.(pdf|jpg|jpeg|png|doc|docx)$');
}
