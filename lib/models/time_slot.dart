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
      id: json['id'],
      time: json['time'],
      isAvailable: json['isAvailable'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'time': time,
      'isAvailable': isAvailable,
    };
  }
}
