import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/community.dart';
import '../utils/fake_data.dart';

part 'community_provider.g.dart';

@riverpod
class PostNotifier extends _$PostNotifier {
  @override
  List<Post> build() {
    return FakeData.posts;
  }

  void addPost(Post post) {
    state = [post, ...state];
  }

  void updatePost(Post updatedPost) {
    state = state.map((post) {
      if (post.id == updatedPost.id) {
        return updatedPost;
      }
      return post;
    }).toList();
  }

  void deletePost(String postId) {
    state = state.where((post) => post.id != postId).toList();
  }

  Post? getPostById(String postId) {
    try {
      return state.firstWhere((post) => post.id == postId);
    } catch (e) {
      return null;
    }
  }

  void addComment(String postId, Comment comment) {
    state = state.map((post) {
      if (post.id == postId) {
        return post.copyWith(
          comments: [...post.comments, comment],
          commentCount: post.commentCount + 1,
        );
      }
      return post;
    }).toList();
  }

  void deleteComment(String postId, String commentId) {
    state = state.map((post) {
      if (post.id == postId) {
        final updatedComments = post.comments.where((comment) => comment.id != commentId).toList();
        return post.copyWith(
          comments: updatedComments,
          commentCount: updatedComments.length,
        );
      }
      return post;
    }).toList();
  }

  void incrementViewCount(String postId) {
    state = state.map((post) {
      if (post.id == postId) {
        return post.copyWith(viewCount: post.viewCount + 1);
      }
      return post;
    }).toList();
  }
}

@riverpod
class CommentNotifier extends _$CommentNotifier {
  @override
  List<Comment> build() {
    return [];
  }

  void setComments(List<Comment> comments) {
    state = comments;
  }

  void addComment(Comment comment) {
    state = [...state, comment];
  }

  void deleteComment(String commentId) {
    state = state.where((comment) => comment.id != commentId).toList();
  }
}

@riverpod
class SelectedPostNotifier extends _$SelectedPostNotifier {
  @override
  Post? build() {
    return null;
  }

  void setPost(Post post) {
    state = post;
  }

  void clearSelection() {
    state = null;
  }
} 