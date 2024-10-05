class Teacher {
  final int id; // Unique identifier for the teacher
  final String firstName; // First name of the teacher
  final String lastName; // Last name of the teacher
  final String subject; // Subject taught by the teacher
  final String email; // Email address of the teacher
  final String contactNo; // Contact number of the teacher
  bool isActive; // New property to track active status

  Teacher({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.subject,
    required this.email,
    required this.contactNo,
    this.isActive = true, // Default to active
  });

  // Method to convert the model to a map for saving to the database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'subject': subject,
      'email': email,
      'contactNo': contactNo,
      'isActive': isActive, // Include isActive in the map
    };
  }

  // Factory method to create an instance from a map
  factory Teacher.fromMap(Map<String, dynamic> map) {
    return Teacher(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      subject: map['subject'],
      email: map['email'],
      contactNo: map['contactNo'],
      isActive: map['isActive'] ?? true, // Default to true if not present
    );
  }
}
