import '../api/supabase_service.dart';
import '../../models/space_layout.dart';
import 'base_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LayoutRepository implements BaseRepository<SpaceLayout> {
  final SupabaseService _supabaseService = SupabaseService();
  static const String _tableName = 'space_layouts';

  @override
  Future<List<SpaceLayout>> getAll() async {
    try {
      final data = await _supabaseService.select(_tableName);
      return data.map((json) => SpaceLayout.fromJson(json)).toList();
    } catch (e) {
      throw ApiException('Failed to fetch layouts: $e');
    }
  }

  @override
  Future<SpaceLayout?> getById(String id) async {
    try {
      final data = await _supabaseService.getById(_tableName, id);
      return data != null ? SpaceLayout.fromJson(data) : null;
    } catch (e) {
      throw ApiException('Failed to fetch layout by id: $e');
    }
  }

  @override
  Future<void> create(SpaceLayout layout) async {
    try {
      await _supabaseService.insert(_tableName, layout.toJson());
    } catch (e) {
      throw ApiException('Failed to create layout: $e');
    }
  }

  @override
  Future<void> update(SpaceLayout layout) async {
    try {
      await _supabaseService.updateById(_tableName, layout.id, layout.toJson());
    } catch (e) {
      throw ApiException('Failed to update layout: $e');
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await _supabaseService.deleteById(_tableName, id);
    } catch (e) {
      throw ApiException('Failed to delete layout: $e');
    }
  }

  // 도메인별 특화 메서드들
  Future<List<SpaceLayout>> getLayouts(String branchId) async {
    try {
      final data = await _supabaseService.select(_tableName, filters: {
        'branch_id': branchId,
      });
      return data.map((json) => SpaceLayout.fromJson(json)).toList();
    } catch (e) {
      throw ApiException('Failed to fetch layouts: $e');
    }
  }

  Future<SpaceLayout> getLayoutWithRoomPlacements(String layoutId) async {
    try {
      final response =
          await Supabase.instance.client.from(_tableName).select('''
            *,
            room_placements (
              *,
              spaces (*)
            )
          ''').eq('id', layoutId).single();

      return SpaceLayout.fromJson(response);
    } catch (e) {
      throw ApiException('Failed to fetch layout with room placements: $e');
    }
  }

  Future<SpaceLayout?> getFirstLayout(String branchId) async {
    try {
      final layouts = await getLayouts(branchId);
      if (layouts.isNotEmpty) {
        return await getLayoutWithRoomPlacements(layouts.first.id);
      }
      return null;
    } catch (e) {
      throw ApiException('Failed to fetch first layout: $e');
    }
  }
}
