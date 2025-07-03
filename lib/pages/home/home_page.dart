import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../../constants/app_text_styles.dart';
import '../../constants/app_colors.dart';
import '../../providers/reservation_provider.dart';
import '../../providers/community_provider.dart';
import '../../providers/profile_provider.dart';
import '../../providers/branch_provider.dart';
import '../../models/space.dart';
import '../../controllers/navigation_controller.dart';
import '../../widgets/branch_selector.dart';
import '../../utils/responsive_utils.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(currentProfileProvider);
    final postsAsync = ref.watch(postNotifierProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        return profileAsync.when(
          data: (profile) {
            if (profile == null) {
              return const Center(child: Text('프로필 정보를 불러올 수 없습니다.'));
            }

            final todayReservationsAsync =
                ref.watch(userTodayReservationsNotifierProvider(profile.id));

            return postsAsync.when(
              data: (posts) {
                return todayReservationsAsync.when(
                  data: (todayReservations) {
                    // 최근 게시글 (최대 3개)
                    final recentPosts = posts.take(3).toList();

                    return Container(
                      decoration: const BoxDecoration(
                        gradient: AppColors.backgroundGradient,
                      ),
                      child: Scaffold(
                        backgroundColor: Colors.transparent,
                        appBar: AppBar(
                          title: const Text('open pray'),
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          foregroundColor: AppColors.textPrimary,
                          titleTextStyle: AppTextStyles.h3
                              .copyWith(color: AppColors.textPrimary),
                        ),
                        body: SingleChildScrollView(
                          padding: ResponsiveUtils.getResponsiveMargin(context),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 지점 선택기
                              const BranchSelector(),
                              SizedBox(
                                  height: ResponsiveUtils.getResponsivePadding(
                                      context)),

                              // 환영 메시지 카드
                              _buildWelcomeCard(context, profile),
                              SizedBox(
                                  height: ResponsiveUtils.getResponsivePadding(
                                          context) *
                                      2),

                              // 오늘 예약 현황
                              _buildSectionHeader(
                                  context, '오늘 예약 현황', Icons.event_available),
                              SizedBox(
                                  height: ResponsiveUtils.getResponsivePadding(
                                      context)),
                              if (todayReservations.isEmpty)
                                _buildEmptyCard(
                                  context,
                                  icon: Icons.event_available,
                                  title: '오늘 예약이 없습니다',
                                  subtitle: '새로운 예약을 만들어보세요',
                                  buttonText: '예약하기',
                                  onPressed: () =>
                                      Get.toNamed('/reservation/form'),
                                  buttonColor: AppColors.primary,
                                )
                              else
                                _buildResponsiveReservationList(
                                    context, todayReservations),
                              SizedBox(
                                  height: ResponsiveUtils.getResponsivePadding(
                                          context) *
                                      2),

                              // 최근 게시글
                              _buildResponsivePostSection(context, recentPosts),
                              SizedBox(
                                  height: ResponsiveUtils.getResponsivePadding(
                                          context) *
                                      2),

                              // 빠른 액션 버튼들
                              _buildSectionHeader(
                                  context, '빠른 액션', Icons.flash_on),
                              SizedBox(
                                  height: ResponsiveUtils.getResponsivePadding(
                                      context)),
                              _buildResponsiveActionButtons(context),
                              SizedBox(
                                  height: ResponsiveUtils.getResponsivePadding(
                                      context)),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Center(child: Text('Error: $error')),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error: $error')),
        );
      },
    );
  }

  Widget _buildWelcomeCard(BuildContext context, dynamic profile) {
    final padding = ResponsiveUtils.getResponsivePadding(context);
    final fontSize = ResponsiveUtils.getResponsiveFontSize(context, 24.0);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(padding * 1.5),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(padding),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: padding * 2,
            offset: Offset(0, padding),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(padding * 0.6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(padding * 0.6),
                ),
                child: Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: ResponsiveUtils.getResponsiveIconSize(context),
                ),
              ),
              SizedBox(width: padding),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '안녕하세요, ${profile.name}님!',
                      style: AppTextStyles.h4.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: fontSize,
                      ),
                    ),
                    SizedBox(height: padding * 0.25),
                    Text(
                      '오늘도 평화로운 기도 시간 되세요.',
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: ResponsiveUtils.getResponsiveFontSize(
                            context, 16.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResponsiveReservationList(
      BuildContext context, List<dynamic> reservations) {
    if (ResponsiveUtils.isMobile(context)) {
      return Column(
        children: reservations
            .map((reservation) => _buildReservationCard(context, reservation))
            .toList(),
      );
    } else {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
              ResponsiveUtils.getResponsiveGridCrossAxisCount(context),
          crossAxisSpacing: ResponsiveUtils.getResponsivePadding(context),
          mainAxisSpacing: ResponsiveUtils.getResponsivePadding(context),
          childAspectRatio: 2.5,
        ),
        itemCount: reservations.length,
        itemBuilder: (context, index) =>
            _buildReservationCard(context, reservations[index]),
      );
    }
  }

  Widget _buildResponsivePostSection(
      BuildContext context, List<dynamic> posts) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSectionHeader(context, '최근 게시글', Icons.forum),
            TextButton.icon(
              onPressed: () {
                Get.find<NavigationController>().goToCommunity();
              },
              icon: Icon(Icons.arrow_forward,
                  size: ResponsiveUtils.getResponsiveIconSize(context) * 0.6),
              label: Text('더보기'),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
              ),
            ),
          ],
        ),
        SizedBox(height: ResponsiveUtils.getResponsivePadding(context)),
        if (posts.isEmpty)
          _buildEmptyCard(
            context,
            icon: Icons.forum_outlined,
            title: '아직 게시글이 없습니다',
            subtitle: '첫 번째 게시글을 작성해보세요',
            buttonText: '첫 게시글 작성',
            onPressed: () => Get.toNamed('/community/write'),
            buttonColor: AppColors.secondary,
          )
        else
          _buildResponsivePostList(context, posts),
      ],
    );
  }

  Widget _buildResponsivePostList(BuildContext context, List<dynamic> posts) {
    if (ResponsiveUtils.isMobile(context)) {
      return Column(
        children: posts.map((post) => _buildPostCard(context, post)).toList(),
      );
    } else {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
              ResponsiveUtils.getResponsiveGridCrossAxisCount(context),
          crossAxisSpacing: ResponsiveUtils.getResponsivePadding(context),
          mainAxisSpacing: ResponsiveUtils.getResponsivePadding(context),
          childAspectRatio: 1.2,
        ),
        itemCount: posts.length,
        itemBuilder: (context, index) => _buildPostCard(context, posts[index]),
      );
    }
  }

  Widget _buildResponsiveActionButtons(BuildContext context) {
    final buttons = [
      _buildActionButton(
        context,
        icon: Icons.event_available,
        label: '예약하기',
        color: AppColors.primary,
        onPressed: () => Get.toNamed('/reservation/form'),
      ),
      SizedBox(width: ResponsiveUtils.getResponsivePadding(context)),
      _buildActionButton(
        context,
        icon: Icons.edit,
        label: '글쓰기',
        color: AppColors.secondary,
        onPressed: () => Get.toNamed('/community/write'),
      ),
      SizedBox(width: ResponsiveUtils.getResponsivePadding(context)),
      _buildActionButton(
        context,
        icon: Icons.celebration,
        label: '이벤트',
        color: AppColors.tertiary,
        onPressed: () => Get.toNamed('/community/write'),
      ),
    ];

    if (ResponsiveUtils.isMobile(context)) {
      return Row(
        children: buttons
            .map((button) => Padding(
                  padding: EdgeInsets.only(
                      bottom: ResponsiveUtils.getResponsivePadding(context)),
                  child: button,
                ))
            .toList(),
      );
    } else {
      return Row(
        children: [
          Expanded(child: buttons[0]),
          SizedBox(width: ResponsiveUtils.getResponsivePadding(context)),
          Expanded(child: buttons[1]),
        ],
      );
    }
  }

  Widget _buildSectionHeader(
      BuildContext context, String title, IconData icon) {
    final padding = ResponsiveUtils.getResponsivePadding(context);
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(padding * 0.6),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(padding * 0.6),
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
            size: ResponsiveUtils.getResponsiveIconSize(context),
          ),
        ),
        SizedBox(width: padding),
        Text(
          title,
          style: AppTextStyles.h3,
        ),
      ],
    );
  }

  Widget _buildEmptyCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required String buttonText,
    required VoidCallback onPressed,
    required Color buttonColor,
  }) {
    final padding = ResponsiveUtils.getResponsivePadding(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(padding * 1.5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(padding),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: padding * 2,
            offset: Offset(0, padding),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(padding * 0.6),
            decoration: BoxDecoration(
              color: buttonColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(padding * 0.6),
            ),
            child: Icon(
              icon,
              size: ResponsiveUtils.getResponsiveIconSize(context),
              color: buttonColor,
            ),
          ),
          SizedBox(height: padding * 0.25),
          Text(
            title,
            style: AppTextStyles.cardTitle,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: padding * 0.25),
          Text(
            subtitle,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: padding * 0.25),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: padding * 0.75),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(padding * 0.75),
                ),
                elevation: 0,
              ),
              child: Text(
                buttonText,
                style: AppTextStyles.buttonMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReservationCard(BuildContext context, dynamic reservation) {
    return Consumer(
      builder: (context, ref, child) {
        final spacesAsync = ref.watch(spacesProvider);

        return spacesAsync.when(
          data: (spaces) {
            final space = spaces.firstWhere(
              (s) => s.id == reservation.spaceId,
              orElse: () => Space(
                id: '',
                branchId: '',
                name: '알 수 없는 공간',
                description: '',
                capacity: 0,
                pricePerHour: 0,
                amenities: [],
                images: [],
                isAvailable: false,
                category: '',
                operatingHours: {},
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              ),
            );

            return Container(
              margin: EdgeInsets.only(
                  bottom: ResponsiveUtils.getResponsivePadding(context)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                    ResponsiveUtils.getResponsivePadding(context)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.cardShadow,
                    blurRadius:
                        ResponsiveUtils.getResponsivePadding(context) * 2,
                    offset: Offset(
                        0, ResponsiveUtils.getResponsivePadding(context)),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(
                    ResponsiveUtils.getResponsivePadding(context)),
                leading: Container(
                  padding: EdgeInsets.all(
                      ResponsiveUtils.getResponsivePadding(context) * 0.6),
                  decoration: BoxDecoration(
                    color: _getStatusColor(reservation.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(
                        ResponsiveUtils.getResponsivePadding(context) * 0.6),
                  ),
                  child: Icon(
                    _getStatusIcon(reservation.status),
                    color: _getStatusColor(reservation.status),
                    size: ResponsiveUtils.getResponsiveIconSize(context),
                  ),
                ),
                title: Text(
                  space.name,
                  style: AppTextStyles.listItemTitle,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: ResponsiveUtils.getResponsivePadding(context) *
                            0.25),
                    Text(
                      '${reservation.timeSlot}',
                      style: AppTextStyles.listItemSubtitle,
                    ),
                    SizedBox(
                        height: ResponsiveUtils.getResponsivePadding(context) *
                            0.25),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              ResponsiveUtils.getResponsivePadding(context) *
                                  0.75,
                          vertical:
                              ResponsiveUtils.getResponsivePadding(context) *
                                  0.375),
                      decoration: BoxDecoration(
                        color: _getStatusColor(reservation.status)
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(
                            ResponsiveUtils.getResponsivePadding(context) *
                                0.75),
                      ),
                      child: Text(
                        reservation.status.displayName,
                        style: AppTextStyles.caption.copyWith(
                          color: _getStatusColor(reservation.status),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          loading: () => Container(
            margin: EdgeInsets.only(
                bottom: ResponsiveUtils.getResponsivePadding(context)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                  ResponsiveUtils.getResponsivePadding(context)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.cardShadow,
                  blurRadius: ResponsiveUtils.getResponsivePadding(context) * 2,
                  offset:
                      Offset(0, ResponsiveUtils.getResponsivePadding(context)),
                ),
              ],
            ),
            child: const ListTile(
              contentPadding: EdgeInsets.all(20),
              leading: CircularProgressIndicator(),
              title: Text('로딩 중...'),
            ),
          ),
          error: (error, stack) => Container(
            margin: EdgeInsets.only(
                bottom: ResponsiveUtils.getResponsivePadding(context)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                  ResponsiveUtils.getResponsivePadding(context)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.cardShadow,
                  blurRadius: ResponsiveUtils.getResponsivePadding(context) * 2,
                  offset:
                      Offset(0, ResponsiveUtils.getResponsivePadding(context)),
                ),
              ],
            ),
            child: const ListTile(
              contentPadding: EdgeInsets.all(20),
              leading: Icon(Icons.error, color: Colors.red),
              title: Text('오류 발생'),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPostCard(BuildContext context, dynamic post) {
    return Container(
      margin: EdgeInsets.only(
          bottom: ResponsiveUtils.getResponsivePadding(context)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
            ResponsiveUtils.getResponsivePadding(context)),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: ResponsiveUtils.getResponsivePadding(context) * 2,
            offset: Offset(0, ResponsiveUtils.getResponsivePadding(context)),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Get.toNamed('/community/detail', arguments: {'postId': post.id});
        },
        borderRadius: BorderRadius.circular(
            ResponsiveUtils.getResponsivePadding(context)),
        child: Padding(
          padding:
              EdgeInsets.all(ResponsiveUtils.getResponsivePadding(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: ResponsiveUtils.getResponsivePadding(context) * 0.6,
                    backgroundColor: AppColors.primary,
                    child: Text(
                      post.authorName.isNotEmpty ? post.authorName[0] : '?',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                      width:
                          ResponsiveUtils.getResponsivePadding(context) * 0.5),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.title,
                          style: AppTextStyles.listItemTitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '${post.authorName} • ${_formatDate(post.createdAt)}',
                          style: AppTextStyles.caption,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      width:
                          ResponsiveUtils.getResponsivePadding(context) * 0.5),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: ResponsiveUtils.getResponsiveIconSize(context) * 0.6,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
              SizedBox(
                  height: ResponsiveUtils.getResponsivePadding(context) * 0.25),
              Text(
                post.content,
                style: AppTextStyles.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                  height: ResponsiveUtils.getResponsivePadding(context) * 0.25),
              Row(
                children: [
                  Icon(
                    Icons.visibility,
                    size: ResponsiveUtils.getResponsiveIconSize(context) * 0.6,
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(
                      width:
                          ResponsiveUtils.getResponsivePadding(context) * 0.25),
                  Text(
                    '${post.viewCount}',
                    style: AppTextStyles.caption,
                  ),
                  SizedBox(
                      width:
                          ResponsiveUtils.getResponsivePadding(context) * 0.25),
                  Icon(
                    Icons.comment,
                    size: ResponsiveUtils.getResponsiveIconSize(context) * 0.6,
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(
                      width:
                          ResponsiveUtils.getResponsivePadding(context) * 0.25),
                  Text(
                    '${post.commentCount}',
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    final padding = ResponsiveUtils.getResponsivePadding(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(padding * 0.75),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: padding * 2,
            offset: Offset(0, padding),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(padding * 0.75),
          child: Padding(
            padding: EdgeInsets.all(padding * 0.75),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(padding * 0.6),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(padding * 0.6),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: ResponsiveUtils.getResponsiveIconSize(context),
                  ),
                ),
                SizedBox(height: padding * 0.25),
                Text(
                  label,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize:
                        ResponsiveUtils.getResponsiveFontSize(context, 14.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(dynamic status) {
    switch (status.toString()) {
      case 'ReservationStatus.reserved':
        return AppColors.reserved;
      case 'ReservationStatus.completed':
        return AppColors.completed;
      case 'ReservationStatus.cancelled':
        return AppColors.cancelled;
      default:
        return AppColors.primary;
    }
  }

  IconData _getStatusIcon(dynamic status) {
    switch (status.toString()) {
      case 'ReservationStatus.reserved':
        return Icons.schedule;
      case 'ReservationStatus.completed':
        return Icons.check_circle;
      case 'ReservationStatus.cancelled':
        return Icons.cancel;
      default:
        return Icons.event;
    }
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
