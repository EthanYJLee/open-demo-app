import '../api/supabase_service.dart';
import '../../models/space.dart';
import 'base_repository.dart';

class SpaceRepository implements BaseRepository<Space> {
  final SupabaseService _supabaseService = SupabaseService();
  static const String _tableName = 'spaces';

  @override
  Future<List<Space>> getAll() async {
    try {
      final data = await _supabaseService.select(_tableName);
      return data.map((json) => Space.fromJson(json)).toList();
    } catch (e) {
      throw ApiException('Failed to fetch spaces: $e');
    }
  }

  @override
  Future<Space?> getById(String id) async {
    try {
      final data = await _supabaseService.getById(_tableName, id);
      return data != null ? Space.fromJson(data) : null;
    } catch (e) {
      throw ApiException('Failed to fetch space by id: $e');
    }
  }

  @override
  Future<void> create(Space space) async {
    try {
      await _supabaseService.insert(_tableName, space.toJson());
    } catch (e) {
      throw ApiException('Failed to create space: $e');
    }
  }

  @override
  Future<void> update(Space space) async {
    try {
      await _supabaseService.updateById(_tableName, space.id, space.toJson());
    } catch (e) {
      throw ApiException('Failed to update space: $e');
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await _supabaseService.deleteById(_tableName, id);
    } catch (e) {
      throw ApiException('Failed to delete space: $e');
    }
  }

  // 도메인별 특화 메서드들
  Future<List<Space>> getByBranchId(String branchId) async {
    try {
      final data = await _supabaseService
          .select(_tableName, filters: {'branch_id': branchId});
      return data.map((json) => Space.fromJson(json)).toList();
    } catch (e) {
      throw ApiException('Failed to fetch spaces by branch id: $e');
    }
  }

  Future<List<Space>> getAvailableSpaces() async {
    try {
      final data = await _supabaseService
          .select(_tableName, filters: {'is_available': true});
      return data.map((json) => Space.fromJson(json)).toList();
    } catch (e) {
      throw ApiException('Failed to fetch available spaces: $e');
    }
  }

  Future<List<Space>> getByCategory(String category) async {
    try {
      final data = await _supabaseService
          .select(_tableName, filters: {'category': category});
      return data.map((json) => Space.fromJson(json)).toList();
    } catch (e) {
      throw ApiException('Failed to fetch spaces by category: $e');
    }
  }

  Future<void> updateAvailability(String spaceId, bool isAvailable) async {
    try {
      await _supabaseService
          .updateById(_tableName, spaceId, {'is_available': isAvailable});
    } catch (e) {
      throw ApiException('Failed to update space availability: $e');
    }
  }
}
