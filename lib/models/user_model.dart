class Address {
  String street;
  String city;
  String state;
  String district;
  String zipCode;

  Address({
    required this.street,
    required this.city,
    required this.state,
    required this.district,
    required this.zipCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      district: json['district'] ?? '',
      zipCode: json['zipCode'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'city': city,
      'state': state,
      'district': district,
      'zipCode': zipCode,
    };
  }
}

class PaymentAddress {
  String gstNumber;
  String city;
  String state;
  String district;
  String zipCode;

  PaymentAddress({
    required this.gstNumber,
    required this.city,
    required this.state,
    required this.district,
    required this.zipCode,
  });

  factory PaymentAddress.fromJson(Map<String, dynamic> json) {
    return PaymentAddress(
      gstNumber: json['gstNumber'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      district: json['district'] ?? '',
      zipCode: json['zipCode'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gstNumber': gstNumber,
      'city': city,
      'state': state,
      'district': district,
      'zipCode': zipCode,
    };
  }
}

class User {
  String id;
  String name;
  String email;
  String phone;
  Address address;
  PaymentAddress paymentAddress;
  String role;
  String status;
  bool isDeleted;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.paymentAddress,
    required this.role,
    required this.status,
    required this.isDeleted,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '', // Handle missing fields with default empty strings
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] != null
          ? Address.fromJson(json['address'])
          : Address(
              street: '', city: '', state: '', district: '', zipCode: ''),
      paymentAddress: json['paymentAddress'] != null
          ? PaymentAddress.fromJson(json['paymentAddress'])
          : PaymentAddress(
              gstNumber: '', city: '', state: '', district: '', zipCode: ''),
      role: json['role'] ?? '',
      // Convert status to String in case it's a boolean
      status: json['status'] != null ? json['status'].toString() : '',
      isDeleted: json['isDeleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address.toJson(),
      'paymentAddress': paymentAddress.toJson(),
      'role': role,
      'status': status,
      'isDeleted': isDeleted,
    };
  }
}
