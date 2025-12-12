class AdminModel {
  final String firstName;
  final String lastName;
  final String imageUrl;
   String status;

 AdminModel({
    required this.firstName,
    required this.lastName,
    required this.imageUrl,
    this.status= 'pending',
  });

  static List<AdminModel> adminData = [
    AdminModel(
        firstName: 'firstName',
        lastName: 'lastName',
        imageUrl: 'imageUrl',
    ),
    AdminModel(
        firstName: 'firstName',
        lastName: 'lastName',
        imageUrl: 'imageUrl',
    ),
    AdminModel(
        firstName: 'firstName',
        lastName: 'lastName',
        imageUrl: 'imageUrl',
    ),
    AdminModel(
        firstName: 'firstName',
        lastName: 'lastName',
        imageUrl: 'imageUrl',
    ),

  ];
}
