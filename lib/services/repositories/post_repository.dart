import '../api/supabase_service.dart';
import '../../models/community.dart';
import 'base_repository.dart';

class PostRepository implements BaseRepository<Post> {
  final SupabaseService _supabaseService = SupabaseService();
  static const String _tableName = 'posts';

  @override
  Future<List<Post>> getAll() async {
    try {
      final data = await _supabaseService.select(_tableName);
      return data.map((json) => Post.fromJson(json)).toList();
    } catch (e) {
      throw ApiException('Failed to fetch posts: $e');
    }
  }

  @override
  Future<Post?> getById(String id) async {
    try {
      final data = await _supabaseService.getById(_tableName, id);
      return data != null ? Post.fromJson(data) : null;
    } catch (e) {
      throw ApiException('Failed to fetch post by id: $e');
    }
  }

  @override
  Future<void> create(Post post) async {
    try {
      await _supabaseService.insert(_tableName, post.toJson());
    } catch (e) {
      throw ApiException('Failed to create post: $e');
    }
  }

  @override
  Future<void> update(Post post) async {
    try {
      await _supabaseService.updateById(_tableName, post.id, post.toJson());
    } catch (e) {
      throw ApiException('Failed to update post: $e');
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await _supabaseService.deleteById(_tableName, id);
    } catch (e) {
      throw ApiException('Failed to delete post: $e');
    }
  }

  // 도메인별 특화 메서드들
  Future<List<Post>> getByAuthorId(String authorId) async {
    try {
      final data = await _supabaseService
          .select(_tableName, filters: {'author_id': authorId});
      return data.map((json) => Post.fromJson(json)).toList();
    } catch (e) {
      throw ApiException('Failed to fetch posts by author id: $e');
    }
  }

  Future<List<Post>> getByBranchId(String? branchId) async {
    try {
      final data = await _supabaseService
          .select(_tableName, filters: {'branch_id': branchId});
      return data.map((json) => Post.fromJson(json)).toList();
    } catch (e) {
      throw ApiException('Failed to fetch posts by branch id: $e');
    }
  }

  Future<void> incrementViewCount(String postId) async {
    try {
      final currentPost = await getById(postId);
      if (currentPost != null) {
        await _supabaseService.updateById(
            _tableName, postId, {'view_count': currentPost.viewCount + 1});
      }
    } catch (e) {
      throw ApiException('Failed to increment view count: $e');
    }
  }

  Future<void> updateCommentCount(String postId, int commentCount) async {
    try {
      await _supabaseService
          .updateById(_tableName, postId, {'comment_count': commentCount});
    } catch (e) {
      throw ApiException('Failed to update comment count: $e');
    }
  }
}

class CommentRepository {
  final SupabaseService _supabaseService = SupabaseService();
  static const String _tableName = 'comments';

  Future<List<Comment>> getAll() async {
    try {
      final data = await _supabaseService.select(_tableName);
      return data.map((json) => Comment.fromJson(json)).toList();
    } catch (e) {
      throw ApiException('Failed to fetch comments: $e');
    }
  }

  Future<Comment?> getById(String id) async {
    try {
      final data = await _supabaseService.getById(_tableName, id);
      return data != null ? Comment.fromJson(data) : null;
    } catch (e) {
      throw ApiException('Failed to fetch comment by id: $e');
    }
  }

  Future<void> create(Comment comment) async {
    try {
      await _supabaseService.insert(_tableName, comment.toJson());
    } catch (e) {
      throw ApiException('Failed to create comment: $e');
    }
  }

  Future<void> update(Comment comment) async {
    try {
      await _supabaseService.updateById(
          _tableName, comment.id, comment.toJson());
    } catch (e) {
      throw ApiException('Failed to update comment: $e');
    }
  }

  Future<void> delete(String id) async {
    try {
      await _supabaseService.deleteById(_tableName, id);
    } catch (e) {
      throw ApiException('Failed to delete comment: $e');
    }
  }

  Future<List<Comment>> getByPostId(String postId) async {
    try {
      final data = await _supabaseService
          .select(_tableName, filters: {'post_id': postId});
      return data.map((json) => Comment.fromJson(json)).toList();
    } catch (e) {
      throw ApiException('Failed to fetch comments by post id: $e');
    }
  }

  Future<List<Comment>> getByAuthorId(String authorId) async {
    try {
      final data = await _supabaseService
          .select(_tableName, filters: {'author_id': authorId});
      return data.map((json) => Comment.fromJson(json)).toList();
    } catch (e) {
      throw ApiException('Failed to fetch comments by author id: $e');
    }
  }
}
