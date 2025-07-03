import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/reservation.dart';
import '../models/space.dart';
import '../models/time_slot.dart';
import '../services/repositories/repository_providers.dart';

part 'reservation_provider.g.dart';

@riverpod
class ReservationNotifier extends _$ReservationNotifier {
  @override
  Future<List<Reservation>> build() async {
    final repository = ref.read(reservationRepositoryProvider);
    return await repository.getAll();
  }

  Future<void> addReservation(Reservation reservation) async {
    final repository = ref.read(reservationRepositoryProvider);
    await repository.create(reservation);
    ref.invalidateSelf();
  }

  Future<void> updateReservationStatus(
      String reservationId, ReservationStatus status) async {
    final repository = ref.read(reservationRepositoryProvider);
    await repository.updateStatus(reservationId, status);
    ref.invalidateSelf();
  }

  Future<void> cancelReservation(String reservationId) async {
    final repository = ref.read(reservationRepositoryProvider);
    await repository.cancelReservation(reservationId);
    ref.invalidateSelf();
  }

  Future<void> completeReservation(String reservationId) async {
    final repository = ref.read(reservationRepositoryProvider);
    await repository.completeReservation(reservationId);
    ref.invalidateSelf();
  }

  // 도메인별 특화 메서드들
  Future<List<Reservation>> getByUserId(String userId) async {
    final repository = ref.read(reservationRepositoryProvider);
    return await repository.getByUserId(userId);
  }

  Future<List<Reservation>> getByBranchId(String branchId) async {
    final repository = ref.read(reservationRepositoryProvider);
    return await repository.getByBranchId(branchId);
  }

  Future<List<Reservation>> getByDate(DateTime date) async {
    final repository = ref.read(reservationRepositoryProvider);
    return await repository.getByDate(date);
  }
}

@riverpod
class SpaceNotifier extends _$SpaceNotifier {
  @override
  Future<List<Space>> build() async {
    final repository = ref.read(spaceRepositoryProvider);
    return await repository.getAll();
  }

  Future<List<Space>> getAvailableSpaces() async {
    final repository = ref.read(spaceRepositoryProvider);
    return await repository.getAvailableSpaces();
  }

  Future<Space?> getSpaceById(String id) async {
    final repository = ref.read(spaceRepositoryProvider);
    return await repository.getById(id);
  }

  Future<List<Space>> getByBranchId(String branchId) async {
    final repository = ref.read(spaceRepositoryProvider);
    return await repository.getByBranchId(branchId);
  }

  Future<List<Space>> getByCategory(String category) async {
    final repository = ref.read(spaceRepositoryProvider);
    return await repository.getByCategory(category);
  }

  Future<void> updateAvailability(String spaceId, bool isAvailable) async {
    final repository = ref.read(spaceRepositoryProvider);
    await repository.updateAvailability(spaceId, isAvailable);
    ref.invalidateSelf();
  }
}

@riverpod
class TimeSlotNotifier extends _$TimeSlotNotifier {
  @override
  Future<List<TimeSlot>> build() async {
    // TimeSlot은 현재 하드코딩된 데이터를 사용하므로 그대로 유지
    return [
      TimeSlot(id: 'time_1', time: '06:00-08:00', isAvailable: true),
      TimeSlot(id: 'time_2', time: '08:00-10:00', isAvailable: true),
      TimeSlot(id: 'time_3', time: '10:00-12:00', isAvailable: false),
      TimeSlot(id: 'time_4', time: '12:00-14:00', isAvailable: true),
      TimeSlot(id: 'time_5', time: '14:00-16:00', isAvailable: true),
      TimeSlot(id: 'time_6', time: '16:00-18:00', isAvailable: false),
      TimeSlot(id: 'time_7', time: '18:00-20:00', isAvailable: true),
      TimeSlot(id: 'time_8', time: '20:00-22:00', isAvailable: true),
    ];
  }

  Future<List<TimeSlot>> getAvailableTimeSlots() async {
    final timeSlots = await future;
    return timeSlots.where((slot) => slot.isAvailable).toList();
  }

  Future<List<TimeSlot>> getTimeSlotsForDate(DateTime date) async {
    // 실제 구현에서는 해당 날짜의 예약 현황을 확인하여
    // 예약 가능한 시간대만 반환해야 합니다.
    return getAvailableTimeSlots();
  }
}

@riverpod
class SelectedDateNotifier extends _$SelectedDateNotifier {
  @override
  DateTime build() {
    return DateTime.now();
  }

  void setDate(DateTime date) {
    state = date;
  }

  void nextDay() {
    state = state.add(const Duration(days: 1));
  }

  void previousDay() {
    state = state.subtract(const Duration(days: 1));
  }
}

@riverpod
class SelectedSpaceNotifier extends _$SelectedSpaceNotifier {
  @override
  Future<Space?> build() async {
    return null;
  }

  void setSpace(Space space) {
    state = AsyncValue.data(space);
  }

  void clearSelection() {
    state = const AsyncValue.data(null);
  }
}

@riverpod
class SelectedTimeSlotNotifier extends _$SelectedTimeSlotNotifier {
  @override
  Future<TimeSlot?> build() async {
    return null;
  }

  void setTimeSlot(TimeSlot timeSlot) {
    state = AsyncValue.data(timeSlot);
  }

  void clearSelection() {
    state = const AsyncValue.data(null);
  }
}

@riverpod
class UserTodayReservationsNotifier extends _$UserTodayReservationsNotifier {
  @override
  Future<List<Reservation>> build(String userId) async {
    final repository = ref.read(reservationRepositoryProvider);
    final userReservations = await repository.getByUserId(userId);

    final today = DateTime.now();
    return userReservations.where((r) {
      return r.date.year == today.year &&
          r.date.month == today.month &&
          r.date.day == today.day;
    }).toList();
  }
}
