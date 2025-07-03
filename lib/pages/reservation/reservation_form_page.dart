import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../../constants/app_text_styles.dart';
import '../../constants/app_colors.dart';
import '../../providers/reservation_provider.dart';
import '../../providers/branch_provider.dart';
import '../../providers/profile_provider.dart';
import '../../models/reservation.dart';
import '../../models/time_slot.dart';
import '../../models/branch.dart';
import '../../utils/responsive_utils.dart';

class ReservationFormPage extends ConsumerStatefulWidget {
  const ReservationFormPage({super.key});

  @override
  ConsumerState<ReservationFormPage> createState() =>
      _ReservationFormPageState();
}

class _ReservationFormPageState extends ConsumerState<ReservationFormPage> {
  @override
  Widget build(BuildContext context) {
    final selectedDate = ref.watch(selectedDateNotifierProvider);
    final selectedSpaceAsync = ref.watch(selectedSpaceNotifierProvider);
    final selectedTimeSlotAsync = ref.watch(selectedTimeSlotNotifierProvider);

    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.backgroundGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('예약 생성'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: AppColors.textPrimary,
          titleTextStyle:
              AppTextStyles.h3.copyWith(color: AppColors.textPrimary),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 헤더 섹션
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
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
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.event_available,
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
                                '기도실 예약',
                                style: AppTextStyles.h3,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '날짜, 시간, 공간을 선택하고 예약을 완료하세요',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 예약 정보 카드들
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // 날짜 선택 카드
                      _buildSelectionCard(
                        icon: Icons.calendar_today,
                        title: '날짜 선택',
                        subtitle:
                            '${selectedDate.year}년 ${selectedDate.month}월 ${selectedDate.day}일',
                        onTap: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime.now(),
                            lastDate:
                                DateTime.now().add(const Duration(days: 365)),
                          );
                          if (picked != null && picked != selectedDate) {
                            ref
                                .read(selectedDateNotifierProvider.notifier)
                                .setDate(picked);
                          }
                        },
                      ),
                      const SizedBox(height: 16),

                      // 시간 선택 카드
                      _buildSelectionCard(
                        icon: Icons.access_time,
                        title: '시간 선택',
                        subtitle: selectedTimeSlotAsync.value?.time ??
                            '원하는 시간대를 선택하세요',
                        onTap: () async {
                          final timeSlotsAsync =
                              ref.read(timeSlotNotifierProvider);
                          timeSlotsAsync.whenData((timeSlots) {
                            _showTimeSlotPicker(context, timeSlots);
                          });
                        },
                      ),
                      const SizedBox(height: 16),

                      // 공간 선택 카드
                      _buildSelectionCard(
                        icon: Icons.room,
                        title: '공간 선택',
                        subtitle:
                            selectedSpaceAsync.value?.name ?? '사용할 기도실을 선택하세요',
                        onTap: () async {
                          final branchesAsync = ref.read(branchesProvider);
                          branchesAsync.whenData((branches) {
                            _showSpacePicker(context, branches);
                          });
                        },
                      ),
                      const SizedBox(height: 16),

                      // 예약 정보 요약 카드
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.primary.withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  color: AppColors.primary,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '예약 정보',
                                  style: AppTextStyles.cardTitle.copyWith(
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            _buildInfoRow('날짜',
                                '${selectedDate.year}년 ${selectedDate.month}월 ${selectedDate.day}일'),
                            const SizedBox(height: 8),
                            _buildInfoRow('시간',
                                selectedTimeSlotAsync.value?.time ?? '선택되지 않음'),
                            const SizedBox(height: 8),
                            _buildInfoRow('공간',
                                selectedSpaceAsync.value?.name ?? '선택되지 않음'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // 예약하기 버튼
              SizedBox(
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: _submitReservation,
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.check_circle, color: Colors.white),
                            const SizedBox(width: 8),
                            Text(
                              '예약하기',
                              style: AppTextStyles.buttonLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
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
                        style: AppTextStyles.cardTitle,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.textSecondary,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  void _showTimeSlotPicker(BuildContext context, List<TimeSlot> timeSlots) {
    final padding = ResponsiveUtils.getResponsivePadding(context);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(padding * 2),
              topRight: Radius.circular(padding * 2),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: padding * 2,
                offset: Offset(0, -padding),
              ),
            ],
          ),
          child: Column(
            children: [
              // 핸들 바
              Container(
                margin: EdgeInsets.only(top: padding * 0.5),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.textSecondary.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // 헤더
              Padding(
                padding: EdgeInsets.all(padding),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(padding * 0.6),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(padding * 0.6),
                      ),
                      child: Icon(
                        Icons.access_time,
                        color: AppColors.primary,
                        size: ResponsiveUtils.getResponsiveIconSize(context),
                      ),
                    ),
                    SizedBox(width: padding),
                    Text(
                      '시간 선택',
                      style: AppTextStyles.h4.copyWith(
                        fontSize: ResponsiveUtils.getResponsiveFontSize(
                            context, 20.0),
                      ),
                    ),
                  ],
                ),
              ),

              Divider(height: 1, color: AppColors.cardShadow),

              // 시간 목록
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: padding),
                  itemCount: timeSlots.length,
                  itemBuilder: (context, index) {
                    final slot = timeSlots[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: padding * 0.5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(padding),
                        border: Border.all(
                          color: AppColors.cardShadow,
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.cardShadow.withOpacity(0.1),
                            blurRadius: padding,
                            offset: Offset(0, padding * 0.25),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            ref
                                .read(selectedTimeSlotNotifierProvider.notifier)
                                .setTimeSlot(slot);
                            Navigator.pop(context);
                          },
                          borderRadius: BorderRadius.circular(padding),
                          child: Padding(
                            padding: EdgeInsets.all(padding),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(padding * 0.5),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withOpacity(0.1),
                                    borderRadius:
                                        BorderRadius.circular(padding * 0.5),
                                  ),
                                  child: Icon(
                                    Icons.schedule,
                                    color: AppColors.primary,
                                    size: ResponsiveUtils.getResponsiveIconSize(
                                            context) *
                                        0.7,
                                  ),
                                ),
                                SizedBox(width: padding),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        slot.time,
                                        style: AppTextStyles.listItemTitle
                                            .copyWith(
                                          fontSize: ResponsiveUtils
                                              .getResponsiveFontSize(
                                                  context, 16.0),
                                        ),
                                      ),
                                      SizedBox(height: padding * 0.25),
                                      Text(
                                        '예약 가능',
                                        style: AppTextStyles.caption.copyWith(
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: AppColors.textSecondary,
                                  size: ResponsiveUtils.getResponsiveIconSize(
                                          context) *
                                      0.5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSpacePicker(BuildContext context, List<Branch> branches) {
    final padding = ResponsiveUtils.getResponsivePadding(context);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(padding * 2),
              topRight: Radius.circular(padding * 2),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: padding * 2,
                offset: Offset(0, -padding),
              ),
            ],
          ),
          child: Column(
            children: [
              // 핸들 바
              Container(
                margin: EdgeInsets.only(top: padding * 0.5),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.textSecondary.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // 헤더
              Padding(
                padding: EdgeInsets.all(padding),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(padding * 0.6),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(padding * 0.6),
                      ),
                      child: Icon(
                        Icons.room,
                        color: AppColors.primary,
                        size: ResponsiveUtils.getResponsiveIconSize(context),
                      ),
                    ),
                    SizedBox(width: padding),
                    Text(
                      '공간 선택',
                      style: AppTextStyles.h4.copyWith(
                        fontSize: ResponsiveUtils.getResponsiveFontSize(
                            context, 20.0),
                      ),
                    ),
                  ],
                ),
              ),

              Divider(height: 1, color: AppColors.cardShadow),

              // 공간 목록
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: padding),
                  itemCount: branches.length,
                  itemBuilder: (context, branchIndex) {
                    final branch = branches[branchIndex];
                    final spacesAsync =
                        ref.watch(branchSpacesProvider(branch.id));
                    return spacesAsync.when(
                      data: (spaces) {
                        return Container(
                          margin: EdgeInsets.only(bottom: padding),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(padding),
                            border: Border.all(
                              color: AppColors.cardShadow,
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.cardShadow.withOpacity(0.1),
                                blurRadius: padding,
                                offset: Offset(0, padding * 0.25),
                              ),
                            ],
                          ),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              dividerColor: Colors.transparent,
                            ),
                            child: ExpansionTile(
                              leading: Container(
                                padding: EdgeInsets.all(padding * 0.5),
                                decoration: BoxDecoration(
                                  color: AppColors.secondary.withOpacity(0.1),
                                  borderRadius:
                                      BorderRadius.circular(padding * 0.5),
                                ),
                                child: Icon(
                                  Icons.store,
                                  color: AppColors.secondary,
                                  size: ResponsiveUtils.getResponsiveIconSize(
                                          context) *
                                      0.7,
                                ),
                              ),
                              title: Text(
                                branch.name,
                                style: AppTextStyles.listItemTitle.copyWith(
                                  fontSize:
                                      ResponsiveUtils.getResponsiveFontSize(
                                          context, 16.0),
                                ),
                              ),
                              subtitle: Text(
                                '${spaces.length}개의 공간',
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              children: spaces.map((space) {
                                return Container(
                                  margin: EdgeInsets.only(
                                    left: padding * 2,
                                    right: padding,
                                    bottom: padding * 0.5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withOpacity(0.05),
                                    borderRadius:
                                        BorderRadius.circular(padding * 0.75),
                                    border: Border.all(
                                      color: AppColors.primary.withOpacity(0.1),
                                      width: 1,
                                    ),
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        ref
                                            .read(selectedSpaceNotifierProvider
                                                .notifier)
                                            .setSpace(space);
                                        Navigator.pop(context);
                                      },
                                      borderRadius:
                                          BorderRadius.circular(padding * 0.75),
                                      child: Padding(
                                        padding: EdgeInsets.all(padding),
                                        child: Row(
                                          children: [
                                            Container(
                                              padding:
                                                  EdgeInsets.all(padding * 0.4),
                                              decoration: BoxDecoration(
                                                color: AppColors.primary
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        padding * 0.4),
                                              ),
                                              child: Icon(
                                                Icons.meeting_room,
                                                color: AppColors.primary,
                                                size: ResponsiveUtils
                                                        .getResponsiveIconSize(
                                                            context) *
                                                    0.6,
                                              ),
                                            ),
                                            SizedBox(width: padding),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    space.name,
                                                    style: AppTextStyles
                                                        .listItemTitle
                                                        .copyWith(
                                                      fontSize: ResponsiveUtils
                                                          .getResponsiveFontSize(
                                                              context, 14.0),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height: padding * 0.25),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        '${space.pricePerHour}원/시간',
                                                        style: AppTextStyles
                                                            .caption
                                                            .copyWith(
                                                          color: AppColors
                                                              .textSecondary,
                                                        ),
                                                      ),
                                                      SizedBox(width: padding),
                                                      Icon(
                                                        Icons.people,
                                                        size: ResponsiveUtils
                                                                .getResponsiveIconSize(
                                                                    context) *
                                                            0.5,
                                                        color: AppColors
                                                            .textSecondary,
                                                      ),
                                                      SizedBox(
                                                          width:
                                                              padding * 0.25),
                                                      Text(
                                                        '최대 ${space.capacity}명',
                                                        style: AppTextStyles
                                                            .caption
                                                            .copyWith(
                                                          color: AppColors
                                                              .textSecondary,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              color: AppColors.textSecondary,
                                              size: ResponsiveUtils
                                                      .getResponsiveIconSize(
                                                          context) *
                                                  0.5,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      },
                      loading: () => Container(
                        margin: EdgeInsets.only(bottom: padding),
                        padding: EdgeInsets.all(padding),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(padding),
                          border: Border.all(
                            color: AppColors.cardShadow,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: ResponsiveUtils.getResponsiveIconSize(
                                  context),
                              height: ResponsiveUtils.getResponsiveIconSize(
                                  context),
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.primary),
                              ),
                            ),
                            SizedBox(width: padding),
                            Text(
                              '${branch.name} 공간 정보 로딩 중...',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      error: (error, stack) => Container(
                        margin: EdgeInsets.only(bottom: padding),
                        padding: EdgeInsets.all(padding),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(padding),
                          border: Border.all(
                            color: Colors.red.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: ResponsiveUtils.getResponsiveIconSize(
                                  context),
                            ),
                            SizedBox(width: padding),
                            Expanded(
                              child: Text(
                                '${branch.name} 공간 정보를 불러올 수 없습니다',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _submitReservation() async {
    final profile = await ref.read(currentProfileProvider.future);
    final selectedDate = ref.read(selectedDateNotifierProvider);
    final selectedSpace = ref.read(selectedSpaceNotifierProvider).value;
    final selectedTimeSlot = ref.read(selectedTimeSlotNotifierProvider).value;

    if (profile == null || selectedSpace == null || selectedTimeSlot == null) {
      Get.snackbar(
        '예약 실패',
        '모든 예약 정보를 선택해주세요.',
        backgroundColor: AppColors.error,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        borderRadius: 12,
        margin: const EdgeInsets.all(16),
        icon: const Icon(
          Icons.error,
          color: Colors.white,
        ),
        duration: const Duration(seconds: 3),
      );
      return;
    }

    final newReservation = Reservation(
      id: '${DateTime.now().millisecondsSinceEpoch}', // Supabase에서 자동 생성될 것임
      userId: profile.id,
      branchId: selectedSpace.branchId,
      spaceId: selectedSpace.id,
      date: selectedDate,
      timeSlot: selectedTimeSlot.time,
      duration: 120, // 예시: 2시간 고정
      price: selectedSpace.pricePerHour * 2,
      discountedPrice:
          (selectedSpace.pricePerHour * 2 * 0.95).toInt(), // 예시: 5% 할인
      status: ReservationStatus.reserved,
      notes: null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await ref
        .read(reservationNotifierProvider.notifier)
        .addReservation(newReservation);

    Get.snackbar(
      '예약 완료',
      '예약이 성공적으로 완료되었습니다!',
      backgroundColor: AppColors.success,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      borderRadius: 12,
      margin: const EdgeInsets.all(16),
      icon: const Icon(
        Icons.check_circle,
        color: Colors.white,
      ),
      duration: const Duration(seconds: 3),
    );
    Get.back();
  }
}
