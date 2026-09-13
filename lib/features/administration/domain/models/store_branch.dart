class StoreBranch {
  final String id;
  String name;
  String legalName;
  String industry;
  String subType;
  List<String> enabledSubTypes;
  String country;
  String state;
  String address;
  String city;
  String zipCode;
  String phone;
  String email;
  String currency;
  String taxEngine;
  String taxId;
  bool isTaxExempt;
  String status;
  String qrUrl;
  bool autoPrintPos;
  List<String> assignedUsers;
  String timezone;

  // ZENO BOS ADVANCED PARAMS
  String businessSize;
  String operationMode;
  String barcodeTemplate;
  String receiptTemplate;
  List<String> inventoryMethods;
  List<String> paymentMethods;
  List<String> aiConfig;
  List<String> workflowApprovals;
  Map<String, String> numberingPrefixes;

  StoreBranch({
    required this.id,
    required this.name,
    required this.legalName,
    required this.industry,
    required this.subType,
    this.enabledSubTypes = const [],
    required this.country,
    required this.state,
    this.address = "",
    this.city = "",
    this.zipCode = "",
    this.phone = "",
    this.email = "",
    required this.currency,
    required this.taxEngine,
    required this.taxId,
    required this.isTaxExempt,
    required this.status,
    required this.qrUrl,
    this.autoPrintPos = false,
    this.assignedUsers = const [],
    this.timezone = "Asia/Kolkata",
    this.businessSize = "SMALL",
    this.operationMode = "Counter-Service",
    this.barcodeTemplate = "EAN-13 Standard",
    this.receiptTemplate = "Thermal 80mm Standard",
    this.inventoryMethods = const ["FIFO"],
    this.paymentMethods = const ["Cash", "Credit/Debit Card"],
    this.aiConfig = const [],
    this.workflowApprovals = const [],
    this.numberingPrefixes = const {
      "invoice": "INV",
      "order": "ORD",
      "receipt": "REC",
      "purchase": "PUR"
    },
  });

  StoreBranch copy({
    String? id,
    String? name,
    String? legalName,
    String? industry,
    String? subType,
    List<String>? enabledSubTypes,
    String? country,
    String? state,
    String? address,
    String? city,
    String? zipCode,
    String? phone,
    String? email,
    String? currency,
    String? taxEngine,
    String? taxId,
    bool? isTaxExempt,
    String? status,
    String? qrUrl,
    bool? autoPrintPos,
    List<String>? assignedUsers,
    String? timezone,
    String? businessSize,
    String? operationMode,
    String? barcodeTemplate,
    String? receiptTemplate,
    List<String>? inventoryMethods,
    List<String>? paymentMethods,
    List<String>? aiConfig,
    List<String>? workflowApprovals,
    Map<String, String>? numberingPrefixes,
  }) {
    return StoreBranch(
      id: id ?? this.id,
      name: name ?? this.name,
      legalName: legalName ?? this.legalName,
      industry: industry ?? this.industry,
      subType: subType ?? this.subType,
      enabledSubTypes: enabledSubTypes ?? List.from(this.enabledSubTypes),
      country: country ?? this.country,
      state: state ?? this.state,
      address: address ?? this.address,
      city: city ?? this.city,
      zipCode: zipCode ?? this.zipCode,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      currency: currency ?? this.currency,
      taxEngine: taxEngine ?? this.taxEngine,
      taxId: taxId ?? this.taxId,
      isTaxExempt: isTaxExempt ?? this.isTaxExempt,
      status: status ?? this.status,
      qrUrl: qrUrl ?? this.qrUrl,
      autoPrintPos: autoPrintPos ?? this.autoPrintPos,
      assignedUsers: assignedUsers ?? List.from(this.assignedUsers),
      timezone: timezone ?? this.timezone,
      businessSize: businessSize ?? this.businessSize,
      operationMode: operationMode ?? this.operationMode,
      barcodeTemplate: barcodeTemplate ?? this.barcodeTemplate,
      receiptTemplate: receiptTemplate ?? this.receiptTemplate,
      inventoryMethods: inventoryMethods ?? List.from(this.inventoryMethods),
      paymentMethods: paymentMethods ?? List.from(this.paymentMethods),
      aiConfig: aiConfig ?? List.from(this.aiConfig),
      workflowApprovals: workflowApprovals ?? List.from(this.workflowApprovals),
      numberingPrefixes: numberingPrefixes ?? Map.from(this.numberingPrefixes),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'legalName': legalName,
        'industry': industry,
        'subType': subType,
        'enabledSubTypes': enabledSubTypes,
        'country': country,
        'state': state,
        'address': address,
        'city': city,
        'zipCode': zipCode,
        'phone': phone,
        'email': email,
        'currency': currency,
        'taxEngine': taxEngine,
        'taxId': taxId,
        'isTaxExempt': isTaxExempt,
        'status': status,
        'qrUrl': qrUrl,
        'autoPrintPos': autoPrintPos,
        'assignedUsers': assignedUsers,
        'timezone': timezone,
        'businessSize': businessSize,
        'operationMode': operationMode,
        'barcodeTemplate': barcodeTemplate,
        'receiptTemplate': receiptTemplate,
        'inventoryMethods': inventoryMethods,
        'paymentMethods': paymentMethods,
        'aiConfig': aiConfig,
        'workflowApprovals': workflowApprovals,
        'numberingPrefixes': numberingPrefixes,
      };

  factory StoreBranch.fromJson(Map<String, dynamic> json) {
    final subType = json['subType'] as String? ?? "";
    final enabledSubTypesJson = json['enabledSubTypes'] as List<dynamic>?;
    
    final enabledSubTypes = (enabledSubTypesJson != null)
        ? List<String>.from(enabledSubTypesJson)
        : (subType.isNotEmpty ? [subType] : <String>[]);

    return StoreBranch(
        id: json['id'],
        name: json['name'],
        legalName: json['legalName'],
        industry: json['industry'],
        subType: subType,
        enabledSubTypes: enabledSubTypes,
        country: json['country'],
        state: json['state'],
        address: json['address'] ?? "",
        city: json['city'] ?? "",
        zipCode: json['zipCode'] ?? "",
        phone: json['phone'] ?? "",
        email: json['email'] ?? "",
        currency: json['currency'],
        taxEngine: json['taxEngine'],
        taxId: json['taxId'],
        isTaxExempt: json['isTaxExempt'] ?? false,
        status: json['status'],
        qrUrl: json['qrUrl'],
        autoPrintPos: json['autoPrintPos'] ?? false,
        assignedUsers: List<String>.from(json['assignedUsers'] ?? []),
        timezone: json['timezone'] ?? "Asia/Kolkata",
        businessSize: json['businessSize'] ?? "SMALL",
        operationMode: json['operationMode'] ?? "Counter-Service",
        barcodeTemplate: json['barcodeTemplate'] ?? "EAN-13 Standard",
        receiptTemplate: json['receiptTemplate'] ?? "Thermal 80mm Standard",
        inventoryMethods: List<String>.from(json['inventoryMethods'] ?? []),
        paymentMethods: List<String>.from(json['paymentMethods'] ?? []),
        aiConfig: List<String>.from(json['aiConfig'] ?? []),
        workflowApprovals: List<String>.from(json['workflowApprovals'] ?? []),
        numberingPrefixes:
            Map<String, String>.from(json['numberingPrefixes'] ?? {}),
      );
  }
}
