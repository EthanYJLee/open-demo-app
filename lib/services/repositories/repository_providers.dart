import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'reservation_repository.dart';
import 'space_repository.dart';
import 'post_repository.dart';
import 'profile_repository.dart';
import 'branch_repository.dart';
import 'layout_repository.dart';

// Repository Providers
final reservationRepositoryProvider = Provider<ReservationRepository>((ref) {
  return ReservationRepository();
});

final spaceRepositoryProvider = Provider<SpaceRepository>((ref) {
  return SpaceRepository();
});

final postRepositoryProvider = Provider<PostRepository>((ref) {
  return PostRepository();
});

final commentRepositoryProvider = Provider<CommentRepository>((ref) {
  return CommentRepository();
});

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository();
});

final branchRepositoryProvider = Provider<BranchRepository>((ref) {
  return BranchRepository();
});

final layoutRepositoryProvider = Provider<LayoutRepository>((ref) {
  return LayoutRepository();
});
