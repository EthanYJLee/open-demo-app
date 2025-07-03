class Profile {
  final String id;
  final String email;
  final String name;
  final String phone;
  final String? profileImage;
  final DateTime createdAt;
  final DateTime lastLoginAt;
  final DateTime updatedAt;

  Profile({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    this.profileImage,
    required this.createdAt,
    required this.lastLoginAt,
    required this.updatedAt,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      profileImage: json['profile_image']?.toString(),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'].toString())
          : DateTime.now(),
      lastLoginAt: json['last_login_at'] != null
          ? DateTime.parse(json['last_login_at'].toString())
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'].toString())
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'profile_image': profileImage ?? "",
      'created_at': createdAt.toIso8601String(),
      'last_login_at': lastLoginAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
