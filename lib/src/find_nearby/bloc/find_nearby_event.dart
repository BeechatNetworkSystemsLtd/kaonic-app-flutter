part of 'find_nearby_bloc.dart';

@immutable
sealed class FindNearbyEvent {}

final class AddContact extends FindNearbyEvent {
  AddContact({required this.contact});

  final String contact;
}

final class _DeviceListUpdated extends FindNearbyEvent {
  _DeviceListUpdated({required this.devices});
  final List<String> devices;
}
