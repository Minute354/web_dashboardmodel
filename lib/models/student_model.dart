// models/student_model.dart
class Student {
  final int id;
  final String name;
  final String studentClass;
  final String division;
  final String parentName;
  final String place;
  final String address;
  final int age;
  final String gender;
  bool isActive;

  var lastName;

  Student({
    required this.id,
    required this.name,
    required this.studentClass,
    required this.division,
    required this.parentName,
    required this.place,
    required this.address,
    required this.age,
    required this.gender,
    this.isActive = true, 
    
  });

  get firstName => null;

  get className => null;
}