// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/domain/models/picked_location/picked_location.dart';
import 'package:norm/internal/page_providers/create_portfolio_page/states/create_portfolio_state.dart';
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/app_bar/n_app_bar.dart';
import 'package:norm/presentation/global/divider/n_horizontal_divider.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';
import 'package:norm/presentation/global/n_button/n_button.dart';
import 'package:norm/presentation/global/n_text_field/n_text_field.dart';
import 'package:norm/presentation/global/padded_content/padded_content.dart';
import 'package:norm/presentation/global/pick_image_popup/state/pick_image_state.dart';
import 'package:norm/presentation/global/pick_location_button/pick_location_button.dart';

class CreatePortfolioPageView extends StatelessWidget {
  const CreatePortfolioPageView({super.key});

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return NAppBar(
      title: 'Портфолио',
    );
  }

  Widget _buildPickImagesButton(BuildContext context) {
    final CreatePortfolioState state = context.read<CreatePortfolioState>();

    return InkWell(
      borderRadius: BorderRadius.circular(8.r),
      onTap: () async {
        final PickImageResult result = await service<AppRouter>().showPickImagePopup(
          context,
          multiple: true,
          canDelete: state.photos.isNotEmpty,
        );

        state.handleImagePickResult(result);
      },
      child: Observer(
        builder: (context) {
          return Ink(
            height: 96.r,
            width: 96.r,
            decoration: BoxDecoration(
              color: NColors.gray2,
              borderRadius: BorderRadius.circular(8.r),
              image: state.photos.isEmpty
                  ? null
                  : DecorationImage(
                      image: CachedNetworkImageProvider(state.photos.first),
                      fit: BoxFit.cover,
                    ),
            ),
            child: state.isLoadingImages
                ? const CupertinoActivityIndicator()
                : state.photos.isEmpty
                    ? Center(
                        child: NIcon(NIcons.camera, color: NColors.gray),
                      )
                    : null,
          );
        },
      ),
    );
  }

  Widget _buildDescriptionField(BuildContext context) {
    final CreatePortfolioState state = context.read<CreatePortfolioState>();

    return Flexible(
      child: TextField(
        onChanged: state.setDescription,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Описание',
          hintStyle: NTypography.golosRegular14.copyWith(color: NColors.gray),
          contentPadding: EdgeInsets.zero,
        ),
        style: NTypography.golosRegular14,
        maxLines: 4,
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SizedBox(
      height: 128.h,
      child: Padding(
        padding: EdgeInsets.only(top: 16.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPickImagesButton(context),
            SizedBox(width: 16.w),
            _buildDescriptionField(context),
          ],
        ),
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Container(
      color: NColors.white,
      height: 112.h,
      child: Row(
        children: [
          Expanded(
            child: NButton(
              title: 'Отмена',
              onPressed: () => AutoRouter.of(context).pop(),
              inverted: true,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Observer(
              builder: (context) {
                final CreatePortfolioState state = context.watch<CreatePortfolioState>();

                return NButton(
                  title: 'Поделиться',
                  onPressed: () => AutoRouter.of(context).pop(
                    state.portfolio(),
                  ),
                  active: state.canAdd,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleField(BuildContext context) {
    final CreatePortfolioState state = context.read<CreatePortfolioState>();

    return NTextField(
      onChanged: state.setTitle,
      prefix: SizedBox(
        width: 24.r,
        child: Text('Aa', style: NTypography.rfDewiRegular14),
      ),
      height: 56.h,
      width: double.infinity,
      hintText: 'Название',
      transparentFill: true,
      disableHorizontalPadding: true,
    );
  }

  Widget _buildPositionButton(BuildContext context) {
    return Observer(
      builder: (context) {
        final CreatePortfolioState state = context.watch<CreatePortfolioState>();

        return PickLocationButton(
          onChanged: state.setPosition,
          title: state.position?.title,
        );
      },
    );

    // return NTextField(
    //   onTap: () async {
    //     final CreatePortfolioState state = context.read<CreatePortfolioState>();
    //     final PickedLocation? position = await service<AppRouter>().openPickLocationPopup(context);

    //     if (position != null) {
    //       state.setPosition(position);
    //     }
    //   },
    //   prefix: NIcon(NIcons.location),
    //   height: 56.h,
    //   width: double.infinity,
    //   hintText: 'Добавить местоположение',
    //   transparentFill: true,
    //   disableHorizontalPadding: true,
    // );
  }

  Widget _buildLinkField(BuildContext context) {
    final CreatePortfolioState state = context.read<CreatePortfolioState>();

    return NTextField(
      onChanged: state.setLink,
      height: 56.h,
      prefix: NIcon(NIcons.link),
      width: double.infinity,
      hintText: 'https://',
      transparentFill: true,
      disableHorizontalPadding: true,
    );
  }

  Widget _buildContent(BuildContext context) {
    return PaddedContent(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              _buildHeader(context),
              NHorizontalDivider(height: 1.r),
              _buildTitleField(context),
              NHorizontalDivider(height: 1.r),
              _buildPositionButton(context),
              NHorizontalDivider(height: 1.r),
              _buildLinkField(context),
              NHorizontalDivider(height: 1.r),
            ],
          ),
          _buildActions(context),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildContent(context),
    );
  }
}
