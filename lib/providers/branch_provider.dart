import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/branch.dart';
import '../models/space.dart';
import '../models/reservation.dart';
import '../models/community.dart';
import '../services/repositories/repository_providers.dart';

// 모든 지점 목록
final branchesProvider = FutureProvider<List<Branch>>((ref) async {
  try {
    final repository = ref.read(branchRepositoryProvider);
    return await repository.getAll();
  } catch (e) {
    return [];
  }
});

// 활성화된 지점 목록
final activeBranchesProvider = FutureProvider<List<Branch>>((ref) async {
  try {
    final repository = ref.read(branchRepositoryProvider);
    return await repository.getActiveBranches();
  } catch (e) {
    return [];
  }
});

// 시/구별 지점 목록 (DB에서 필터링)
final branchesByCityDistrictProvider =
    FutureProvider.family<List<Branch>, ({String city, String district})>(
        (ref, params) async {
  try {
    final repository = ref.read(branchRepositoryProvider);
    final city = params.city;
    final district = params.district;

    // 빈 값이면 빈 리스트 반환
    if (city.isEmpty || district.isEmpty) {
      return [];
    }

    return await repository.getByCityAndDistrict(city, district);
  } catch (e) {
    return [];
  }
});

// 선택된 지점
final selectedBranchProvider = StateProvider<Branch?>((ref) {
  final branchesAsync = ref.watch(activeBranchesProvider);
  return branchesAsync.when(
    data: (branches) => branches.isNotEmpty ? branches.first : null,
    loading: () => null,
    error: (_, __) => null,
  );
});

// 지점별 공간 목록
final branchSpacesProvider =
    FutureProvider.family<List<Space>, String>((ref, branchId) async {
  final repository = ref.read(spaceRepositoryProvider);
  return await repository.getByBranchId(branchId);
});

// 공간 목록 프로바이더
final spacesProvider = FutureProvider<List<Space>>((ref) async {
  try {
    final repository = ref.read(spaceRepositoryProvider);
    return await repository.getAll();
  } catch (e) {
    return [];
  }
});

// 예약 목록 프로바이더
final reservationsProvider = FutureProvider<List<Reservation>>((ref) async {
  try {
    final repository = ref.read(reservationRepositoryProvider);
    return await repository.getAll();
  } catch (e) {
    return [];
  }
});

// 지점별 예약 목록
final branchReservationsProvider =
    FutureProvider.family<List<Reservation>, String>((ref, branchId) async {
  final repository = ref.read(reservationRepositoryProvider);
  return await repository.getByBranchId(branchId);
});

// 커뮤니티 게시글 프로바이더
final postsProvider = FutureProvider<List<Post>>((ref) async {
  try {
    final repository = ref.read(postRepositoryProvider);
    return await repository.getAll();
  } catch (e) {
    return [];
  }
});

// 지점별 커뮤니티 게시글
final branchPostsProvider =
    FutureProvider.family<List<Post>, String?>((ref, branchId) async {
  final repository = ref.read(postRepositoryProvider);
  return await repository.getByBranchId(branchId);
});

class PostsNotifier extends AsyncNotifier<List<Post>> {
  @override
  Future<List<Post>> build() async {
    final repository = ref.read(postRepositoryProvider);
    return await repository.getAll();
  }
}
