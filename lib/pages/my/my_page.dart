import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constants/app_text_styles.dart';
import '../../constants/app_colors.dart';
import '../../providers/profile_provider.dart';
import '../../utils/responsive_utils.dart';

class MyPage extends ConsumerWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(currentProfileProvider);

    return profileAsync.when(
      data: (profile) {
        if (profile == null) {
          return const Center(child: Text('프로필 정보를 불러올 수 없습니다.'));
        }
        return Container(
          decoration: const BoxDecoration(
            gradient: AppColors.backgroundGradient,
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: const Text('마이페이지'),
              backgroundColor: Colors.transparent,
              elevation: 0,
              foregroundColor: AppColors.textPrimary,
              titleTextStyle:
                  AppTextStyles.h3.copyWith(color: AppColors.textPrimary),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // 사용자 프로필 카드
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.white,
                            child: Text(
                              profile.name[0],
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          profile.name,
                          style: AppTextStyles.h2.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          profile.email,
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildStatItem('예약', '3', Colors.white),
                              Container(
                                width: 1,
                                height: 40,
                                color: Colors.white.withOpacity(0.3),
                              ),
                              _buildStatItem('게시글', '2', Colors.white),
                              Container(
                                width: 1,
                                height: 40,
                                color: Colors.white.withOpacity(0.3),
                              ),
                              _buildStatItem('댓글', '5', Colors.white),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 메뉴 목록
                  _buildMenuSection(
                    title: '내 활동',
                    items: [
                      _buildMenuItem(
                        icon: Icons.history_rounded,
                        title: '예약 내역',
                        subtitle: '나의 예약 기록을 확인하세요',
                        onTap: () {
                          // 예약 내역으로 이동
                        },
                      ),
                      _buildMenuItem(
                        icon: Icons.article_rounded,
                        title: '내 게시글',
                        subtitle: '작성한 게시글을 관리하세요',
                        onTap: () {
                          // 내 게시글으로 이동
                        },
                      ),
                      _buildMenuItem(
                        icon: Icons.comment_rounded,
                        title: '내 댓글',
                        subtitle: '작성한 댓글을 확인하세요',
                        onTap: () {
                          // 내 댓글으로 이동
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // 설정 메뉴
                  _buildMenuSection(
                    title: '설정',
                    items: [
                      _buildMenuItem(
                        icon: Icons.notifications_rounded,
                        title: '알림 설정',
                        subtitle: '푸시 알림을 관리하세요',
                        onTap: () {
                          // 알림 설정으로 이동
                        },
                      ),
                      _buildMenuItem(
                        icon: Icons.privacy_tip_rounded,
                        title: '개인정보',
                        subtitle: '개인정보를 수정하세요',
                        onTap: () {
                          // 개인정보 수정으로 이동
                        },
                      ),
                      _buildMenuItem(
                        icon: Icons.help_rounded,
                        title: '도움말',
                        subtitle: '앱 사용법을 확인하세요',
                        onTap: () {
                          // 도움말로 이동
                        },
                      ),
                      _buildMenuItem(
                        icon: Icons.info_rounded,
                        title: '앱 정보',
                        subtitle: '버전 1.0.0',
                        onTap: () {
                          // 앱 정보로 이동
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // 로그아웃 버튼
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.error.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.error.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          _showLogoutDialog(context);
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.logout_rounded,
                                color: AppColors.error,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '로그아웃',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.error,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }

  Widget _buildStatItem(String label, String value, Color textColor) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.h3.copyWith(
            color: textColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: textColor.withOpacity(0.8),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuSection({
    required String title,
    required List<Widget> items,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              title,
              style: AppTextStyles.cardTitle,
            ),
          ),
          Column(
            children: items,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.listItemTitle,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: AppTextStyles.listItemSubtitle,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final padding = ResponsiveUtils.getResponsivePadding(context);

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(padding * 2),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(padding * 1.5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(padding * 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: padding * 3,
                offset: Offset(0, padding),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 아이콘
              Container(
                padding: EdgeInsets.all(padding),
                decoration: BoxDecoration(
                  color: AppColors.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(padding),
                ),
                child: Icon(
                  Icons.logout_rounded,
                  color: AppColors.error,
                  size: ResponsiveUtils.getResponsiveIconSize(context),
                ),
              ),
              SizedBox(height: padding),

              // 제목
              Text(
                '로그아웃',
                style: AppTextStyles.h3.copyWith(
                  fontSize:
                      ResponsiveUtils.getResponsiveFontSize(context, 24.0),
                ),
              ),
              SizedBox(height: padding * 0.5),

              // 메시지
              Text(
                '정말 로그아웃하시겠습니까?',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                  fontSize:
                      ResponsiveUtils.getResponsiveFontSize(context, 16.0),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: padding * 1.5),

              // 버튼들
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.textSecondary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(padding),
                        border: Border.all(
                          color: AppColors.textSecondary.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          borderRadius: BorderRadius.circular(padding),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: padding,
                              vertical: padding * 0.75,
                            ),
                            child: Text(
                              '취소',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w600,
                                fontSize: ResponsiveUtils.getResponsiveFontSize(
                                    context, 16.0),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: padding),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.error,
                            AppColors.error.withOpacity(0.8)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(padding),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.error.withOpacity(0.3),
                            blurRadius: padding,
                            offset: Offset(0, padding * 0.25),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            // 로그아웃 처리
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.white,
                                      size:
                                          ResponsiveUtils.getResponsiveIconSize(
                                                  context) *
                                              0.7,
                                    ),
                                    SizedBox(width: padding * 0.5),
                                    Text(
                                      '로그아웃되었습니다.',
                                      style: AppTextStyles.bodyMedium.copyWith(
                                        color: Colors.white,
                                        fontSize: ResponsiveUtils
                                            .getResponsiveFontSize(
                                                context, 16.0),
                                      ),
                                    ),
                                  ],
                                ),
                                backgroundColor: AppColors.info,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(padding),
                                ),
                                margin: EdgeInsets.all(padding),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(padding),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: padding,
                              vertical: padding * 0.75,
                            ),
                            child: Text(
                              '로그아웃',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: ResponsiveUtils.getResponsiveFontSize(
                                    context, 16.0),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
