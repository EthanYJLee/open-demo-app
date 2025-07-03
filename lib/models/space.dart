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
      id: json['id']?.toString() ?? '',
      branchId: json['branch_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      capacity: json['capacity'] ?? 0,
      pricePerHour: json['price_per_hour'] ?? 0,
      amenities:
          json['amenities'] != null ? List<String>.from(json['amenities']) : [],
      images: json['images'] != null ? List<String>.from(json['images']) : [],
      isAvailable: json['is_available'] ?? true,
      category: json['category']?.toString() ?? '',
      operatingHours: json['operating_hours'] != null
          ? Map<String, dynamic>.from(json['operating_hours'])
          : {},
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
      'branch_id': branchId,
      'name': name,
      'description': description,
      'capacity': capacity,
      'price_per_hour': pricePerHour,
      'amenities': amenities,
      'images': images,
      'is_available': isAvailable,
      'category': category,
      'operating_hours': operatingHours,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
