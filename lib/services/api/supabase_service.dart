import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  SupabaseClient get client => Supabase.instance.client;

  // 기본 CRUD 작업들
  Future<List<Map<String, dynamic>>> select(String table,
      {Map<String, dynamic>? filters}) async {
    try {
      var query = client.from(table).select();

      if (filters != null) {
        filters.forEach((key, value) {
          query = query.eq(key, value);
        });
      }

      final response = await query;
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      throw ApiException('Failed to fetch data from $table: $e');
    }
  }

  Future<Map<String, dynamic>?> selectSingle(String table,
      {Map<String, dynamic>? filters}) async {
    try {
      var query = client.from(table).select();

      if (filters != null) {
        filters.forEach((key, value) {
          query = query.eq(key, value);
        });
      }

      final response = await query.single();
      return Map<String, dynamic>.from(response);
    } catch (e) {
      if (e.toString().contains('No rows found')) {
        return null;
      }
      throw ApiException('Failed to fetch single record from $table: $e');
    }
  }

  Future<Map<String, dynamic>?> selectMaybeSingle(String table,
      {Map<String, dynamic>? filters}) async {
    try {
      var query = client.from(table).select();

      if (filters != null) {
        filters.forEach((key, value) {
          query = query.eq(key, value);
        });
      }

      final response = await query.maybeSingle();
      return response != null ? Map<String, dynamic>.from(response) : null;
    } catch (e) {
      throw ApiException('Failed to fetch maybe single record from $table: $e');
    }
  }

  Future<void> insert(String table, Map<String, dynamic> data) async {
    try {
      await client.from(table).insert(data);
    } catch (e) {
      throw ApiException('Failed to insert data into $table: $e');
    }
  }

  Future<void> update(String table, Map<String, dynamic> data,
      {Map<String, dynamic>? filters}) async {
    try {
      var query = client.from(table).update(data);

      if (filters != null) {
        filters.forEach((key, value) {
          query = query.eq(key, value);
        });
      }

      await query;
    } catch (e) {
      throw ApiException('Failed to update data in $table: $e');
    }
  }

  Future<void> delete(String table, {Map<String, dynamic>? filters}) async {
    try {
      var query = client.from(table).delete();

      if (filters != null) {
        filters.forEach((key, value) {
          query = query.eq(key, value);
        });
      }

      await query;
    } catch (e) {
      throw ApiException('Failed to delete data from $table: $e');
    }
  }

  // 특정 ID로 작업하는 편의 메서드들
  Future<Map<String, dynamic>?> getById(String table, String id) async {
    return await selectSingle(table, filters: {'id': id});
  }

  Future<void> updateById(
      String table, String id, Map<String, dynamic> data) async {
    await update(table, data, filters: {'id': id});
  }

  Future<void> deleteById(String table, String id) async {
    await delete(table, filters: {'id': id});
  }
}

class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => 'ApiException: $message';
}
