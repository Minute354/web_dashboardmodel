// models/student_model.dart
class Student {
  final int id;
  final String name;
  final String studentClass;
  final String division;
  final String parentName;
  final String place;
  final int age;
  final String gender;
  bool isActive;

  Student({
    required this.id,
    required this.name,
    required this.studentClass,
    required this.division,
    required this.parentName,
    required this.place,
    required this.age,
    required this.gender,
    this.isActive = true,
  });
}
