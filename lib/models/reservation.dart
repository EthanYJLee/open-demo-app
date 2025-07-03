enum ReservationStatus {
  reserved('예약됨'),
  completed('완료'),
  cancelled('취소됨');

  const ReservationStatus(this.displayName);
  final String displayName;
}

class Reservation {
  final String id;
  final String userId;
  final String branchId;
  final String spaceId;
  final DateTime date;
  final String timeSlot;
  final int duration; // 분 단위
  final int price;
  final int discountedPrice;
  final ReservationStatus status;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  Reservation({
    required this.id,
    required this.userId,
    required this.branchId,
    required this.spaceId,
    required this.date,
    required this.timeSlot,
    required this.duration,
    required this.price,
    required this.discountedPrice,
    required this.status,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id']?.toString() ?? '',
      userId: json['user_id']?.toString() ?? '',
      branchId: json['branch_id']?.toString() ?? '',
      spaceId: json['space_id']?.toString() ?? '',
      date: json['date'] != null
          ? DateTime.parse(json['date'].toString())
          : DateTime.now(),
      timeSlot: json['time_slot']?.toString() ?? '',
      duration: json['duration'] ?? 0,
      price: json['price'] ?? 0,
      discountedPrice: json['discounted_price'] ?? 0,
      status: json['status'] != null
          ? ReservationStatus.values.firstWhere(
              (e) => e.name == json['status'],
              orElse: () => ReservationStatus.reserved,
            )
          : ReservationStatus.reserved,
      notes: json['notes']?.toString(),
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
      'user_id': userId,
      'branch_id': branchId,
      'space_id': spaceId,
      'date': date.toIso8601String(),
      'time_slot': timeSlot,
      'duration': duration,
      'price': price,
      'discounted_price': discountedPrice,
      'status': status.name,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
