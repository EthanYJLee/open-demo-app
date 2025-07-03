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
    required this.createdAt,
    required this.updatedAt,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      phone: json['phone'],
      description: json['description'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      images: List<String>.from(json['images']),
      amenities: List<String>.from(json['amenities']),
      operatingHours: Map<String, dynamic>.from(json['operatingHours']),
      isActive: json['isActive'],
      managerName: json['managerName'],
      managerPhone: json['managerPhone'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
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
      'operatingHours': operatingHours,
      'isActive': isActive,
      'managerName': managerName,
      'managerPhone': managerPhone,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
