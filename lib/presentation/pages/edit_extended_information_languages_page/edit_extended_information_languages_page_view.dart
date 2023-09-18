// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/domain/models/language/language.dart';
import 'package:norm/internal/page_providers/edit_extended_information_page/states/edit_extended_information_state.dart';
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/app_bar/n_app_bar.dart';
import 'package:norm/presentation/global/confirm_action_popup/confirm_action_popup.dart';
import 'package:norm/presentation/global/confirm_action_popup/widgets/confirm_action.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';
import 'package:norm/presentation/global/language_wrapper/language_wrapper.dart';
import 'package:norm/presentation/pages/edit_extended_information_languages_page/widgets/add_language_popup.dart';

class EditExtendedInformationLanguagesPageView extends StatelessWidget {
  const EditExtendedInformationLanguagesPageView({super.key});

  void openLanguagesPopup(BuildContext context, [Language? editLanguage]) async {
    final EditExtendedInformationState state = context.read<EditExtendedInformationState>();
    final Language? language = await service<AppRouter>().showBottomSheet(
      context,
      AddLanguagePopup(
        language: editLanguage,
        languages: context.read<EditExtendedInformationState>().languages,
      ),
    );

    if (language != null) {
      state.addLanguage(language);
    }
  }

  void openDeletePopup(BuildContext context, Language language) {
    final EditExtendedInformationState state = context.read<EditExtendedInformationState>();

    service<AppRouter>().showBottomSheet(
      context,
      ConfirmActionPopup(
        title: 'Вы уверены, что хотите удалить язык?',
        confirmWidget: ConfirmAction(
          title: 'Удалить',
          onTap: () {
            state.deleteLanguage(language);
            AutoRouter.of(context).pop();
          },
        ),
        cancelWidget: ConfirmAction(title: 'Отмена', inverted: true),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return NAppBar(
      title: L10n.of(context)!.languages,
      actions: [
        _buildAddButton(context),
      ],
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return GestureDetector(
      onTap: () => openLanguagesPopup(context),
      child: NIcon(NIcons.add),
    );
  }

  Widget _buildEmptyLanguages(BuildContext context) {
    return GestureDetector(
      onTap: () => openLanguagesPopup(context),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 24.h),
            Container(
              height: 48.r,
              width: 48.r,
              decoration: const BoxDecoration(color: NColors.gray2, shape: BoxShape.circle),
              child: Center(
                child: NIcon(NIcons.add, size: 20.r),
              ),
            ),
            SizedBox(height: 16.h),
            Text(L10n.of(context)!.add, style: NTypography.golosRegular14),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Observer(
      builder: (context) {
        final EditExtendedInformationState state = context.watch<EditExtendedInformationState>();

        if (state.user == null) return const SizedBox.shrink();

        if (state.user!.languages.isEmpty) {
          return _buildEmptyLanguages(context);
        }

        return ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: NConstants.sidePadding.w, vertical: 16.h),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final Language language = state.user!.languages.elementAt(index);
            return LanguageWrapper(
              onDelete: () => openDeletePopup(context, language),
              onEdit: () => openLanguagesPopup(context, language),
              language: language,
            );
          },
          itemCount: state.user!.languages.length,
          separatorBuilder: (_, __) => SizedBox(
            height: 48.h,
            child: Center(
              child: Container(height: 1.r, color: NColors.gray2),
            ),
          ),
        );
      },
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
