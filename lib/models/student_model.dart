class Student {
  String id;
  String name;
  String division;
  String studentClass;
  String parentName;
  int age;
  String gender;
  String place;
  bool isActive;

  Student({
    required this.id,
    required this.name,
    required this.division,
    required this.studentClass,
    required this.parentName,
    required this.age,
    required this.gender,
    required this.place,
    this.isActive = true,
  });
}
