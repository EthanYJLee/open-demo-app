// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$postNotifierHash() => r'be068c9a5b2f5e9e22cb7ee1cb82229f8d85149f';

/// See also [PostNotifier].
@ProviderFor(PostNotifier)
final postNotifierProvider =
    AutoDisposeNotifierProvider<PostNotifier, List<Post>>.internal(
  PostNotifier.new,
  name: r'postNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$postNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PostNotifier = AutoDisposeNotifier<List<Post>>;
String _$commentNotifierHash() => r'5f75a9e648d08da978d7977ee85b5e0e38349226';

/// See also [CommentNotifier].
@ProviderFor(CommentNotifier)
final commentNotifierProvider =
    AutoDisposeNotifierProvider<CommentNotifier, List<Comment>>.internal(
  CommentNotifier.new,
  name: r'commentNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$commentNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CommentNotifier = AutoDisposeNotifier<List<Comment>>;
String _$selectedPostNotifierHash() =>
    r'e1c8cac4604ec42aca15af60708305db832be638';

/// See also [SelectedPostNotifier].
@ProviderFor(SelectedPostNotifier)
final selectedPostNotifierProvider =
    AutoDisposeNotifierProvider<SelectedPostNotifier, Post?>.internal(
  SelectedPostNotifier.new,
  name: r'selectedPostNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedPostNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedPostNotifier = AutoDisposeNotifier<Post?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
