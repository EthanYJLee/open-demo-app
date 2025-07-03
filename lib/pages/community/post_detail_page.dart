import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constants/app_text_styles.dart';
import '../../constants/app_colors.dart';
import '../../providers/community_provider.dart';
import '../../models/community.dart';
import '../../utils/fake_data.dart';

class PostDetailPage extends ConsumerStatefulWidget {
  const PostDetailPage({super.key});

  @override
  ConsumerState<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends ConsumerState<PostDetailPage> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedPost = ref.watch(selectedPostNotifierProvider);

    if (selectedPost == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('게시글 상세'),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
        ),
        body: const Center(
          child: Text('게시글을 찾을 수 없습니다.'),
        ),
      );
    }

    // 조회수 증가
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(postNotifierProvider.notifier)
          .incrementViewCount(selectedPost.id);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('게시글 상세'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 게시글 제목
                  Text(
                    selectedPost.title,
                    style: AppTextStyles.h2,
                  ),
                  const SizedBox(height: 16),

                  // 작성자 정보
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: AppColors.primary,
                        child: Text(
                          selectedPost.authorName[0],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        selectedPost.authorName,
                        style: AppTextStyles.bodyMedium,
                      ),
                      const Spacer(),
                      Text(
                        _formatDate(selectedPost.createdAt),
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // 조회수, 댓글수
                  Row(
                    children: [
                      Icon(
                        Icons.visibility,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${selectedPost.viewCount}',
                        style: AppTextStyles.caption,
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.comment,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${selectedPost.commentCount}',
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // 게시글 내용
                  Text(
                    selectedPost.content,
                    style: AppTextStyles.bodyLarge,
                  ),
                  const SizedBox(height: 24),

                  // 댓글 섹션
                  Text(
                    '댓글 (${selectedPost.comments.length})',
                    style: AppTextStyles.h4,
                  ),
                  const SizedBox(height: 16),

                  // 댓글 목록
                  if (selectedPost.comments.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          children: [
                            Icon(
                              Icons.comment_outlined,
                              size: 48,
                              color: AppColors.textSecondary,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '첫 번째 댓글을 남겨보세요!',
                              style: AppTextStyles.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    ...selectedPost.comments
                        .map((comment) => _buildComment(comment)),
                ],
              ),
            ),
          ),

          // 댓글 입력창
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: const InputDecoration(
                      hintText: '댓글을 입력하세요',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    maxLines: null,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addComment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('등록'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComment(Comment comment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: AppColors.secondary,
                child: Text(
                  comment.authorName[0],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                comment.authorName,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                _formatDate(comment.createdAt),
                style: AppTextStyles.caption,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            comment.content,
            style: AppTextStyles.bodyMedium,
          ),
        ],
      ),
    );
  }

  void _addComment() {
    if (_commentController.text.trim().isEmpty) return;

    final selectedPost = ref.read(selectedPostNotifierProvider);
    if (selectedPost == null) return;

    final newComment = Comment(
      id: FakeData.generateId(),
      content: _commentController.text.trim(),
      authorId: FakeData.currentUser.id,
      authorName: FakeData.currentUser.name,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      postId: selectedPost.id,
    );

    ref
        .read(postNotifierProvider.notifier)
        .addComment(selectedPost.id, newComment);
    _commentController.clear();
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays}일 전';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}시간 전';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}분 전';
    } else {
      return '방금 전';
    }
  }
}
