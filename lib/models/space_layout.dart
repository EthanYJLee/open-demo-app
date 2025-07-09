import 'space.dart';

class SpaceLayout {
  final String id;
  final String branchId;
  final String name;
  final String? description;
  final Map<String, dynamic> layoutData;
  final String? backgroundImage;
  final int width;
  final int height;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<RoomPlacement> roomPlacements;

  SpaceLayout({
    required this.id,
    required this.branchId,
    required this.name,
    this.description,
    required this.layoutData,
    this.backgroundImage,
    required this.width,
    required this.height,
    required this.createdAt,
    required this.updatedAt,
    this.roomPlacements = const [],
  });

  factory SpaceLayout.fromJson(Map<String, dynamic> json) {
    return SpaceLayout(
      id: json['id'],
      branchId: json['branch_id'],
      name: json['name'],
      description: json['description'],
      layoutData: json['layout_data'] ?? {},
      backgroundImage: json['background_image'],
      width: json['width'] ?? 800,
      height: json['height'] ?? 600,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      roomPlacements: (json['room_placements'] as List<dynamic>?)
              ?.map((e) => RoomPlacement.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'branch_id': branchId,
      'name': name,
      'description': description,
      'layout_data': layoutData,
      'background_image': backgroundImage,
      'width': width,
      'height': height,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'room_placements': roomPlacements.map((e) => e.toJson()).toList(),
    };
  }
}

class RoomPlacement {
  final String id;
  final String? layoutId;
  final String? spaceId;
  final int xPosition;
  final int yPosition;
  final int width;
  final int height;
  final int rotation;
  final String? roomNumber;
  final String? roomName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Space? space;

  RoomPlacement({
    required this.id,
    this.layoutId,
    this.spaceId,
    required this.xPosition,
    required this.yPosition,
    required this.width,
    required this.height,
    this.rotation = 0,
    this.roomNumber,
    this.roomName,
    required this.createdAt,
    required this.updatedAt,
    this.space,
  });

  factory RoomPlacement.fromJson(Map<String, dynamic> json) {
    return RoomPlacement(
      id: json['id'],
      layoutId: json['layout_id'],
      spaceId: json['space_id'],
      xPosition: json['x_position'] ?? 0,
      yPosition: json['y_position'] ?? 0,
      width: json['width'] ?? 100,
      height: json['height'] ?? 100,
      rotation: json['rotation'] ?? 0,
      roomNumber: json['room_number'],
      roomName: json['room_name'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      space: json['spaces'] != null ? Space.fromJson(json['spaces']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'layout_id': layoutId,
      'space_id': spaceId,
      'x_position': xPosition,
      'y_position': yPosition,
      'width': width,
      'height': height,
      'rotation': rotation,
      'room_number': roomNumber,
      'room_name': roomName,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'spaces': space?.toJson(),
    };
  }
}
