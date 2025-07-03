// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$reservationNotifierHash() =>
    r'88f5d54e844b6e5383b0f63cbfb21827f6ba2ac7';

/// See also [ReservationNotifier].
@ProviderFor(ReservationNotifier)
final reservationNotifierProvider = AutoDisposeNotifierProvider<
    ReservationNotifier, List<Reservation>>.internal(
  ReservationNotifier.new,
  name: r'reservationNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$reservationNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ReservationNotifier = AutoDisposeNotifier<List<Reservation>>;
String _$spaceNotifierHash() => r'8000dbbf00b99b1729ddcd47291ebf08d32bd302';

/// See also [SpaceNotifier].
@ProviderFor(SpaceNotifier)
final spaceNotifierProvider =
    AutoDisposeNotifierProvider<SpaceNotifier, List<Space>>.internal(
  SpaceNotifier.new,
  name: r'spaceNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$spaceNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SpaceNotifier = AutoDisposeNotifier<List<Space>>;
String _$timeSlotNotifierHash() => r'68175f34db41ade1108aa0cfbc294753f7d88592';

/// See also [TimeSlotNotifier].
@ProviderFor(TimeSlotNotifier)
final timeSlotNotifierProvider =
    AutoDisposeNotifierProvider<TimeSlotNotifier, List<TimeSlot>>.internal(
  TimeSlotNotifier.new,
  name: r'timeSlotNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$timeSlotNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TimeSlotNotifier = AutoDisposeNotifier<List<TimeSlot>>;
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
    r'1f83cc64f593aeb6a6a1cfcf7888670b40579ea0';

/// See also [SelectedSpaceNotifier].
@ProviderFor(SelectedSpaceNotifier)
final selectedSpaceNotifierProvider =
    AutoDisposeNotifierProvider<SelectedSpaceNotifier, Space?>.internal(
  SelectedSpaceNotifier.new,
  name: r'selectedSpaceNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedSpaceNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedSpaceNotifier = AutoDisposeNotifier<Space?>;
String _$selectedTimeSlotNotifierHash() =>
    r'00c3154a388aa3ff45e1ec604d77e23c2cba563e';

/// See also [SelectedTimeSlotNotifier].
@ProviderFor(SelectedTimeSlotNotifier)
final selectedTimeSlotNotifierProvider =
    AutoDisposeNotifierProvider<SelectedTimeSlotNotifier, TimeSlot?>.internal(
  SelectedTimeSlotNotifier.new,
  name: r'selectedTimeSlotNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedTimeSlotNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedTimeSlotNotifier = AutoDisposeNotifier<TimeSlot?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
