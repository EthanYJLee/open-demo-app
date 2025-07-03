class TimeSlot {
  final String id;
  final String time;
  final bool isAvailable;

  TimeSlot({
    required this.id,
    required this.time,
    required this.isAvailable,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      id: json['id']?.toString() ?? '',
      time: json['time']?.toString() ?? '',
      isAvailable: json['is_available'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'time': time,
      'is_available': isAvailable,
    };
  }
}
