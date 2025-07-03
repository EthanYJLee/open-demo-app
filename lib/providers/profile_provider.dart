import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/profile.dart';
import '../services/repositories/repository_providers.dart';

final currentProfileProvider = FutureProvider<Profile?>((ref) async {
  const userId = '00000000-0000-4000-8000-000000000001'; // 김기도 사용자의 UUID

  try {
    final repository = ref.read(profileRepositoryProvider);

    // 프로필 조회
    final profile = await repository.getById(userId);

    if (profile != null) {
      return profile;
    } else {
      // 프로필이 없으면 생성
      final newProfile = await repository.getOrCreateProfile(
        userId,
        '김기도',
        'pray@example.com',
      );
      return newProfile;
    }
  } catch (e) {
    print('Error fetching profile: $e');
    return null;
  }
});
