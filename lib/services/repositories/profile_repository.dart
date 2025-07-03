import '../api/supabase_service.dart';
import '../../models/profile.dart';
import 'base_repository.dart';

class ProfileRepository implements BaseRepository<Profile> {
  final SupabaseService _supabaseService = SupabaseService();
  static const String _tableName = 'profiles';

  @override
  Future<List<Profile>> getAll() async {
    try {
      final data = await _supabaseService.select(_tableName);
      return data.map((json) => Profile.fromJson(json)).toList();
    } catch (e) {
      throw ApiException('Failed to fetch profiles: $e');
    }
  }

  @override
  Future<Profile?> getById(String id) async {
    try {
      final data = await _supabaseService.getById(_tableName, id);
      return data != null ? Profile.fromJson(data) : null;
    } catch (e) {
      throw ApiException('Failed to fetch profile by id: $e');
    }
  }

  @override
  Future<void> create(Profile profile) async {
    try {
      await _supabaseService.insert(_tableName, profile.toJson());
    } catch (e) {
      throw ApiException('Failed to create profile: $e');
    }
  }

  @override
  Future<void> update(Profile profile) async {
    try {
      await _supabaseService.updateById(
          _tableName, profile.id, profile.toJson());
    } catch (e) {
      throw ApiException('Failed to update profile: $e');
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await _supabaseService.deleteById(_tableName, id);
    } catch (e) {
      throw ApiException('Failed to delete profile: $e');
    }
  }

  // 도메인별 특화 메서드들
  Future<Profile?> getByEmail(String email) async {
    try {
      final data = await _supabaseService
          .selectMaybeSingle(_tableName, filters: {'email': email});
      return data != null ? Profile.fromJson(data) : null;
    } catch (e) {
      throw ApiException('Failed to fetch profile by email: $e');
    }
  }

  Future<void> updateLastLogin(String userId) async {
    try {
      await _supabaseService.updateById(_tableName, userId,
          {'last_login_at': DateTime.now().toIso8601String()});
    } catch (e) {
      throw ApiException('Failed to update last login: $e');
    }
  }

  Future<Profile> getOrCreateProfile(
      String userId, String name, String email) async {
    try {
      // 기존 프로필 확인
      final existingProfile = await getById(userId);
      if (existingProfile != null) {
        return existingProfile;
      }

      // 새 프로필 생성
      final newProfile = Profile(
        id: userId,
        name: name,
        email: email,
        phone: '',
        createdAt: DateTime.now(),
        lastLoginAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await create(newProfile);
      return newProfile;
    } catch (e) {
      throw ApiException('Failed to get or create profile: $e');
    }
  }
}
