import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/community.dart';
import '../services/repositories/repository_providers.dart';

part 'community_provider.g.dart';

@riverpod
class PostNotifier extends _$PostNotifier {
  @override
  Future<List<Post>> build() async {
    final repository = ref.read(postRepositoryProvider);
    return await repository.getAll();
  }

  Future<void> addPost(Post post) async {
    final repository = ref.read(postRepositoryProvider);
    await repository.create(post);
    ref.invalidateSelf();
  }

  Future<void> updatePost(Post updatedPost) async {
    final repository = ref.read(postRepositoryProvider);
    await repository.update(updatedPost);
    ref.invalidateSelf();
  }

  Future<void> deletePost(String postId) async {
    final repository = ref.read(postRepositoryProvider);
    await repository.delete(postId);
    ref.invalidateSelf();
  }

  Future<void> addComment(String postId, Comment comment) async {
    final commentRepository = ref.read(commentRepositoryProvider);
    await commentRepository.create(comment);

    // 댓글 수 업데이트
    final postRepository = ref.read(postRepositoryProvider);
    final comments = await commentRepository.getByPostId(postId);
    await postRepository.updateCommentCount(postId, comments.length);

    ref.invalidateSelf();
  }

  Future<void> deleteComment(String postId, String commentId) async {
    final commentRepository = ref.read(commentRepositoryProvider);
    await commentRepository.delete(commentId);

    // 댓글 수 업데이트
    final postRepository = ref.read(postRepositoryProvider);
    final comments = await commentRepository.getByPostId(postId);
    await postRepository.updateCommentCount(postId, comments.length);

    ref.invalidateSelf();
  }

  Future<void> incrementViewCount(String postId) async {
    final repository = ref.read(postRepositoryProvider);
    await repository.incrementViewCount(postId);
    ref.invalidateSelf();
  }

  Future<Post?> getPostById(String postId) async {
    final repository = ref.read(postRepositoryProvider);
    return await repository.getById(postId);
  }

  // 도메인별 특화 메서드들
  Future<List<Post>> getByAuthorId(String authorId) async {
    final repository = ref.read(postRepositoryProvider);
    return await repository.getByAuthorId(authorId);
  }

  Future<List<Post>> getByBranchId(String? branchId) async {
    final repository = ref.read(postRepositoryProvider);
    return await repository.getByBranchId(branchId);
  }
}

@riverpod
class CommentNotifier extends _$CommentNotifier {
  @override
  Future<List<Comment>> build() async {
    final repository = ref.read(commentRepositoryProvider);
    return await repository.getAll();
  }

  Future<void> addComment(Comment comment) async {
    final repository = ref.read(commentRepositoryProvider);
    await repository.create(comment);
    ref.invalidateSelf();
  }

  Future<void> deleteComment(String commentId) async {
    final repository = ref.read(commentRepositoryProvider);
    await repository.delete(commentId);
    ref.invalidateSelf();
  }

  Future<List<Comment>> getByPostId(String postId) async {
    final repository = ref.read(commentRepositoryProvider);
    return await repository.getByPostId(postId);
  }

  Future<List<Comment>> getByAuthorId(String authorId) async {
    final repository = ref.read(commentRepositoryProvider);
    return await repository.getByAuthorId(authorId);
  }
}

@riverpod
class SelectedPostNotifier extends _$SelectedPostNotifier {
  @override
  Future<Post?> build() async {
    return null;
  }

  Future<void> setPost(String postId) async {
    final repository = ref.read(postRepositoryProvider);
    final post = await repository.getById(postId);
    state = AsyncValue.data(post);
  }

  void clearSelection() {
    state = const AsyncValue.data(null);
  }
}
