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
  String city;
  String state;
  String district;
  String zipCode;

  PaymentAddress({
    required this.city,
    required this.state,
    required this.district,
    required this.zipCode,
  });

  factory PaymentAddress.fromJson(Map<String, dynamic> json) {
    return PaymentAddress(
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      district: json['district'] ?? '',
      zipCode: json['zipCode'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
  String password; // New field added for password
  String confirmPassword; // Field for confirm password
  String GSTNumber;
  Address address;
  PaymentAddress paymentAddress;
  String role;
  bool status; // Ensure this is boolean
  bool isDeleted;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password, // Include password in constructor
    required this.confirmPassword,
    required this.GSTNumber,
    required this.address,
    required this.paymentAddress,
    required this.role,
    required this.status, // Ensure this is properly handled
    required this.isDeleted,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '', // Handle missing fields with default empty strings
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      password: json['password'] ?? '', // Add password handling
      confirmPassword: json['confirmPassword'] ?? '', // Add confirm password handling
      GSTNumber: json['GSTNumber'] ?? '',
      address: json['address'] != null
          ? Address.fromJson(json['address'])
          : Address(
              street: '',
              city: '',
              state: '',
              district: '',
              zipCode: '',
            ),
      paymentAddress: json['paymentAddress'] != null
          ? PaymentAddress.fromJson(json['paymentAddress'])
          : PaymentAddress(
              city: '',
              state: '',
              district: '',
              zipCode: '',
            ),
      role: json['role'] ?? '',
      // Check if status is boolean, else default to false
      status: json['status'] is bool ? json['status'] : false,
      isDeleted: json['isDeleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'password': password, // Include password in JSON output
      'confirmPassword': confirmPassword, // Include confirm password in JSON output
      'GSTNumber': GSTNumber,
      'address': address.toJson(),
      'paymentAddress': paymentAddress.toJson(),
      'role': role,
      'status': status,
      'isDeleted': isDeleted,
    };
  }
}
