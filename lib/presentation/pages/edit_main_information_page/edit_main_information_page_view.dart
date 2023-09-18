// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/internal/page_providers/edit_main_information_page/states/edit_main_information_state.dart';
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/app_bar/n_app_bar.dart';
import 'package:norm/presentation/global/n_button/n_button.dart';
import 'package:norm/presentation/global/n_text_field/n_text_field.dart';
import 'package:norm/presentation/global/n_text_field/n_text_field_done.dart';
import 'package:norm/presentation/global/n_text_field/n_text_field_loader.dart';
import 'package:norm/presentation/global/pin_code_field/pin_code_field.dart';

class EditMainInformationPageView extends StatefulWidget {
  const EditMainInformationPageView({super.key});

  @override
  State<EditMainInformationPageView> createState() => _EditMainInformationPageViewState();
}

class _EditMainInformationPageViewState extends State<EditMainInformationPageView> {
  late TextEditingController _emailController;
  late TextEditingController _loginController;

  @override
  void initState() {
    final EditMainInformationState state = context.read<EditMainInformationState>();

    _emailController = TextEditingController(text: state.email);
    _loginController = TextEditingController(text: state.nickname);

    super.initState();
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return NAppBar(
      title: L10n.of(context)!.mainInformation,
    );
  }

  Widget _buildNameField(BuildContext context) {
    final EditMainInformationState state = context.read<EditMainInformationState>();

    return Expanded(
      child: NTextField(
        initialValue: state.name,
        onChanged: state.setName,
        width: double.infinity,
        hintText: L10n.of(context)!.name,
        capitalization: TextCapitalization.sentences,
        keyboardType: TextInputType.name,
      ),
    );
  }

  Widget _buildSurnameField(BuildContext context) {
    final EditMainInformationState state = context.read<EditMainInformationState>();

    return Expanded(
      child: NTextField(
        initialValue: state.surname,
        onChanged: state.setSurname,
        width: double.infinity,
        hintText: L10n.of(context)!.surname,
        capitalization: TextCapitalization.words,
        keyboardType: TextInputType.name,
      ),
    );
  }

  Widget _buildPinField(BuildContext context) {
    return PinCodeField(
      onChanged: (_) {},
      autofocus: false,
    );
  }

  Widget _buildEmailField(BuildContext context) {
    return Observer(
      builder: (context) {
        final EditMainInformationState state = context.read<EditMainInformationState>();

        final bool? successful = state.isEmailAvailable == null
            ? null
            : state.isEmailAvailable! && (state.email.isNotEmpty) && state.emailErrors.isEmpty;

        return Column(
          children: [
            NTextField(
              controller: _emailController,
              capitalization: TextCapitalization.none,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              onChanged: state.setEmail,
              onSubmitted: (_) => state.getEmailAvailability(),
              width: double.infinity,
              hintText: L10n.of(context)!.email,
              successful: successful,
              error: state.emailErrors.isNotEmpty,
              errorText: errorMessagesLocalized(context, state.emailErrors),
              suffix: state.isLoadingEmailAvailability
                  ? const NTextFieldLoader()
                  : ((successful ?? false) ? const NTextFieldDone() : const SizedBox.shrink()),
            ),
            // SizedBox(height: 20.h),
            // _buildPinField(context),
            // SizedBox(height: 20.h),
            // GestureDetector(
            //   child: Text(
            //     'Получить код',
            //     style: NTypography.golosRegular14.copyWith(color: NColors.bluePrimary),
            //   ),
            // ),
          ],
        );
      },
    );
  }

  Widget _buildLoginField(BuildContext context) {
    return Observer(
      builder: (context) {
        final EditMainInformationState state = context.read<EditMainInformationState>();

        final bool? successful = state.isNicknameAvailable == null
            ? null
            : state.isNicknameAvailable! && (state.nickname.isNotEmpty) && state.nicknameErrors.isEmpty;

        return NTextField(
          initialValue: state.nickname,
          controller: _loginController,
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

  Widget _buildDescriptionField(BuildContext context) {
    return NTextField(
      initialValue: context.read<EditMainInformationState>().description,
      onChanged: context.read<EditMainInformationState>().setDescription,
      width: double.infinity,
      hintText: L10n.of(context)!.addDescription,
      maxLines: 5,
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return Container(
      height: 100.h,
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: Observer(
          builder: (context) {
            final EditMainInformationState state = context.watch<EditMainInformationState>();
            return NButton(
              isLoading: state.isSaving,
              active: state.canSave,
              width: MediaQuery.of(context).size.width - 2 * NConstants.sidePadding.w,
              onPressed: () async {
                await state.getEmailAvailability();
                await state.save();

                // Close current screen.
                await service<AppRouter>().pop();
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
      fit: StackFit.expand,
      children: [
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: NConstants.sidePadding.w),
          child: Column(
            children: [
              SizedBox(height: 32.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildNameField(context),
                  SizedBox(width: 16.w),
                  _buildSurnameField(context),
                ],
              ),
              SizedBox(height: 20.h),
              _buildLoginField(context),
              SizedBox(height: 20.h),
              _buildEmailField(context),
              SizedBox(height: 32.h),
              _buildDescriptionField(context),
              SizedBox(height: 20.h),
              SizedBox(height: 124.h),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: _buildSaveButton(context),
        ),
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
