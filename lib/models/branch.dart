class Branch {
  final String id;
  final String name;
  final String address;
  final String phone;
  final String description;
  final double latitude;
  final double longitude;
  final List<String> images;
  final List<String> amenities;
  final Map<String, dynamic> operatingHours;
  final bool isActive;
  final String managerName;
  final String managerPhone;
  final String? city;
  final String? district;
  final DateTime createdAt;
  final DateTime updatedAt;

  Branch({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.images,
    required this.amenities,
    required this.operatingHours,
    required this.isActive,
    required this.managerName,
    required this.managerPhone,
    this.city,
    this.district,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      longitude: (json['longitude'] ?? 0.0).toDouble(),
      images: json['images'] != null ? List<String>.from(json['images']) : [],
      amenities:
          json['amenities'] != null ? List<String>.from(json['amenities']) : [],
      operatingHours: json['operating_hours'] != null
          ? Map<String, dynamic>.from(json['operating_hours'])
          : {},
      isActive: json['is_active'] ?? true,
      managerName: json['manager_name']?.toString() ?? '',
      managerPhone: json['manager_phone']?.toString() ?? '',
      city: json['city']?.toString(),
      district: json['district']?.toString(),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'].toString())
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'].toString())
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'phone': phone,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'images': images,
      'amenities': amenities,
      'operating_hours': operatingHours,
      'is_active': isActive,
      'manager_name': managerName,
      'manager_phone': managerPhone,
      'city': city,
      'district': district,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
