part of 'find_nearby_bloc.dart';

@immutable
final class FindNearbyState {
  const FindNearbyState({this.devices = const [], this.contacts = const []});

  final List<MeshNode> devices;
  final List<ContactModel> contacts;

  FindNearbyState copyWith({
    List<MeshNode>? devices,
    List<ContactModel>? contacts,
  }) =>
      FindNearbyState(
        devices: devices ?? this.devices,
        contacts: contacts ?? this.contacts,
      );
}

final class SuccessfullyAddedContact extends FindNearbyState {
  const SuccessfullyAddedContact({
    required this.contact,
  });

  final ContactModel contact;
}
