// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/domain/models/speciality/speciality.dart';
import 'package:norm/internal/page_providers/create_brand_page/states/create_brand_state.dart';
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/app_bar/n_app_bar.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';
import 'package:norm/presentation/global/n_button/n_button.dart';
import 'package:norm/presentation/global/n_dropdown/n_dropdown.dart';
import 'package:norm/presentation/global/n_text_field/n_text_field.dart';
import 'package:norm/presentation/global/n_text_field/n_text_field_done.dart';
import 'package:norm/presentation/global/n_text_field/n_text_field_loader.dart';
import 'package:norm/presentation/global/padded_content/padded_content.dart';
import 'package:norm/presentation/global/pick_image_popup/state/pick_image_state.dart';
import 'package:norm/presentation/global/user_avatar/user_avatar.dart';

class CreateBrandPageView extends StatefulWidget {
  const CreateBrandPageView({super.key});

  @override
  State<CreateBrandPageView> createState() => _CreateBrandPageViewState();
}

class _CreateBrandPageViewState extends State<CreateBrandPageView> {
  static final DateTime startDate = DateTime.fromMillisecondsSinceEpoch(0);
  static final DateTime endDate = DateTime.now();

  final TextEditingController _yearController = TextEditingController();

  AppRouter get router => service<AppRouter>();

  Future<void> pickImage(BuildContext context) async {
    final CreateBrandState state = context.read<CreateBrandState>();
    final PickImageResult result = await router.showPickImagePopup(
      context,
      canDelete: !context.read<CreateBrandState>().image.isBlank,
    );

    state.handleImagePickResult(result);
  }

  void pickYear() async {
    final CreateBrandState state = context.read<CreateBrandState>();
    final DateTime? date =
        await showDatePicker(context: context, initialDate: endDate, firstDate: startDate, lastDate: endDate);

    if (date != null) {
      state.setYear(date.year);
      _yearController.value = TextEditingValue(text: '${date.year} г.');
    }
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return NAppBar(title: 'Новый бренд');
  }

  Widget _buildSaveButton(BuildContext context) {
    return Observer(
      builder: (context) {
        final CreateBrandState state = context.watch<CreateBrandState>();

        return NButton(
          onPressed: () async {
            final Speciality? speciality = await state.createBrand();

            if (speciality != null) {
              router.popUntilRoot();
              router.handleSpecialityRoute(speciality);
            }
          },
          title: 'Добавить',
          width: double.infinity,
          active: state.canAdd,
        );
      },
    );
  }

  Widget _buildTitleField(BuildContext context) {
    return NTextField(
      onChanged: (value) => context.read<CreateBrandState>().setTitle(value),
      width: double.infinity,
      hintText: 'Название',
    );
  }

  Widget _buildNicknameField(BuildContext context) {
    return Observer(
      builder: (context) {
        final CreateBrandState state = context.watch<CreateBrandState>();

        final bool? successful = state.isNicknameAvailable == null
            ? null
            : state.isNicknameAvailable! && (!state.nickname.isBlank) && state.nicknameErrors.isEmpty;

        return NTextField(
          initialValue: state.nickname,
          // controller: _loginController,
          onChanged: state.setUsername,
          textInputAction: TextInputAction.next,
          capitalization: TextCapitalization.none,
          width: double.infinity,
          hintText: L10n.of(context)!.nickname,
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
        final CreateBrandState state = context.watch<CreateBrandState>();

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
          value: null,
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

  Widget _buildDateField(BuildContext context) {
    return NTextField(
      controller: _yearController,
      onTap: pickYear,
      hintText: 'Дата основания',
      width: double.infinity,
      suffix: NIcon(NIcons.calendar),
    );
  }

  Widget _buildImagePicker(BuildContext context) {
    return GestureDetector(
      onTap: () => pickImage(context),
      child: Observer(
        builder: (context) {
          final CreateBrandState state = context.watch<CreateBrandState>();

          return Row(
            children: [
              if (state.image.isBlank && !state.isLoadingImage)
                Container(
                  height: 64.r,
                  width: 64.r,
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: NColors.gray2),
                  child: Center(
                    child: NIcon(NIcons.gallery_add),
                  ),
                )
              else
                UserAvatar(
                  imageUrl: state.isLoadingImage ? null : state.image,
                  isLoading: state.isLoadingImage,
                  size: 64.r,
                ),
              SizedBox(width: 16.w),
              Text(
                L10n.of(context)!.uploadPhoto,
                style: NTypography.golosRegular14,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return PaddedContent(
      child: Column(
        children: [
          SizedBox(height: 24.h),
          _buildTitleField(context),
          SizedBox(height: 20.h),
          _buildNicknameField(context),
          SizedBox(height: 20.h),
          _buildCategoryField(context),
          SizedBox(height: 20.h),
          _buildDateField(context),
          SizedBox(height: 40.h),
          _buildImagePicker(context),
          SizedBox(height: 40.h),
          _buildSaveButton(context),
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
