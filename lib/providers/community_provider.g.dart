// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$postNotifierHash() => r'4e8d20a740dc1df6617ff29953f92f41dd00de02';

/// See also [PostNotifier].
@ProviderFor(PostNotifier)
final postNotifierProvider =
    AutoDisposeAsyncNotifierProvider<PostNotifier, List<Post>>.internal(
  PostNotifier.new,
  name: r'postNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$postNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PostNotifier = AutoDisposeAsyncNotifier<List<Post>>;
String _$commentNotifierHash() => r'8481c695d2a9a0aa7cb428485adeaa081c12bec6';

/// See also [CommentNotifier].
@ProviderFor(CommentNotifier)
final commentNotifierProvider =
    AutoDisposeAsyncNotifierProvider<CommentNotifier, List<Comment>>.internal(
  CommentNotifier.new,
  name: r'commentNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$commentNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CommentNotifier = AutoDisposeAsyncNotifier<List<Comment>>;
String _$selectedPostNotifierHash() =>
    r'b77a717df6bfb1cc9b8d0ff31fa36451ba94295a';

/// See also [SelectedPostNotifier].
@ProviderFor(SelectedPostNotifier)
final selectedPostNotifierProvider =
    AutoDisposeAsyncNotifierProvider<SelectedPostNotifier, Post?>.internal(
  SelectedPostNotifier.new,
  name: r'selectedPostNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedPostNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedPostNotifier = AutoDisposeAsyncNotifier<Post?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
