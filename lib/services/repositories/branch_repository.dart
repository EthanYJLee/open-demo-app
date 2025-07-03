import '../api/supabase_service.dart';
import '../../models/branch.dart';
import 'base_repository.dart';

class BranchRepository implements BaseRepository<Branch> {
  final SupabaseService _supabaseService = SupabaseService();
  static const String _tableName = 'branches';

  @override
  Future<List<Branch>> getAll() async {
    try {
      final data = await _supabaseService.select(_tableName);
      return data.map((json) => Branch.fromJson(json)).toList();
    } catch (e) {
      throw ApiException('Failed to fetch branches: $e');
    }
  }

  @override
  Future<Branch?> getById(String id) async {
    try {
      final data = await _supabaseService.getById(_tableName, id);
      return data != null ? Branch.fromJson(data) : null;
    } catch (e) {
      throw ApiException('Failed to fetch branch by id: $e');
    }
  }

  @override
  Future<void> create(Branch branch) async {
    try {
      await _supabaseService.insert(_tableName, branch.toJson());
    } catch (e) {
      throw ApiException('Failed to create branch: $e');
    }
  }

  @override
  Future<void> update(Branch branch) async {
    try {
      await _supabaseService.updateById(_tableName, branch.id, branch.toJson());
    } catch (e) {
      throw ApiException('Failed to update branch: $e');
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await _supabaseService.deleteById(_tableName, id);
    } catch (e) {
      throw ApiException('Failed to delete branch: $e');
    }
  }

  // 도메인별 특화 메서드들
  Future<List<Branch>> getByCityAndDistrict(
      String city, String district) async {
    try {
      // 빈 문자열이나 null 값 처리
      Map<String, dynamic> filters = {};

      if (city.isNotEmpty && city != 'null') {
        filters['city'] = city;
      }

      if (district.isNotEmpty && district != 'null') {
        filters['district'] = district;
      }

      // 필터가 비어있으면 빈 리스트 반환
      if (filters.isEmpty) {
        return [];
      }

      final data = await _supabaseService.select(_tableName, filters: filters);
      return data.map((json) => Branch.fromJson(json)).toList();
    } catch (e) {
      throw ApiException('Failed to fetch branches by city and district: $e');
    }
  }

  Future<List<Branch>> getActiveBranches() async {
    try {
      final data = await _supabaseService.select(_tableName, filters: {
        'is_active': true,
      });
      return data.map((json) => Branch.fromJson(json)).toList();
    } catch (e) {
      throw ApiException('Failed to fetch active branches: $e');
    }
  }

  Future<List<Branch>> getByCity(String city) async {
    try {
      final data = await _supabaseService.select(_tableName, filters: {
        'city': city,
      });
      return data.map((json) => Branch.fromJson(json)).toList();
    } catch (e) {
      throw ApiException('Failed to fetch branches by city: $e');
    }
  }
}
