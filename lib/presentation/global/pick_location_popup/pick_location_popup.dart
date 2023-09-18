// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/domain/models/picked_location/picked_location.dart';
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';
import 'package:norm/presentation/global/n_text_field/n_text_field.dart';
import 'package:norm/presentation/global/padded_content/padded_content.dart';
import 'package:norm/presentation/global/pick_location_popup/states/pick_location_state.dart';

class PickLocationPopup extends StatefulWidget {
  const PickLocationPopup({super.key});

  @override
  State<PickLocationPopup> createState() => _PickLocationPopupState();
}

class _PickLocationPopupState extends State<PickLocationPopup> {
  BitmapDescriptor? icon;

  @override
  void initState() {
    initializeMarkerIcon();
    super.initState();
  }

  Future<void> initializeMarkerIcon() async {
    // icon = await BitmapDescriptor.fromAssetImage(const ImageConfiguration(), 'assets/maps/radius.png');
    icon = BitmapDescriptor.fromBytes(
      await getBytesFromAsset('assets/maps/radius.png', 300),
    );
  }

  Widget _buildMap(BuildContext context) {
    return Observer(
      builder: (context) {
        final PickLocationState state = context.watch<PickLocationState>();

        return Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Stack(
              children: [
                Container(color: NColors.gray2),
                GoogleMap(
                  compassEnabled: false,
                  onMapCreated: (controller) => state.initializeController(controller),
                  initialCameraPosition: const CameraPosition(
                    target: PickLocationState.initialCoordinates,
                    zoom: 12.0,
                  ),
                  onCameraMove: (position) => state.setPosition(
                    LatLng(position.target.latitude, position.target.longitude),
                  ),
                  markers: {
                    if (state.position != null)
                      Marker(
                        markerId: MarkerId(state.position.toString()),
                        position: state.position!,
                        icon: icon ?? BitmapDescriptor.defaultMarker,
                      ),
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildActions(BuildContext context) {
    final PickLocationState state = context.read<PickLocationState>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkResponse(
          onTap: () => AutoRouter.of(context).pop(),
          child: const Icon(Icons.close_rounded),
        ),
        Text(
          'Локация',
          style: NTypography.rfDewiBold20.copyWith(height: 1.0),
        ),
        InkResponse(
          onTap: () => AutoRouter.of(context).pop(
            PickedLocation(
              title: '${state.position?.latitude.toStringAsFixed(3)} ${state.position?.longitude.toStringAsFixed(3)}',
              latitude: state.position!.latitude,
              longitude: state.position!.longitude,
            ),
          ),
          child: const Icon(Icons.done_rounded, color: NColors.greenPrimary),
        ),
      ],
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return NTextField(
      height: 40.h,
      width: double.infinity,
      hintText: 'Поиск',
      prefix: NIcon(NIcons.search, size: 20.r),
    );
  }

  Widget _buildContent(BuildContext context) {
    return PaddedContent(
      child: Column(
        children: [
          _buildActions(context),
          SizedBox(height: 16.h),
          Text(
            'Укажите локацию, в которой вы ищете помощь. Если нужна онлайн услуга, не указывайте локацию',
            style: NTypography.golosRegular16.copyWith(color: NColors.graySecondaryText),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          _buildSearchField(context),
          SizedBox(height: 16.h),
          _buildMap(context),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PickLocationState()..initialize(),
      builder: (context, _) => SizedBox(
        height: MediaQuery.of(context).size.height - 64.h - kToolbarHeight,
        child: _buildContent(context),
      ),
    );
  }
}
