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
  final String userName;
  final String branchId;
  final String branchName;
  final String spaceId;
  final String spaceName;
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
    required this.userName,
    required this.branchId,
    required this.branchName,
    required this.spaceId,
    required this.spaceName,
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
      id: json['id'],
      userId: json['userId'],
      userName: json['userName'],
      branchId: json['branchId'],
      branchName: json['branchName'],
      spaceId: json['spaceId'],
      spaceName: json['spaceName'],
      date: DateTime.parse(json['date']),
      timeSlot: json['timeSlot'],
      duration: json['duration'],
      price: json['price'],
      discountedPrice: json['discountedPrice'],
      status: ReservationStatus.values.firstWhere(
        (e) => e.name == json['status'],
      ),
      notes: json['notes'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'branchId': branchId,
      'branchName': branchName,
      'spaceId': spaceId,
      'spaceName': spaceName,
      'date': date.toIso8601String(),
      'timeSlot': timeSlot,
      'duration': duration,
      'price': price,
      'discountedPrice': discountedPrice,
      'status': status.name,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
