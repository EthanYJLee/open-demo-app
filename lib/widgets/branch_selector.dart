import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/branch.dart';
import '../providers/branch_provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class BranchSelector extends ConsumerWidget {
  const BranchSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final branches = ref.watch(activeBranchesProvider);
    final selectedBranch = ref.watch(selectedBranchProvider);

    if (branches.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.location_on,
            color: Colors.white,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<Branch>(
                value: selectedBranch,
                dropdownColor: AppColors.primaryDark,
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                ),
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                items: branches.map((branch) {
                  return DropdownMenuItem<Branch>(
                    value: branch,
                    child: Text(
                      branch.name,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (Branch? newValue) {
                  if (newValue != null) {
                    ref.read(selectedBranchProvider.notifier).state = newValue;
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
