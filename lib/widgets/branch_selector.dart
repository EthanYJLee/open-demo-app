import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/branch.dart';
import '../providers/branch_provider.dart';
import '../providers/address_provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../utils/responsive_utils.dart';

class BranchSelector extends ConsumerWidget {
  const BranchSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedBranch = ref.watch(selectedBranchProvider);
    final selectedCity = ref.watch(selectedCityProvider);
    final selectedDistrict = ref.watch(selectedDistrictProvider);
    final padding = ResponsiveUtils.getResponsivePadding(context);

    // 시/구별 지점 목록 (DB에서 필터링)
    // 시/구가 모두 선택되었을 때만 필터링된 결과 사용
    AsyncValue<List<Branch>> filteredBranchesAsync;

    if (selectedCity != null && selectedDistrict != null) {
      filteredBranchesAsync = ref.watch(branchesByCityDistrictProvider((
        city: selectedCity,
        district: selectedDistrict,
      )));
    } else {
      filteredBranchesAsync = const AsyncValue<List<Branch>>.data([]);
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: padding * 1.5,
        vertical: padding * 0.8,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(padding * 1.5),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: padding * 2,
            offset: Offset(0, padding * 0.5),
          ),
        ],
      ),
      child: Row(
        children: [
          // 시/도 선택
          Expanded(
            child: _buildDropdown(
              context,
              ref,
              '시/도',
              selectedCity,
              (value) {
                ref.read(selectedCityProvider.notifier).state = value;
                ref.read(selectedDistrictProvider.notifier).state = null;
                ref.read(selectedBranchProvider.notifier).state = null;
              },
              ref.watch(citiesProvider),
              padding,
            ),
          ),
          SizedBox(width: padding * 0.5),

          // 구/군 선택
          Expanded(
            child: _buildDropdown(
              context,
              ref,
              '구/군',
              selectedDistrict,
              (value) {
                ref.read(selectedDistrictProvider.notifier).state = value;
                ref.read(selectedBranchProvider.notifier).state = null;
              },
              ref.watch(districtsProvider(selectedCity)),
              padding,
            ),
          ),
          SizedBox(width: padding * 0.5),

          // 지점 선택 (DB에서 필터링된 결과 사용)
          Expanded(
            child: _buildDropdown(
              context,
              ref,
              '지점',
              selectedBranch,
              (value) {
                ref.read(selectedBranchProvider.notifier).state = value;
              },
              filteredBranchesAsync,
              padding,
              isBranch: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown<T>(
    BuildContext context,
    WidgetRef ref,
    String label,
    T? selectedValue,
    Function(T?) onChanged,
    AsyncValue<List<T>> itemsAsync,
    double padding, {
    bool isBranch = false,
  }) {
    return itemsAsync.when(
      data: (items) {
        if (items.isEmpty) {
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: padding * 0.5,
              vertical: padding * 0.6,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(padding * 0.75),
            ),
            child: Text(
              isBranch ? '지점 없음' : '선택하세요',
              style: AppTextStyles.bodyMedium.copyWith(
                color: Colors.white.withOpacity(0.7),
                fontSize: ResponsiveUtils.getResponsiveFontSize(context, 16.0),
              ),
              textAlign: TextAlign.center,
            ),
          );
        }

        return DropdownButtonHideUnderline(
          child: DropdownButton<T>(
            value: selectedValue,
            dropdownColor: AppColors.primaryDark,
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
              size: ResponsiveUtils.getResponsiveIconSize(context) * 0.6,
            ),
            style: AppTextStyles.bodyMedium.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: ResponsiveUtils.getResponsiveFontSize(context, 12.0),
            ),
            borderRadius: BorderRadius.circular(padding),
            elevation: 8,
            menuMaxHeight: 200,
            isExpanded: true,
            hint: Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                color: Colors.white.withOpacity(0.7),
                fontSize: ResponsiveUtils.getResponsiveFontSize(context, 16.0),
              ),
            ),
            items: items.map((item) {
              String displayText;
              if (isBranch && item is Branch) {
                displayText = item.name;
              } else {
                displayText = item.toString();
              }

              return DropdownMenuItem<T>(
                value: item,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: padding * 0.3,
                    vertical: padding * 0.2,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(padding * 0.3),
                    color: selectedValue == item
                        ? Colors.white.withOpacity(0.1)
                        : Colors.transparent,
                  ),
                  child: Text(
                    displayText,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize:
                          ResponsiveUtils.getResponsiveFontSize(context, 16.0),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        );
      },
      loading: () => Container(
        padding: EdgeInsets.symmetric(
          horizontal: padding * 1.8,
          vertical: padding * 0.6,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(padding * 0.75),
        ),
        child: SizedBox(
          width: ResponsiveUtils.getResponsiveIconSize(context) * 0.8,
          height: ResponsiveUtils.getResponsiveIconSize(context) * 0.8,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      ),
      error: (error, stack) => Container(
        padding: EdgeInsets.symmetric(
          horizontal: padding * 0.5,
          vertical: padding * 0.6,
        ),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.2),
          borderRadius: BorderRadius.circular(padding * 0.75),
        ),
        child: Text(
          '오류',
          style: AppTextStyles.bodyMedium.copyWith(
            color: Colors.white,
            fontSize: ResponsiveUtils.getResponsiveFontSize(context, 12.0),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
