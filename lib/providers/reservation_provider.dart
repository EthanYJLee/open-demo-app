import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/reservation.dart';
import '../models/space.dart';
import '../models/time_slot.dart';
import '../utils/fake_data.dart';

part 'reservation_provider.g.dart';

@riverpod
class ReservationNotifier extends _$ReservationNotifier {
  @override
  List<Reservation> build() {
    return FakeData.reservations;
  }

  void addReservation(Reservation reservation) {
    state = [...state, reservation];
  }

  void updateReservationStatus(String reservationId, ReservationStatus status) {
    state = state.map((reservation) {
      if (reservation.id == reservationId) {
        return Reservation(
          id: reservation.id,
          userId: reservation.userId,
          userName: reservation.userName,
          branchId: reservation.branchId,
          branchName: reservation.branchName,
          spaceId: reservation.spaceId,
          spaceName: reservation.spaceName,
          date: reservation.date,
          timeSlot: reservation.timeSlot,
          duration: reservation.duration,
          price: reservation.price,
          discountedPrice: reservation.discountedPrice,
          status: status,
          notes: reservation.notes,
          createdAt: reservation.createdAt,
          updatedAt: DateTime.now(),
        );
      }
      return reservation;
    }).toList();
  }

  void cancelReservation(String reservationId) {
    updateReservationStatus(reservationId, ReservationStatus.cancelled);
  }

  void completeReservation(String reservationId) {
    updateReservationStatus(reservationId, ReservationStatus.completed);
  }
}

@riverpod
class SpaceNotifier extends _$SpaceNotifier {
  @override
  List<Space> build() {
    return FakeData.spaces;
  }

  List<Space> getAvailableSpaces() {
    return state.where((space) => space.isAvailable).toList();
  }

  Space? getSpaceById(String id) {
    try {
      return state.firstWhere((space) => space.id == id);
    } catch (e) {
      return null;
    }
  }
}

@riverpod
class TimeSlotNotifier extends _$TimeSlotNotifier {
  @override
  List<TimeSlot> build() {
    return FakeData.timeSlots;
  }

  List<TimeSlot> getAvailableTimeSlots() {
    return state.where((slot) => slot.isAvailable).toList();
  }

  List<TimeSlot> getTimeSlotsForDate(DateTime date) {
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
  Space? build() {
    return null;
  }

  void setSpace(Space space) {
    state = space;
  }

  void clearSelection() {
    state = null;
  }
}

@riverpod
class SelectedTimeSlotNotifier extends _$SelectedTimeSlotNotifier {
  @override
  TimeSlot? build() {
    return null;
  }

  void setTimeSlot(TimeSlot timeSlot) {
    state = timeSlot;
  }

  void clearSelection() {
    state = null;
  }
}
