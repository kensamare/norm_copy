// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/domain/models/brand/brand.dart';
import 'package:norm/domain/models/interfaces/profile.dart';
import 'package:norm/internal/page_providers/brand_page/states/brand_state.dart';
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/presentation/global/divider/n_horizontal_divider.dart';
import 'package:norm/presentation/pages/brand_page/widgets/brand_page_about.dart';
import 'package:norm/presentation/pages/brand_page/widgets/brand_page_actions.dart';
import 'package:norm/presentation/pages/brand_page/widgets/brand_page_app_bar.dart';
import 'package:norm/presentation/pages/brand_page/widgets/brand_page_header.dart';
import 'package:norm/presentation/pages/brand_page/widgets/brand_page_tabs.dart';

class BrandPageView extends StatelessWidget {
  const BrandPageView({
    super.key,
    this.fromProfile,
  });

  /// Parent profile route.
  final Profile? fromProfile;

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final BrandState state = context.read<BrandState>();

    return BrandPageAppBar(
      fromProfile: fromProfile,
      my: state.brand!.my,
      nickname: state.brand!.nickname,
    );
  }

  Widget _buildBrandHeader(BuildContext context) {
    return Observer(
      builder: (context) {
        final BrandState state = context.watch<BrandState>();
        final Brand? brand = state.brand;

        if (brand == null) return const SizedBox.shrink();

        return BrandPageHeader(
          avatar: brand.avatar250 ?? brand.avatar,
          title: brand.title,
          reputation: brand.reputation,
          followers: brand.followers,
          category: brand.category,
        );
      },
    );
  }

  Widget _buildActions(BuildContext context) {
    return Observer(
      builder: (context) {
        final BrandState state = context.watch<BrandState>();
        final Brand? brand = state.brand;

        if (brand == null) return const SizedBox.shrink();

        return BrandPageActions(
          contacts: brand.contacts,
          my: brand.my,
          blocked: brand.blocked,
          followed: brand.followed,
          onFollow: state.follow,
          onUnfollow: state.unfollow,
          onEdit: () async {
            final Brand? editedBrand = await service<AppRouter>().goToEditBrandPage(brand: brand);

            if (editedBrand != null) {
              state.updateBrand(editedBrand);
            }
          },
          onEditContacts: () async {
            final Brand? editedBrand = await service<AppRouter>().jumpToEditBrandContactsPage(brand: brand);

            if (editedBrand != null) {
              state.updateBrand(editedBrand);
            }
          },
        );
      },
    );
  }

  Widget _buildTabs(BuildContext context) {
    return BrandPageTabs();
  }

  Widget _buildBrandInformation(BuildContext context) {
    final BrandState state = context.watch<BrandState>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8.h),
        _buildBrandHeader(context),
        SizedBox(height: 16.h),
        if (!state.brand!.my && (state.brand?.about.isBlank ?? true))
          const SizedBox.shrink()
        else ...[
          _buildAbout(context),
          SizedBox(height: 16.h),
        ],
        _buildActions(context),
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget _buildAbout(BuildContext context) {
    return Observer(
      builder: (context) {
        final BrandState state = context.watch<BrandState>();
        final Brand? brand = state.brand;

        if (brand == null) return const SizedBox.shrink();

        return BrandPageAbout(
          about: brand.about,
          onTapAddDescription: () => service<AppRouter>().jumpToEditBrandMainInformationPage(brand: brand),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    return SafeArea(
      child: Observer(
        builder: (context) {
          final BrandState state = context.watch<BrandState>();

          if (state.isLoadingBrand) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }

          final List<Widget> widgets = [
            _buildBrandInformation(context),
            _buildTabs(context),

            // _buildSpecs(context),
            // _buildExtendedInformation(context),
            // _buildPublications(context),
          ];

          return ListView.separated(
            itemBuilder: (context, index) => widgets[index],
            separatorBuilder: (_, __) => const NHorizontalDivider(),
            itemCount: widgets.length,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final BrandState state = context.watch<BrandState>();

        return Scaffold(
          appBar: state.isLoadingBrand ? null : _buildAppBar(context),
          body: _buildContent(context),
        );
      },
    );
  }
}
