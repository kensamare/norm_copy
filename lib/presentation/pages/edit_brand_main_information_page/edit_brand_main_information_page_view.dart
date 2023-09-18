// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/domain/models/brand/brand.dart';
import 'package:norm/internal/page_providers/edit_brand_page/states/edit_brand_state.dart';
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/app_bar/n_app_bar.dart';
import 'package:norm/presentation/global/n_button/n_button.dart';
import 'package:norm/presentation/global/n_dropdown/n_dropdown.dart';
import 'package:norm/presentation/global/n_text_field/n_text_field.dart';
import 'package:norm/presentation/global/n_text_field/n_text_field_done.dart';
import 'package:norm/presentation/global/n_text_field/n_text_field_loader.dart';
import 'package:norm/presentation/global/padded_content/padded_content.dart';

class EditBrandMainInformationPageView extends StatelessWidget {
  const EditBrandMainInformationPageView({super.key});

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return NAppBar(
      title: L10n.of(context)!.mainInformation,
    );
  }

  Widget _buildTitleField(BuildContext context) {
    final EditBrandState state = context.read<EditBrandState>();

    return NTextField(
      initialValue: state.title,
      onChanged: state.setTitle,
      width: double.infinity,
      hintText: 'Никнейм',
    );
  }

  Widget _buildNicknameField(BuildContext context) {
    return Observer(
      builder: (context) {
        final EditBrandState state = context.read<EditBrandState>();

        final bool? successful = state.isNicknameAvailable == null
            ? null
            : state.isNicknameAvailable! && (state.nickname.isNotEmpty) && state.nicknameErrors.isEmpty;

        return NTextField(
          initialValue: state.nickname,
          onChanged: state.setNickname,
          textInputAction: TextInputAction.next,
          width: double.infinity,
          hintText: L10n.of(context)!.username,
          capitalization: TextCapitalization.none,
          successful: successful,
          error: state.nicknameErrors.isNotEmpty,
          errorText: errorMessagesLocalized(context, state.nicknameErrors),
          suffix: state.isLoadingNicknameAvailability
              ? const NTextFieldLoader()
              : ((successful ?? false) ? const NTextFieldDone() : const SizedBox.shrink()),
        );
      },
    );
  }

  Widget _buildCategoryField(BuildContext context) {
    return Observer(
      builder: (context) {
        final EditBrandState state = context.watch<EditBrandState>();

        return NDropdown(
          onManualChanged: (value) {
            state.setCategoryTitle(value);
            state.setCategory(null);

            state.searchBrandCategories();
          },
          onChanged: (value) {
            state.setCategoryTitle(null);
            state.setCategory(value);
          },
          width: double.infinity,
          value: state.category,
          items: state.suggestedBrandCategories
              .map(
                (e) => NDropdownItem(title: e.title, value: e),
              )
              .toList(),
          hint: 'Категория',
          allowManualValues: true,
        );
      },
    );
  }

  Widget _buildLinkField(BuildContext context) {
    final EditBrandState state = context.read<EditBrandState>();

    return NTextField(
      width: double.infinity,
      hintText: 'Сайт',
      onChanged: state.setUrl,
    );
  }

  Widget _buildDescriptionField(BuildContext context) {
    final EditBrandState state = context.read<EditBrandState>();

    return NTextField(
      initialValue: state.description,
      onChanged: state.setDescription,
      width: double.infinity,
      hintText: L10n.of(context)!.addDescription,
      maxLines: 5,
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return Container(
      height: 120.h,
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: Observer(
          builder: (context) {
            final EditBrandState state = context.watch<EditBrandState>();

            return NButton(
              isLoading: state.isSaving,
              active: state.canSave,
              width: MediaQuery.of(context).size.width - 2 * NConstants.sidePadding.w,
              onPressed: () async {
                final Brand? brand = await state.save();

                // Close current screen.
                if (brand != null) await service<AppRouter>().pop(brand);
              },
              title: L10n.of(context)!.save,
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Stack(
      // fit: StackFit.expand,
      alignment: Alignment.bottomCenter,
      children: [
        PaddedContent(
          child: Column(
            children: [
              SizedBox(height: 24.h),
              _buildTitleField(context),
              SizedBox(height: 20.h),
              _buildNicknameField(context),
              SizedBox(height: 20.h),
              _buildCategoryField(context),
              SizedBox(height: 20.h),
              _buildLinkField(context),
              SizedBox(height: 20.h),
              _buildDescriptionField(context),
            ],
          ),
        ),
        _buildSaveButton(context),
      ],
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
