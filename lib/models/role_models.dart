class RoleModel {
  String status;
  String code;
  String role;
  String createdAt;

  RoleModel({
    required this.status,
    required this.code,
    required this.role,
    required this.createdAt,
  });

  // Factory method to create a RoleModel from a Map (useful for API responses)
  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      status: json['status'],
      code: json['code'],
      role: json['role'],
      createdAt: json['createdAt'],
    );
  }

  // Method to convert RoleModel into a Map (useful for sending data to APIs)
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'code': code,
      'role': role,
      'createdAt': createdAt,
    };
  }
}
