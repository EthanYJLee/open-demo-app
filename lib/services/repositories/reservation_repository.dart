import '../api/supabase_service.dart';
import '../../models/reservation.dart';
import 'base_repository.dart';

class ReservationRepository implements BaseRepository<Reservation> {
  final SupabaseService _supabaseService = SupabaseService();
  static const String _tableName = 'reservations';

  @override
  Future<List<Reservation>> getAll() async {
    try {
      final data = await _supabaseService.select(_tableName);
      return data.map((json) => Reservation.fromJson(json)).toList();
    } catch (e) {
      throw ApiException('Failed to fetch reservations: $e');
    }
  }

  @override
  Future<Reservation?> getById(String id) async {
    try {
      final data = await _supabaseService.getById(_tableName, id);
      return data != null ? Reservation.fromJson(data) : null;
    } catch (e) {
      throw ApiException('Failed to fetch reservation by id: $e');
    }
  }

  @override
  Future<void> create(Reservation reservation) async {
    try {
      await _supabaseService.insert(_tableName, reservation.toJson());
    } catch (e) {
      throw ApiException('Failed to create reservation: $e');
    }
  }

  @override
  Future<void> update(Reservation reservation) async {
    try {
      await _supabaseService.updateById(
          _tableName, reservation.id, reservation.toJson());
    } catch (e) {
      throw ApiException('Failed to update reservation: $e');
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await _supabaseService.deleteById(_tableName, id);
    } catch (e) {
      throw ApiException('Failed to delete reservation: $e');
    }
  }

  // 도메인별 특화 메서드들
  Future<List<Reservation>> getByUserId(String userId) async {
    try {
      final data = await _supabaseService
          .select(_tableName, filters: {'user_id': userId});
      return data.map((json) => Reservation.fromJson(json)).toList();
    } catch (e) {
      throw ApiException('Failed to fetch reservations by user id: $e');
    }
  }

  Future<List<Reservation>> getByBranchId(String branchId) async {
    try {
      final data = await _supabaseService
          .select(_tableName, filters: {'branch_id': branchId});
      return data.map((json) => Reservation.fromJson(json)).toList();
    } catch (e) {
      throw ApiException('Failed to fetch reservations by branch id: $e');
    }
  }

  Future<List<Reservation>> getByDate(DateTime date) async {
    try {
      final dateString = date.toIso8601String().split('T')[0];
      final data = await _supabaseService
          .select(_tableName, filters: {'date': dateString});
      return data.map((json) => Reservation.fromJson(json)).toList();
    } catch (e) {
      throw ApiException('Failed to fetch reservations by date: $e');
    }
  }

  Future<void> updateStatus(
      String reservationId, ReservationStatus status) async {
    try {
      await _supabaseService
          .updateById(_tableName, reservationId, {'status': status.name});
    } catch (e) {
      throw ApiException('Failed to update reservation status: $e');
    }
  }

  Future<void> cancelReservation(String reservationId) async {
    await updateStatus(reservationId, ReservationStatus.cancelled);
  }

  Future<void> completeReservation(String reservationId) async {
    await updateStatus(reservationId, ReservationStatus.completed);
  }
}
