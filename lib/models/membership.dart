enum MembershipType {
  basic('기본'),
  silver('실버'),
  gold('골드'),
  platinum('플래티넘');

  const MembershipType(this.displayName);
  final String displayName;
}

enum MembershipStatus {
  active('활성'),
  expired('만료'),
  suspended('정지');

  const MembershipStatus(this.displayName);
  final String displayName;
}

class Membership {
  final String id;
  final String userId;
  final MembershipType type;
  final MembershipStatus status;
  final DateTime startDate;
  final DateTime endDate;
  final int points;
  final int totalSpent;
  final int visitCount;
  final List<String> usedBranches;
  final DateTime createdAt;
  final DateTime updatedAt;

  Membership({
    required this.id,
    required this.userId,
    required this.type,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.points,
    required this.totalSpent,
    required this.visitCount,
    required this.usedBranches,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Membership.fromJson(Map<String, dynamic> json) {
    return Membership(
      id: json['id'],
      userId: json['userId'],
      type: MembershipType.values.firstWhere(
        (e) => e.name == json['type'],
      ),
      status: MembershipStatus.values.firstWhere(
        (e) => e.name == json['status'],
      ),
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      points: json['points'],
      totalSpent: json['totalSpent'],
      visitCount: json['visitCount'],
      usedBranches: List<String>.from(json['usedBranches']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'type': type.name,
      'status': status.name,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'points': points,
      'totalSpent': totalSpent,
      'visitCount': visitCount,
      'usedBranches': usedBranches,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  bool get isActive =>
      status == MembershipStatus.active && DateTime.now().isBefore(endDate);

  double get discountRate {
    switch (type) {
      case MembershipType.basic:
        return 0.0;
      case MembershipType.silver:
        return 0.05; // 5%
      case MembershipType.gold:
        return 0.10; // 10%
      case MembershipType.platinum:
        return 0.15; // 15%
    }
  }
}
