import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/branch.dart';
import '../models/space.dart';
import '../models/reservation.dart';
import '../models/community.dart';
import '../utils/fake_data.dart';

// 모든 지점 목록
final branchesProvider = Provider<List<Branch>>((ref) {
  return FakeData.branches;
});

// 활성화된 지점 목록
final activeBranchesProvider = Provider<List<Branch>>((ref) {
  final branches = ref.watch(branchesProvider);
  return branches.where((branch) => branch.isActive).toList();
});

// 선택된 지점
final selectedBranchProvider = StateProvider<Branch?>((ref) {
  final branches = ref.watch(activeBranchesProvider);
  return branches.isNotEmpty ? branches.first : null;
});

// 지점별 공간 목록
final branchSpacesProvider =
    Provider.family<List<Space>, String>((ref, branchId) {
  final spaces = ref.watch(spacesProvider);
  return spaces.where((space) => space.branchId == branchId).toList();
});

// 공간 목록 프로바이더
final spacesProvider = Provider<List<Space>>((ref) {
  return FakeData.spaces;
});

// 지점별 예약 목록
final branchReservationsProvider =
    Provider.family<List<Reservation>, String>((ref, branchId) {
  final reservations = ref.watch(reservationsProvider);
  return reservations
      .where((reservation) => reservation.branchId == branchId)
      .toList();
});

// 예약 목록 프로바이더
final reservationsProvider = Provider<List<Reservation>>((ref) {
  return FakeData.reservations;
});

// 지점별 커뮤니티 게시글
final branchPostsProvider =
    Provider.family<List<Post>, String?>((ref, branchId) {
  final posts = ref.watch(postsProvider);
  if (branchId == null) {
    return posts.where((post) => post.branchId == null).toList();
  }
  return posts.where((post) => post.branchId == branchId).toList();
});

// 커뮤니티 게시글 프로바이더
final postsProvider = Provider<List<Post>>((ref) {
  return FakeData.posts;
});
