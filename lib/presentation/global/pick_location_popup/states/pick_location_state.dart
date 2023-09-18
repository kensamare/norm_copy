// Package imports:
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';

// Project imports:
import 'package:norm/internal/states/interfaces/initializable.dart';
import 'package:norm/internal/utils/infrastructure.dart';

part 'pick_location_state.g.dart';

class PickLocationState extends _PickLocationStateBase with _$PickLocationState {
  static const LatLng initialCoordinates = LatLng(55.753816, 37.620446);
}

abstract class _PickLocationStateBase with Store implements Initializable {
  @observable
  GoogleMapController? _controller;

  @observable
  LatLng? position;

  @observable
  String? title;

  @override
  Future<void> initialize() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return;
      }
    }

    // Await for when controller is initialized.
    await Future.delayed(NConstants.aSecond);

    final Position position = await Geolocator.getCurrentPosition();
    this.position = LatLng(position.latitude, position.longitude);

    final CameraUpdate newCameraPosition = CameraUpdate.newLatLng(this.position!);
    _controller!.moveCamera(newCameraPosition);
  }

  void initializeController(GoogleMapController controller) async {
    _controller = controller;

    position = await _controller!.getLatLng(
      const ScreenCoordinate(x: 0, y: 0),
    );
  }

  void setPosition(LatLng value) {
    position = value;
  }
}
