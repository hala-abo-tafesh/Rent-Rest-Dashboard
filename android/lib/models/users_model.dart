class UsersModel {
  final int id;
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String role;
  final String status;

  final String? fcmToken;
  final DateTime? emailVerifiedAt;
  final DateTime? birthDate;

  final String imageUrl;
  final String? imagePublicId;

  final String? idImageUrl;
  final String? idImagePublicId;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  UsersModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.role,
    required this.status,
    required this.imageUrl,
    this.fcmToken,
    this.emailVerifiedAt,
    this.birthDate,
    this.imagePublicId,
    this.idImageUrl,
    this.idImagePublicId,
    this.createdAt,
    this.updatedAt,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(dynamic v) {
      if (v == null) return null;
      final s = v.toString().trim();
      if (s.isEmpty) return null;
      try {
        return DateTime.parse(s);
      } catch (_) {
        return null;
      }
    }

    return UsersModel(
      id: (json['id'] as num).toInt(),
      firstName: (json['first_name'] ?? '').toString(),
      lastName: (json['last_name'] ?? '').toString(),
      phone: (json['phone'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      role: (json['role'] ?? '').toString(),
      status: (json['status'] ?? '').toString(),
      fcmToken: json['fcm_token']?.toString(),
      emailVerifiedAt: parseDate(json['email_verified_at']),
      birthDate: parseDate(json['BirthDate'] ?? json['birth_date']),
      imageUrl: (json['personal_image_url'] ?? '').toString(),
      imagePublicId: json['personal_image_public_id']?.toString(),
      idImageUrl: json['id_image_url']?.toString(),
      idImagePublicId: json['id_image_public_id']?.toString(),
      createdAt: parseDate(json['created_at']),
      updatedAt: parseDate(json['updated_at']),
    );
  }

  bool get isVerified => emailVerifiedAt != null;
}