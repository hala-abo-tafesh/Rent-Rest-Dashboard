class LoginModel {
  String? message;
  User? user;
  String? token;

  LoginModel({this.message, this.user, this.token});

  LoginModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    user = json['User'] != null ? User.fromJson(json['User']) : null;
    token = json['Token'];
  }
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? birthDate;
  String? role;
  String? fcmToken;
  String? emailVerifiedAt;
  String? personalImageUrl;
  String? personalImagePublicId;
  String? idImageUrl;
  String? idImagePublicId;
  String? status;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
        this.firstName,
        this.lastName,
        this.phone,
        this.email,
        this.birthDate,
        this.role,
        this.fcmToken,
        this.emailVerifiedAt,
        this.personalImageUrl,
        this.personalImagePublicId,
        this.idImageUrl,
        this.idImagePublicId,
        this.status,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    email = json['email'];
    birthDate = json['BirthDate'];
    role = json['role'];
    fcmToken = json['fcm_token'];
    emailVerifiedAt = json['email_verified_at'];
    personalImageUrl = json['personal_image_url'];
    personalImagePublicId = json['personal_image_public_id'];
    idImageUrl = json['id_image_url'];
    idImagePublicId = json['id_image_public_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
