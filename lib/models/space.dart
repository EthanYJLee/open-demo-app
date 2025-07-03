class Space {
  final String id;
  final String branchId;
  final String name;
  final String description;
  final int capacity;
  final int pricePerHour;
  final List<String> amenities;
  final List<String> images;
  final bool isAvailable;
  final String category; // 1인실, 2인실, 그룹실 등
  final Map<String, dynamic> operatingHours;
  final DateTime createdAt;
  final DateTime updatedAt;

  Space({
    required this.id,
    required this.branchId,
    required this.name,
    required this.description,
    required this.capacity,
    required this.pricePerHour,
    required this.amenities,
    required this.images,
    required this.isAvailable,
    required this.category,
    required this.operatingHours,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Space.fromJson(Map<String, dynamic> json) {
    return Space(
      id: json['id'],
      branchId: json['branchId'],
      name: json['name'],
      description: json['description'],
      capacity: json['capacity'],
      pricePerHour: json['pricePerHour'],
      amenities: List<String>.from(json['amenities']),
      images: List<String>.from(json['images']),
      isAvailable: json['isAvailable'],
      category: json['category'],
      operatingHours: Map<String, dynamic>.from(json['operatingHours']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'branchId': branchId,
      'name': name,
      'description': description,
      'capacity': capacity,
      'pricePerHour': pricePerHour,
      'amenities': amenities,
      'images': images,
      'isAvailable': isAvailable,
      'category': category,
      'operatingHours': operatingHours,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
