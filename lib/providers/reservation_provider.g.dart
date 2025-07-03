// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$reservationNotifierHash() =>
    r'82c4d75c0d9d7bf0e59a592cc4479ccd40e91e8f';

/// See also [ReservationNotifier].
@ProviderFor(ReservationNotifier)
final reservationNotifierProvider = AutoDisposeAsyncNotifierProvider<
    ReservationNotifier, List<Reservation>>.internal(
  ReservationNotifier.new,
  name: r'reservationNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$reservationNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ReservationNotifier = AutoDisposeAsyncNotifier<List<Reservation>>;
String _$spaceNotifierHash() => r'2d1e8eada0ddbeac96ed1b31295651a6e7de1b4c';

/// See also [SpaceNotifier].
@ProviderFor(SpaceNotifier)
final spaceNotifierProvider =
    AutoDisposeAsyncNotifierProvider<SpaceNotifier, List<Space>>.internal(
  SpaceNotifier.new,
  name: r'spaceNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$spaceNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SpaceNotifier = AutoDisposeAsyncNotifier<List<Space>>;
String _$timeSlotNotifierHash() => r'8f932b91744e132cafe2983a40b2e85e4923cbc5';

/// See also [TimeSlotNotifier].
@ProviderFor(TimeSlotNotifier)
final timeSlotNotifierProvider =
    AutoDisposeAsyncNotifierProvider<TimeSlotNotifier, List<TimeSlot>>.internal(
  TimeSlotNotifier.new,
  name: r'timeSlotNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$timeSlotNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TimeSlotNotifier = AutoDisposeAsyncNotifier<List<TimeSlot>>;
String _$selectedDateNotifierHash() =>
    r'f7e8c1451d150aa94db0d8893b9a795ee97721a7';

/// See also [SelectedDateNotifier].
@ProviderFor(SelectedDateNotifier)
final selectedDateNotifierProvider =
    AutoDisposeNotifierProvider<SelectedDateNotifier, DateTime>.internal(
  SelectedDateNotifier.new,
  name: r'selectedDateNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedDateNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedDateNotifier = AutoDisposeNotifier<DateTime>;
String _$selectedSpaceNotifierHash() =>
    r'c1747bea9f7058b225e8ef8ca760fee22febe583';

/// See also [SelectedSpaceNotifier].
@ProviderFor(SelectedSpaceNotifier)
final selectedSpaceNotifierProvider =
    AutoDisposeAsyncNotifierProvider<SelectedSpaceNotifier, Space?>.internal(
  SelectedSpaceNotifier.new,
  name: r'selectedSpaceNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedSpaceNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedSpaceNotifier = AutoDisposeAsyncNotifier<Space?>;
String _$selectedTimeSlotNotifierHash() =>
    r'0704e4739c3e14db4370e155bc46ea78c5949810';

/// See also [SelectedTimeSlotNotifier].
@ProviderFor(SelectedTimeSlotNotifier)
final selectedTimeSlotNotifierProvider = AutoDisposeAsyncNotifierProvider<
    SelectedTimeSlotNotifier, TimeSlot?>.internal(
  SelectedTimeSlotNotifier.new,
  name: r'selectedTimeSlotNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedTimeSlotNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedTimeSlotNotifier = AutoDisposeAsyncNotifier<TimeSlot?>;
String _$userTodayReservationsNotifierHash() =>
    r'9c061f66e3af8400226b8b72bf6cfd5676bef739';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$UserTodayReservationsNotifier
    extends BuildlessAutoDisposeAsyncNotifier<List<Reservation>> {
  late final String userId;

  FutureOr<List<Reservation>> build(
    String userId,
  );
}

/// See also [UserTodayReservationsNotifier].
@ProviderFor(UserTodayReservationsNotifier)
const userTodayReservationsNotifierProvider =
    UserTodayReservationsNotifierFamily();

/// See also [UserTodayReservationsNotifier].
class UserTodayReservationsNotifierFamily
    extends Family<AsyncValue<List<Reservation>>> {
  /// See also [UserTodayReservationsNotifier].
  const UserTodayReservationsNotifierFamily();

  /// See also [UserTodayReservationsNotifier].
  UserTodayReservationsNotifierProvider call(
    String userId,
  ) {
    return UserTodayReservationsNotifierProvider(
      userId,
    );
  }

  @override
  UserTodayReservationsNotifierProvider getProviderOverride(
    covariant UserTodayReservationsNotifierProvider provider,
  ) {
    return call(
      provider.userId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userTodayReservationsNotifierProvider';
}

/// See also [UserTodayReservationsNotifier].
class UserTodayReservationsNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<UserTodayReservationsNotifier,
        List<Reservation>> {
  /// See also [UserTodayReservationsNotifier].
  UserTodayReservationsNotifierProvider(
    String userId,
  ) : this._internal(
          () => UserTodayReservationsNotifier()..userId = userId,
          from: userTodayReservationsNotifierProvider,
          name: r'userTodayReservationsNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userTodayReservationsNotifierHash,
          dependencies: UserTodayReservationsNotifierFamily._dependencies,
          allTransitiveDependencies:
              UserTodayReservationsNotifierFamily._allTransitiveDependencies,
          userId: userId,
        );

  UserTodayReservationsNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  FutureOr<List<Reservation>> runNotifierBuild(
    covariant UserTodayReservationsNotifier notifier,
  ) {
    return notifier.build(
      userId,
    );
  }

  @override
  Override overrideWith(UserTodayReservationsNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: UserTodayReservationsNotifierProvider._internal(
        () => create()..userId = userId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<UserTodayReservationsNotifier,
      List<Reservation>> createElement() {
    return _UserTodayReservationsNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserTodayReservationsNotifierProvider &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserTodayReservationsNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<List<Reservation>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _UserTodayReservationsNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        UserTodayReservationsNotifier,
        List<Reservation>> with UserTodayReservationsNotifierRef {
  _UserTodayReservationsNotifierProviderElement(super.provider);

  @override
  String get userId => (origin as UserTodayReservationsNotifierProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
